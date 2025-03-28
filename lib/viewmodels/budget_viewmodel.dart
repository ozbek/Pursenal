import 'package:collection/collection.dart';
import 'package:flutter/foundation.dart';
import 'package:pursenal/app/extensions/datetime.dart';
import 'package:pursenal/app/global/values.dart';
import 'package:pursenal/core/db/database.dart';
import 'package:pursenal/core/enums/budget_interval.dart';
import 'package:pursenal/core/enums/loading_status.dart';
import 'package:pursenal/core/models/budget_plan.dart';
import 'package:pursenal/core/models/daily_total_transaction.dart';
import 'package:pursenal/core/models/double_entry.dart';
import 'package:pursenal/core/repositories/accounts_drift_repository.dart';
import 'package:pursenal/core/repositories/budgets_drift_repository.dart';
import 'package:pursenal/core/repositories/transactions_drift_repository.dart';
import 'package:pursenal/utils/app_logger.dart';

class BudgetViewmodel extends ChangeNotifier {
  final AccountsDriftRepository _accountsDriftRepository;
  final BudgetsDriftRepository _budgetsDriftRepository;
  final TransactionsDriftRepository _transactionsDriftRepository;

  BudgetViewmodel({
    required MyDatabase db,
    required Profile profile,
    required BudgetPlan budgetPlan,
  })  : _profile = profile,
        _budgetPlan = budgetPlan,
        _accountsDriftRepository = AccountsDriftRepository(db),
        _transactionsDriftRepository = TransactionsDriftRepository(db),
        _budgetsDriftRepository = BudgetsDriftRepository(db);

  LoadingStatus loadingStatus = LoadingStatus.idle;

  BudgetPlan _budgetPlan;
  // ignore: unnecessary_getters_setters
  BudgetPlan get budgetPlan => _budgetPlan;

  List<DailyTotalTransaction> _dailyTotalTransactions = [];

  List<DailyTotalTransaction> get dailyTotalTransactions =>
      _dailyTotalTransactions;

  Map<Account, int> expenseTotals = {};
  Map<Account, int> incomeTotals = {};

  List<Account> _expenses = [];
  List<Account> _incomes = [];
  final List<Account> _funds = [];
  List<Account> get funds => _funds;

  set budgetPlan(BudgetPlan value) => _budgetPlan = value;

  final Profile _profile;

  String errorText = "";

  List<DoubleEntry> _transactions = [];

  List<Account> expenses = [];
  List<Account> incomes = [];

  List<DateTime> rangeDates = [];

  Map<int, int> selectedIncomes = {};
  Map<int, int> selectedExpenses = {};
  Set<int> selectedFunds = {};

  int bExpenseTotal = 0;
  int bIncomeTotal = 0;
  int bDifference = 0;

  int aExpenseTotal = 0;
  int aIncomeTotal = 0;
  int aDifference = 0;

  int expectedAvgExp = 0;
  int expectedAvgInc = 0;
  int expectedAvgDif = 0;

  bool isWarningAlerted = false;

  final DateTime today = DateTime.now();

  void init() async {
    loadingStatus = LoadingStatus.loading;
    try {
      await getAccounts();
      await _calculateDifference();
      await _getTransactions();
      await _calculateTotalTransactions();
      loadingStatus = LoadingStatus.completed;
      notifyListeners();
    } catch (e, stackTrace) {
      AppLogger.instance.error(' ${e.toString()}', [stackTrace]);
      errorText = 'Error: Failed to initialise Budget form';
      loadingStatus = LoadingStatus.error;
      notifyListeners();
    }
  }

  refetchBudget() async {
    try {
      loadingStatus = LoadingStatus.loading;
      budgetPlan = await _budgetsDriftRepository
          .getBudgetPlanByID(_budgetPlan.budget.id);
      notifyListeners();
      init();
    } catch (e) {
      AppLogger.instance.error(' ${e.toString()}');
      loadingStatus = LoadingStatus.error;
      errorText = 'Error: Failed to Load budget plan';
    }
  }

  getAccounts() async {
    expenses =
        await _accountsDriftRepository.getAccountsByAccType(_profile.id, 5);
    incomes =
        await _accountsDriftRepository.getAccountsByAccType(_profile.id, 4);

    int accType = 0;
    do {
      funds.addAll(await _accountsDriftRepository.getAccountsByAccType(
          _profile.id, accType));
      accType++;
    } while (fundingAccountIDs.contains(accType));

    _expenses =
        await _accountsDriftRepository.getAccountsByAccType(_profile.id, 5);
    _incomes =
        await _accountsDriftRepository.getAccountsByAccType(_profile.id, 4);

    notifyListeners();
  }

