import 'package:collection/collection.dart';
import 'package:flutter/foundation.dart';
import 'package:pursenal/app/global/values.dart';
import 'package:pursenal/core/db/database.dart';
import 'package:pursenal/core/enums/budget_interval.dart';
import 'package:pursenal/core/enums/loading_status.dart';
import 'package:pursenal/core/models/budget_plan.dart';
import 'package:pursenal/core/repositories/accounts_drift_repository.dart';
import 'package:pursenal/core/repositories/budgets_drift_repository.dart';
import 'package:pursenal/utils/app_logger.dart';

class BudgetEntryViewmodel extends ChangeNotifier {
  final AccountsDriftRepository _accountsDriftRepository;
  final BudgetsDriftRepository _budgetsDriftRepository;

  BudgetEntryViewmodel({
    required MyDatabase db,
    required Profile profile,
    Budget? budget,
    BudgetPlan? budgetPlan,
  })  : _profile = profile,
        _budget = budget,
        _budgetPlan = budgetPlan,
        _accountsDriftRepository = AccountsDriftRepository(db),
        _budgetsDriftRepository = BudgetsDriftRepository(db);

  LoadingStatus loadingStatus = LoadingStatus.idle;

  Budget? _budget;

  final BudgetPlan? _budgetPlan;

  final Profile _profile;

  String errorText = "";

  List<Account> expenses = [];
  List<Account> incomes = [];
  List<Account> funds = [];

  Map<int, int> selectedIncomes = {};
  Map<int, int> selectedExpenses = {};
  Set<int> selectedFunds = {};

  int expenseTotal = 0;
  int incomesTotal = 0;

  Budget? get budget => _budget;
  String _name = "";
  DateTime _startDate = DateTime.now();
  BudgetInterval _interval = BudgetInterval.monthly;
  String _details = "";

  String get name => _name;
  DateTime get startDate => _startDate;
  String get details => _details;
  BudgetInterval get interval => _interval;

  String nameError = "";
  String detailsError = "";
  String intervalError = "";
  String startDateError = "";
  String selectedExpensesError = "";
  String selectedIncomesError = "";
  String selectedFundsError = "";

  int difference = 0;
  List<Budget> _budgets = [];

  bool isWarningAlerted = false;

  void init() async {
    loadingStatus = LoadingStatus.loading;
    try {
      await getAccounts();
      setDefaults();
      _calculateIncomes();
      _calculateExpenses();
      _calculateDifference();
      loadingStatus = LoadingStatus.completed;
      notifyListeners();
    } catch (e) {
      AppLogger.instance.error(' ${e.toString()}');
      errorText = 'Error: Failed to initialise Budget form';
      loadingStatus = LoadingStatus.error;
      notifyListeners();
    }
  }

  set details(String value) {
    _details = value;
    notifyListeners();
  }

  set interval(BudgetInterval value) {
    _interval = value;
    notifyListeners();
  }

  set startDate(DateTime value) {
    _startDate = value;
    notifyListeners();
  }

  set name(String value) {
    _name = value;
    notifyListeners();
  }

  void setDefaults() {
    if (_budgetPlan != null) {
      _budget = _budgetPlan.budget;
      _name = budget!.name;
      _details = _budget!.details;
      _interval = budget!.interval;
      _startDate = budget!.startDate;
      selectedExpenses = _budgetPlan.expenses.map((k, v) => MapEntry(k.id, -v));
      selectedFunds = _budgetPlan.funds.map((f) => f.id).toSet();
      selectedIncomes = _budgetPlan.incomes.map((k, v) => MapEntry(k.id, v));
    }
    notifyListeners();
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

    selectedFunds = funds.map((f) => f.id).toSet();

    notifyListeners();
  }

  int getExpenseAmt(int account) {
    return selectedExpenses[account] ?? 0;
  }

  int getIncomeAmt(int account) {
    return selectedIncomes[account] ?? 0;
  }

  addExpense(int account, int amount) {
    selectedExpenses[account] = amount;

    notifyListeners();
    _calculateExpenses();
  }

  addIncome(int account, int amount) {
    selectedIncomes[account] = amount;

    notifyListeners();
    _calculateIncomes();
  }

  _calculateExpenses() {
    expenseTotal = selectedExpenses.values.sum;
    notifyListeners();
    _calculateDifference();
  }

  _calculateIncomes() {
    incomesTotal = selectedIncomes.values.sum;
    notifyListeners();
    _calculateDifference();
  }

  _calculateDifference() {
    difference = incomesTotal - expenseTotal;
    notifyListeners();
  }

  toggleFund(int id) {
    if (selectedFunds.contains(id)) {
      selectedFunds.remove(id);
    } else {
      selectedFunds.add(id);
    }
    notifyListeners();
  }

  Future<void> getBudgets() async {
    try {
      _budgets = await _budgetsDriftRepository.getAllBudgets(_profile.id);

      AppLogger.instance.info("BudgetPlans loaded from database");
    } catch (e) {
      AppLogger.instance.error("Error loading budgetPlans ${e.toString()}");
    }
    notifyListeners();
  }

  bool _validate() {
    bool isValid = true;

    nameError = "";
    detailsError = "";
    intervalError = "";
    startDateError = "";
    selectedExpensesError = "";
    selectedIncomesError = "";
    selectedFundsError = "";
    notifyListeners();

    if (_name.trim().isEmpty) {
      nameError = "Budget name must be valid.";
      isValid = false;
    }
    if (_budget == null && _budgets.where((b) => b.name == _name).isNotEmpty) {
      nameError = "Budget name already exist";
      isValid = false;
    }
    if (selectedExpenses.isEmpty) {
      selectedExpensesError = "No expenses selected";
      isValid = false;
    }
    if (selectedFunds.isEmpty) {
      errorText = "No funds selected";
      isValid = false;
    }
    if (selectedIncomes.isEmpty) {
      errorText = "No incomes selected";
      isValid = false;
    }
    if (incomesTotal < expenseTotal) {
      if (!isWarningAlerted) {
        errorText =
            "Warning: Expenses are more than incomes. Cash flow will be negative";
        isValid = false;
      }
      isWarningAlerted = true;
    }

    notifyListeners();
    return isValid;
  }

  Future<bool> save() async {
    if (_validate()) {
      loadingStatus = LoadingStatus.submitting;
      notifyListeners();

      final Map<int, int> acc =
          Map.from(selectedExpenses.map((k, v) => MapEntry(k, -v)));
      acc.addAll(selectedIncomes);

      if (_budgetPlan == null) {
        await _budgetsDriftRepository.insertBudget(
            name, details, selectedFunds.toList(), acc, interval, _profile.id);
      } else {
        await _budgetsDriftRepository.updateBudget(_budgetPlan.budget.id, name,
            details, selectedFunds.toList(), acc, interval, _profile.id);
      }

      loadingStatus = LoadingStatus.submitted;
      notifyListeners();
      return true;
    }

    notifyListeners();
    return false;
  }

  void resetErrorText() {
    errorText = "";
    notifyListeners();
  }

  Future<bool> deleteBudget() async {
    if (_budgetPlan != null && _budget != null) {
      try {
        await _budgetsDriftRepository.delete(_budget!.id);
        return true;
      } catch (e) {
        AppLogger.instance.error(' ${e.toString()}');
        errorText = 'Error: Failed to delete budget ';
        return false;
      }
    }
    notifyListeners();
    return false;
  }
}
