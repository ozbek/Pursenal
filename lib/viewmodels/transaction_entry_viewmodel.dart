import 'package:collection/collection.dart';
import 'package:flutter/foundation.dart';
import 'package:pursenal/app/extensions/currency.dart';
import 'package:pursenal/core/db/database.dart';
import 'package:pursenal/core/enums/loading_status.dart';
import 'package:pursenal/core/enums/voucher_type.dart';
import 'package:pursenal/core/models/double_entry.dart';
import 'package:pursenal/core/models/ledger.dart';
import 'package:pursenal/core/repositories/acc_types_drift_repository.dart';
import 'package:pursenal/core/repositories/accounts_drift_repository.dart';
import 'package:pursenal/core/repositories/balances_drift_repository.dart';
import 'package:pursenal/core/repositories/file_path_drift_repository.dart';
import 'package:pursenal/core/repositories/transactions_drift_repository.dart';
import 'package:pursenal/utils/app_logger.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TransactionEntryViewmodel extends ChangeNotifier {
  final AccountsDriftRepository _accountsDriftRepository;
  final TransactionsDriftRepository _transactionsDriftRepository;
  final BalancesDriftRepository _balancesDriftRepository;
  final FilePathsDriftRepository _filePathsDriftRepository;
  final AccTypesDriftRepository _accTypesDriftRepository;

  TransactionEntryViewmodel({
    required MyDatabase db,
    required Profile profile,
    Transaction? transaction,
    Transaction? dupeTransaction,
    DoubleEntry? doubleEntry,
    Account? selectedAccount,
    Account? selectedFund,
    VoucherType? vchType,
  })  : _profile = profile,
        _transaction = transaction,
        _dupeTransaction = dupeTransaction,
        _doubleEntry = doubleEntry,
        _selectedAccount = selectedAccount,
        _selectedFund = selectedFund,
        _vchType = vchType ?? VoucherType.payment,
        _accountsDriftRepository = AccountsDriftRepository(db),
        _transactionsDriftRepository = TransactionsDriftRepository(db),
        _balancesDriftRepository = BalancesDriftRepository(db),
        _accTypesDriftRepository = AccTypesDriftRepository(db),
        _filePathsDriftRepository = FilePathsDriftRepository(db);

  LoadingStatus loadingStatus = LoadingStatus.idle;
  bool isNegativeBalanceAlerted = false;

  Transaction? _transaction;
  final Transaction? _dupeTransaction;

  bool _isPayment = true;
  int _vchNo = 1;
  DateTime _vchDate = DateTime.now();
  DateTime _startDate = DateTime(2000);

  String _narr = "";
  VoucherType _vchType = VoucherType.payment;
  int _amount = 0;
  String _refNo = "";
  List<String> _images = [];
  List<Ledger> _funds = [];
  List<Ledger> _ledgers = [];
  List<Ledger> _fLedgers = [];

  final Profile _profile;
  Account? _selectedFund;
  Account? _selectedAccount;

  final DoubleEntry? _doubleEntry;

  // Error text variables
  String _vchNoError = "";
  String _vchDateError = "";
  final String _narrError = "";
  final String _vchTypeError = "";
  String _amountError = "";
  String _selectedFundError = "";
  String _selectedAccountError = "";

  String errorText = "";

