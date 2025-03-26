import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:pursenal/app/extensions/datetime.dart';
import 'package:pursenal/utils/exporter.dart';
import 'package:pursenal/core/db/database.dart';
import 'package:pursenal/core/enums/loading_status.dart';
import 'package:pursenal/core/enums/voucher_type.dart';
import 'package:pursenal/core/models/double_entry.dart';
import 'package:pursenal/core/models/ledger.dart';
import 'package:pursenal/core/repositories/accounts_drift_repository.dart';
import 'package:pursenal/core/repositories/balances_drift_repository.dart';
import 'package:pursenal/core/repositories/transactions_drift_repository.dart';
import 'package:pursenal/utils/app_logger.dart';

class BalanceAccountViewmodel extends ChangeNotifier with Exporter {
  final TransactionsDriftRepository _transactionsDriftRepository;
  final BalancesDriftRepository _balancesDriftRepository;

  final AccountsDriftRepository _accountsDriftRepository;

  BalanceAccountViewmodel({
    required Profile profile,
    required MyDatabase db,
    required Account account,
  })  : _profile = profile,
        _account = account,
        _accountsDriftRepository = AccountsDriftRepository(db),
        _transactionsDriftRepository = TransactionsDriftRepository(db),
        _balancesDriftRepository = BalancesDriftRepository(db);

  Account _account;
  Account get account => _account;

  int openBal = 0;
  int closeBal = 0;
  List<Ledger> allLedgers = [];

  LoadingStatus loadingStatus = LoadingStatus.idle;
  LoadingStatus searchLoadingStatus = LoadingStatus.idle;

  final Profile _profile;
  Profile get profile => _profile;

  String errorText = "";

  List<DoubleEntry> _transactions = [];

  List<DoubleEntry> _fTransactions = [];

  DateTime _startDate = DateTime.now().subtract(const Duration(days: 7));
  DateTime _endDate = DateTime.now();
  DateTime get startDate => _startDate;
  DateTime get endDate => _endDate;
  List<DoubleEntry> get transactions => _transactions;
  List<DoubleEntry> get fTransactions => _fTransactions;

  Set<VoucherType> voucherTypes = {};
  final Set<VoucherType> _voucherTypeFilters = {};

  Set<Account> funds = {};

  Set<Account> otherAccounts = {};
  Set<int> _otherAccountFilters = {};
  get otherAccountFilters => _otherAccountFilters;

  set otherAccountFilters(value) => _otherAccountFilters = value;

  Set<VoucherType> get voucherTypeFilters => _voucherTypeFilters;

  String _searchTerm = "";
  String get searchTerm => _searchTerm;

  String feedbackText = "";

  Set<DateTime> fDates = {};

  init() async {
    try {
      loadingStatus = LoadingStatus.loading;
      if (_account.openDate.isAfter(_startDate)) {
        _startDate = _account.openDate;
      }
      scrollController.addListener(updateHeaderVisibility);
      await _getAccount();
      await _getTransactions();
      filterTransactions();
      _populateVoucherTypes();
      _populateAccounts();
      loadingStatus = LoadingStatus.completed;
      notifyListeners();
      _getOpeningBalance();
      _getClosingBalance();
      _getAllLedgers();
    } catch (e) {
      AppLogger.instance.error(' ${e.toString()}');
      errorText = 'Error: Failed to initialise Fund.';
      loadingStatus = LoadingStatus.error;
      notifyListeners();
    }
  }

  Future<void> _getAccount() async {
    try {
      _account = await _accountsDriftRepository.getById(_account.id);
      AppLogger.instance.info("Fund loaded from database");
    } catch (e) {
      AppLogger.instance.error("Error loading Fund ${e.toString()}");
    }
    notifyListeners();
  }

  refetchAccount() async {
    try {
      _account = await _accountsDriftRepository.getById(_account.id);
    } catch (e) {
      AppLogger.instance.error(' ${e.toString()}');
      errorText = 'Error: ';
    }
    notifyListeners();
  }

  set startDate(DateTime value) {
    _startDate = value;

    notifyListeners();
  }

  set endDate(DateTime value) {
    _endDate = value;
    notifyListeners();
  }

  set searchTerm(String term) {
    _searchTerm = term.toLowerCase();
    filterTransactions();
  }

  _getOpeningBalance() async {
    openBal = await _balancesDriftRepository.getClosingBalance(
        account: _account.id,
        closingDate: _startDate.subtract(const Duration(days: 1)));
    notifyListeners();
  }

  _getClosingBalance() async {
    closeBal = await _balancesDriftRepository.getClosingBalance(
        account: _account.id, closingDate: _endDate);
    notifyListeners();
  }

  _getAllLedgers() async {
    allLedgers =
        await _accountsDriftRepository.getLedgers(profileId: profile.id);
    notifyListeners();
  }