  _getTransactions() async {
    DateTime startDate = DateTime(
      today.year,
      today.month,
    );
    DateTime endDate = DateTime.now();

    switch (_budgetPlan.budget.interval) {
      case BudgetInterval.weekly:
        startDate = endDate.subtract(Duration(days: endDate.weekday - 1));
        break;
      case BudgetInterval.monthly:
        startDate = DateTime(
          today.year,
          today.month,
        );
        break;
      case BudgetInterval.annual:
        startDate = DateTime(today.year);
        break;
    }
    _transactions = []; // Reset transactions
    _transactions = await _transactionsDriftRepository.getDoubleEntries(
        startDate: startDate, endDate: endDate, profileId: _profile.id);
    _transactions = _transactions
        .where((t) =>
            budgetPlan.funds
                .any((f) => f.id == t.crAccount.id || f.id == t.drAccount.id) &&
            (budgetPlan.expenses.keys.any(
                    (f) => f.id == t.crAccount.id || f.id == t.drAccount.id) ||
                budgetPlan.incomes.keys.any(
                    (f) => f.id == t.crAccount.id || f.id == t.drAccount.id)))
        .toList()
        .reversed
        .toList();

    DateTime sDate = startDate;
    rangeDates = List.generate(endDate.difference(sDate).inDays + 1,
        (index) => sDate.add(Duration(days: index)));

    _dailyTotalTransactions = List.from(
      rangeDates.map((d) => DailyTotalTransaction(dateTime: d)),
    );

    notifyListeners();
  }

  int getExpenseAmt(int account) {
    return selectedExpenses[account] ?? 0;
  }

  int getIncomeAmt(int account) {
    return selectedIncomes[account] ?? 0;
  }

  _calculateDifference() {
    bIncomeTotal = _budgetPlan.incomes.values.sum;
    bExpenseTotal = _budgetPlan.expenses.values.sum;
    bDifference = bIncomeTotal - bExpenseTotal.abs();
    notifyListeners();
  }

  _calculateTotalTransactions() {
    // Reset totals
    aExpenseTotal = 0;
    aIncomeTotal = 0;
    aDifference = 0;
    expenseTotals = {for (var k in _expenses) k: 0};
    incomeTotals = {for (var k in _incomes) k: 0};

    int cumExpenseTotal = 0;
    int cumIncomeTotal = 0;

    for (var dt in rangeDates) {
      final dtt = _dailyTotalTransactions
          .firstWhereOrNull((x) => x.dateTime.isSameDayAs(dt));
      List<DoubleEntry> doubleEntries = _transactions
          .where((t) => t.transaction.vchDate.isSameDayAs(dt))
          .toList();
      for (var d in doubleEntries) {
        switch (d.crAccount.accType) {
          case 4:
            incomeTotals.update(d.crAccount, (amount) {
              return amount + d.transaction.amount;
            });
            cumIncomeTotal += d.transaction.amount;
            break;

          case 5:
            expenseTotals.update(d.crAccount, (amount) {
              return amount - d.transaction.amount;
            });
            cumExpenseTotal -= d.transaction.amount;
            break;
        }
        switch (d.drAccount.accType) {
          case 5:
            expenseTotals.update(d.drAccount, (amount) {
              return amount - d.transaction.amount;
            });
            cumExpenseTotal += d.transaction.amount;
            break;

          case 4:
            incomeTotals.update(d.drAccount, (amount) {
              return amount + d.transaction.amount;
            });
            cumIncomeTotal -= d.transaction.amount;
            break;
        }
      }
      dtt?.addPayment(cumExpenseTotal);
      dtt?.addReceipt(cumIncomeTotal);
    }

    expenseTotals.removeWhere((a, i) {
      return i == 0;
    });

    expenseTotals = Map.fromEntries(expenseTotals.entries.toList()
      ..sort((a, b) => a.value.compareTo(b.value)));

    incomeTotals.removeWhere((a, i) {
      return i == 0;
    });

    incomeTotals = Map.fromEntries(incomeTotals.entries.toList()
      ..sort((a, b) => a.value.compareTo(b.value)));

    aExpenseTotal = expenseTotals.values.sum;
    aIncomeTotal = incomeTotals.values.sum;
    aDifference = aIncomeTotal.abs() - aExpenseTotal.abs();

    try {
      if (dailyTotalTransactions.isNotEmpty) {
        int noOfDays = dailyTotalTransactions.length;
        int totalDays = budgetPlan.budget.interval == BudgetInterval.monthly
            ? 30
            : budgetPlan.budget.interval == BudgetInterval.weekly
                ? 7
                : budgetPlan.budget.interval == BudgetInterval.annual
                    ? 365
                    : 30;

        expectedAvgExp = ((bExpenseTotal / totalDays) * noOfDays).round();
        expectedAvgInc = ((bIncomeTotal / totalDays) * noOfDays).round();
        expectedAvgDif = ((bDifference / totalDays) * noOfDays).round();
      }
    } catch (e) {
      AppLogger.instance.error(' ${e.toString()}');
    }

    notifyListeners();
  }

  void resetErrorText() {
    errorText = "";
    notifyListeners();
  }

  Future<bool> deleteBudget() async {
    try {
      await _budgetsDriftRepository.delete(_budgetPlan.budget.id);
      return true;
    } catch (e) {
      AppLogger.instance.error(' ${e.toString()}');
      errorText = 'Error: Failed to delete budget ';
      return false;
    }
  }
}