// Getters for error text
  String get vchNoError => _vchNoError;
  String get vchDateError => _vchDateError;
  String get narrError => _narrError;
  String get vchTypeError => _vchTypeError;
  String get amountError => _amountError;
  String get selectedFundError => _selectedFundError;
  String get selectedAccountError => _selectedAccountError;

  Transaction? get transaction => _transaction;
  bool get isPayment => _isPayment;
  DateTime get vchDate => _vchDate;
  String get narr => _narr;
  int get vchNo => _vchNo;
  int get amount => _amount;
  String get refNo => _refNo;
  VoucherType get vchType => _vchType;
  List<String> get images => _images;
  List<Ledger> get funds => _funds;
  List<Ledger> get fAccounts => _fLedgers;
  Account? get selectedFund => _selectedFund;
  Account? get selectedAccount => _selectedAccount;
  DateTime get startDate => _startDate;

  List<AccType> accTypes = [];

  SharedPreferences? _prefs;

  Future<void> init() async {
    loadingStatus = LoadingStatus.loading;
    await getAccounts();

    _prefs = await SharedPreferences.getInstance();

    isPayment = _vchType == VoucherType.payment;

    if (_doubleEntry != null) {
      _transaction = _doubleEntry.transaction;
      AppLogger.instance
          .info("Editing transaction : ${_doubleEntry.transaction.id}");
      try {
        _setDefaults(_doubleEntry.transaction);
        _images = [..._doubleEntry.filePaths.map((p) => p.path!)];
      } catch (e, stackTrace) {
        errorText = "Error: Failed to initialise Transaction form";
        loadingStatus = LoadingStatus.error;
        AppLogger.instance.error(' ${e.toString()}', [stackTrace]);
        return;
      }
    } else {
      try {
        if (_dupeTransaction != null) {
          _setDefaults(_dupeTransaction);
        } else if (_selectedFund == null && _funds.length == 1) {
          _selectedFund = _funds.first.account;
        }
      } catch (e) {
        errorText = "Error: Failed to initialise Transaction form";
        AppLogger.instance.error(' ${e.toString()}');
        loadingStatus = LoadingStatus.error;
        notifyListeners();
      }

      vchNo =
          (await _transactionsDriftRepository.getLastTransactionID() ?? 0) + 1;
    }
    loadingStatus = LoadingStatus.completed;
    notifyListeners();
    _sortOtherAccounts();
    _setDatePickerStartDate();
  }

  set selectedFund(Account? value) {
    _selectedFund = value;
    notifyListeners();
    _filterAccounts();
    _sortOtherAccounts();
    _setDatePickerStartDate();
  }

  set selectedAccount(Account? value) {
    _selectedAccount = value;
    if (value == _selectedFund) {
      _selectedFund = null;
    }
    notifyListeners();
    _setDatePickerStartDate();
  }

  set imagePath(List<String> value) {
    _images = value;
    notifyListeners();
  }

  set transaction(Transaction? value) {
    _transaction = value;
    notifyListeners();
  }

  set isPayment(bool value) {
    _isPayment = value;
    vchType = value ? VoucherType.payment : VoucherType.receipt;
    notifyListeners();
  }

  set vchNo(int value) {
    _vchNo = value;
    notifyListeners();
  }

  set vchDate(DateTime value) {
    _vchDate = value;
    notifyListeners();
  }

  set narr(String value) {
    _narr = value;
    notifyListeners();
  }

  set vchType(VoucherType value) {
    _vchType = value;
    _sortOtherAccounts();

    notifyListeners();
  }

  set amount(int value) {
    _amount = value;
    notifyListeners();
  }

  set refNo(String value) {
    _refNo = value;
    notifyListeners();
  }

  _setDatePickerStartDate() {
    if (_selectedFund != null) {
      _startDate = _selectedFund!.openDate;
    }

    if (_vchDate.isBefore(_startDate)) {
      _vchDate = DateTime.now();
    }
    notifyListeners();
  }

  Future<void> getAccounts() async {
    _ledgers =
        await _accountsDriftRepository.getLedgers(profileId: _profile.id);
    _funds = await _accountsDriftRepository.getFundingLedgers(
        profileId: _profile.id);

    accTypes = await _accTypesDriftRepository.getAll();

    // _ledgers.where((a) => a.accType.id <= 3).toList();
    notifyListeners();
    _filterAccounts();
  }

  void _setDefaults(Transaction tr) {
    if (tr.vchType == VoucherType.payment) {
      _isPayment = true;
      _selectedFund = _funds.firstWhere((a) => a.account.id == tr.cr).account;
      _selectedAccount =
          _ledgers.firstWhere((a) => a.account.id == tr.dr).account;
    } else {
      _isPayment = false;
      _selectedAccount =
          _ledgers.firstWhere((a) => a.account.id == tr.cr).account;
      _selectedFund = _funds.firstWhere((a) => a.account.id == tr.dr).account;
    }
    _amount = tr.amount;
    _vchNo = tr.id;
    _vchDate = tr.vchDate;
    _vchType = tr.vchType;
    _narr = tr.narr;
    _refNo = tr.refNo;
    notifyListeners();
  }

  void _filterAccounts() {
    _fLedgers = List.from(_ledgers);

    if (_selectedFund != null) {
      _fLedgers.removeWhere((l) => l.account.id == _selectedFund?.id);
    }
    notifyListeners();
  }

  void addImage(String path) async {
    if (!_images.contains(path)) {
      _images.add(path);
      notifyListeners();
    }
  }

  void removeImage(String path) async {
    if (_images.contains(path)) {
      _images.remove(path);
      notifyListeners();
    }
  }

  bool _validate() {
    bool isValid = true;
    _vchNoError = '';
    _vchDateError = '';
    _amountError = '';
    _selectedFundError = '';
    _selectedAccountError = '';
    notifyListeners();

    int fundBalance = _funds
            .firstWhereOrNull((f) => f.account.id == _selectedFund?.id)
            ?.balance
            .amount ??
        0;

    if (_vchNo <= 0) {
      _vchNoError = 'Voucher number must be greater than 0';
      isValid = false;
    }
    if (_vchDate.isAfter(DateTime.now())) {
      _vchDateError = 'Voucher date cannot be in the future';
      isValid = false;
    }

    if (_amount <= 0) {
      _amountError = 'Amount must be greater than 0';
      isValid = false;
    }

    if (isPayment && !isNegativeBalanceAlerted) {
      int difference = fundBalance - amount;
      if (_doubleEntry != null) {
        if (_doubleEntry.transaction.vchType == VoucherType.receipt) {
          difference -= (_doubleEntry.transaction.amount);
        } else if (_doubleEntry.transaction.vchType == VoucherType.payment) {
          difference += (_doubleEntry.transaction.amount);
        }
      }

      if (difference < 0) {
        errorText =
            "Warning: The account balance after payment will be ${difference.toCurrencyStringWSymbol(_profile.currency)}";
        isValid = false;
        isNegativeBalanceAlerted = true;
      }
    }

    if (_selectedFund == null) {
      _selectedFundError = 'Fund must be selected';
      isValid = false;
    }

    if (_selectedAccount == null) {
      _selectedAccountError = 'Account must be selected';
      isValid = false;
    }
    notifyListeners();
    return isValid;
  }

  Future<bool> save() async {
    try {
      if (_validate() && _selectedFund != null && _selectedAccount != null) {
        loadingStatus = LoadingStatus.submitting;
        notifyListeners();

        if (_doubleEntry != null && _transaction != null) {
          AppLogger.instance
              .info("Updating Transaction with ID:${_transaction!.id}");
          await _transactionsDriftRepository.updateTransaction(
              id: _transaction!.id,
              vchDate: _vchDate,
              narr: _narr,
              refNo: _refNo,
              dr: isPayment ? _selectedAccount!.id : _selectedFund!.id,
              cr: isPayment ? _selectedFund!.id : _selectedAccount!.id,
              amount: _amount,
              vchType: _vchType,
              profile: _profile.id);
          for (var f in _doubleEntry.filePaths) {
            await _filePathsDriftRepository.delete(f.id);
          }
          for (var p in _images) {
            await _filePathsDriftRepository.insertPath(
                path: p, transaction: _transaction!.id);
          }
        } else {
          final trId = await _transactionsDriftRepository.insertTransaction(
              vchDate: _vchDate,
              narr: _narr,
              refNo: _refNo,
              dr: isPayment ? _selectedAccount!.id : _selectedFund!.id,
              cr: isPayment ? _selectedFund!.id : _selectedAccount!.id,
              amount: _amount,
              vchType: _vchType,
              profile: _profile.id);
          for (String p in _images) {
            await _filePathsDriftRepository.insertPath(
                path: p, transaction: trId);
          }
        }

        await _updateBalances();
        loadingStatus = LoadingStatus.submitted;
        notifyListeners();
        _setLastUpdatedTimeStamp();
        AppLogger.instance.info("Transaction saved.");
        return true;
      }

      notifyListeners();
      return false;
    } catch (e) {
      AppLogger.instance
          .error('Failed to save the transaction : ${e.toString()}');
      errorText = 'Error: Failed to save the transaction';
      loadingStatus = LoadingStatus.error;
      notifyListeners();
      return false;
    }
  }

  _updateBalances() async {
    try {
      if (_selectedAccount != null && _selectedFund != null) {
        await _balancesDriftRepository.updateBalanceByAccount(
          account: _selectedFund!.id,
        );

        await _balancesDriftRepository.updateBalanceByAccount(
          account: _selectedAccount!.id,
        );
      }
    } catch (e) {
      AppLogger.instance.error(
          'Failed to update balance after enterring transaction ${e.toString()}');
      errorText = 'Error: Failed to update balance.';
      loadingStatus = LoadingStatus.error;
    }
  }

  void resetErrorText() {
    errorText = "";
    notifyListeners();
  }

  Future<void> _setLastUpdatedTimeStamp() async {
    try {
      final timeStamp = DateTime.now();
      _prefs?.setInt('lastUpdated', timeStamp.millisecondsSinceEpoch);
    } catch (e) {
      AppLogger.instance
          .error("Error setting Last updated timestamp ${e.toString()}");
    }
  }

  _sortOtherAccounts() {
    _fLedgers.sort((a, b) {
      if (_vchType == VoucherType.payment) {
        if (a.accType.id == 5) {
          return -1;
        }
      }

      if (_vchType == VoucherType.receipt) {
        if (a.accType.id == 4) {
          return -1;
        }
      }

      return 1;
    });
    notifyListeners();
  }
}