  addToFilter({
    VoucherType? voucherType,
    DateTime? sDate,
    DateTime? eDate,
    Account? oAcc,
  }) async {
    bool transactionsFetchNeeded = false;

    if (voucherType != null) {
      if (_voucherTypeFilters.contains(voucherType)) {
        _voucherTypeFilters.remove(voucherType);
      } else {
        _voucherTypeFilters.add(voucherType);
      }
    }
    if (sDate != null) {
      if (sDate.isBeforeOrEqualTo(_startDate)) {
        transactionsFetchNeeded = true;
      }
      _startDate = sDate;
      _getOpeningBalance();
    }
    if (eDate != null) {
      eDate = eDate.copyWith(hour: 23, minute: 59, second: 59);
      if (eDate.isAfter(_endDate)) {
        transactionsFetchNeeded = true;
      }
      _endDate = eDate;
      _getClosingBalance();
    }

    if (oAcc != null) {
      if (_otherAccountFilters.contains(oAcc.id)) {
        _otherAccountFilters.remove(oAcc.id);
      } else {
        _otherAccountFilters.add(oAcc.id);
      }
    }

    if (transactionsFetchNeeded) {
      await _getTransactions();
      _populateVoucherTypes();
    }

    notifyListeners();
    filterTransactions();
  }

  filterTransactions() {
    searchLoadingStatus = LoadingStatus.loading;
    notifyListeners();

    try {
      _fTransactions = List.from(_transactions);

      _fTransactions = fTransactions
          .where((f) => !voucherTypeFilters.contains(f.transaction.vchType))
          .where((f) =>
              (f.crAccount.id == _account.id &&
                  !_otherAccountFilters.contains(f.drAccount.id)) ||
              (f.drAccount.id == _account.id &&
                  !_otherAccountFilters.contains(f.crAccount.id)))
          .where((d) => d.transaction.vchDate.isBetween(_startDate, _endDate))
          .where((a) => a.toString().contains(_searchTerm))
          .toList();
      fDates = _fTransactions.map((t) {
        return t.transaction.vchDate.copyWith(
            hour: 0, minute: 0, second: 0, microsecond: 0, millisecond: 0);
      }).toSet();
      searchLoadingStatus = LoadingStatus.completed;
    } catch (e) {
      AppLogger.instance
          .error("Failed to filter Transactions. ${e.toString()}");
      searchLoadingStatus = LoadingStatus.error;
    }

    notifyListeners();
  }

  _populateVoucherTypes() {
    // _voucherTypeFilters = {};
    voucherTypes = _transactions.map((t) => t.transaction.vchType).toSet();
    notifyListeners();
  }

  _populateAccounts() {
    // _otherAccountFilters = {};

    for (var t in _transactions) {
      if (t.drAccount.id != _account.id) {
        otherAccounts.add(t.drAccount);
      }
      if (t.crAccount.id != _account.id) {
        otherAccounts.add(t.crAccount);
      }
    }
    notifyListeners();
  }

  Future<void> _getTransactions() async {
    _transactions =
        await _transactionsDriftRepository.getDoubleEntriesbyAccount(
      startDate: _startDate,
      endDate: _endDate,
      profileId: _profile.id,
      accountId: _account.id,
      reversed: false,
    );

    AppLogger.instance.info("Transactions loaded ${_transactions.length} nos");

    notifyListeners();
  }

  void resetErrorText() {
    errorText = "";
    feedbackText = "";
    notifyListeners();
  }

  Future<void> exportPDF() async {
    try {
      feedbackText = await Exporter.genLTransactionsPDF(
          transactions: _fTransactions.reversed.toList(),
          currency: _profile.currency,
          startDate: _startDate,
          openingBalance: openBal,
          openDate: _startDate,
          endDate: _endDate,
          closingBalance: closeBal,
          account: _account);
    } catch (e) {
      AppLogger.instance.error(' ${e.toString()}');
      errorText = 'Error: Failed to export PDF';
    }
    notifyListeners();
  }

  Future<void> exportXLSX() async {
    try {
      feedbackText = await Exporter.genLTransactionsXLSX(
          transactions: _fTransactions.reversed.toList(),
          currency: _profile.currency,
          startDate: _startDate,
          openingBalance: openBal,
          openDate: _startDate,
          endDate: _endDate,
          closingBalance: closeBal,
          account: _account);
    } catch (e) {
      AppLogger.instance.error(' ${e.toString()}');
      errorText = 'Error: Failed to export spreadsheet';
    }
    notifyListeners();
  }

  final ScrollController scrollController = ScrollController();

  double? headerHeight;
  bool isHidden = false;

  void updateHeaderVisibility() {
    if (scrollController.position.userScrollDirection ==
        ScrollDirection.reverse) {
      if (!isHidden && _fTransactions.length > 20) {
        isHidden = true;
        headerHeight = 0;
        notifyListeners();
      }
    } else if (scrollController.position.userScrollDirection ==
        ScrollDirection.forward) {
      if (isHidden) {
        isHidden = false;
        headerHeight = null;
        notifyListeners();
      }
    }
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }
}
