import 'package:flutter/foundation.dart';
import 'package:pursenal/app/extensions/currency.dart';
import 'package:pursenal/app/global/values.dart';
import 'package:pursenal/core/abstracts/account_types_repository.dart';
import 'package:pursenal/core/abstracts/accounts_repository.dart';
import 'package:pursenal/core/abstracts/file_paths_repository.dart';
import 'package:pursenal/core/abstracts/payment_reminders_repository.dart';
import 'package:pursenal/core/enums/budget_interval.dart';
import 'package:pursenal/core/enums/db_table_type.dart';
import 'package:pursenal/core/enums/loading_status.dart';
import 'package:pursenal/core/enums/payment_status.dart';
import 'package:pursenal/core/models/domain/account.dart';
import 'package:pursenal/core/models/domain/account_type.dart';
import 'package:pursenal/core/models/domain/ledger.dart';
import 'package:pursenal/core/models/domain/payment_reminder.dart';
import 'package:pursenal/core/models/domain/profile.dart';
import 'package:pursenal/utils/services/notification_service.dart';

class PaymentReminderEntryViewmodel extends ChangeNotifier {
  final PaymentRemindersRepository _paymentRemindersRepository;
  final AccountsRepository _accountsRepository;
  final AccountTypesRepository _accountTypesRepository;
  final FilePathsRepository _filePathsRepository;

  PaymentReminderEntryViewmodel(
    this._paymentRemindersRepository,
    this._accountsRepository,
    this._filePathsRepository,
    this._accountTypesRepository, {
    required Profile profile,
    PaymentReminder? reminder,
  })  : _profile = profile,
        _reminder = reminder;

  final Profile _profile;
  PaymentReminder? _reminder;

  Account? _selectedFund;
  Account? _selectedAccount;

  LoadingStatus loadingStatus = LoadingStatus.idle;

  Account? _account;
  Account? _fund;
  BudgetInterval? _interval;
  int _amount = 0;
  int? _day = 1;
  DateTime? _paymentDate;
  PaymentStatus _paymentStatus = PaymentStatus.pending;
  List<String> _filePaths = [];
  String _details = "";

  List<Ledger> _ledgers = [];
  List<Ledger> _funds = [];

  bool _doesRepeat = false;

  String errorText = '';
  String amountError = '';
  String detailsError = '';
  String selectedFundError = "";
  String selectedAccountError = "";
  String paymentDateError = "";
  String intervalError = "";
  String weekDayError = "";
  String monthDayError = "";

  // Getters
  Account? get account => _account;
  Account? get fund => _fund;
  BudgetInterval? get interval => _interval;
  int? get day => _day;
  int get amount => _amount;
  DateTime? get paymentDate => _paymentDate;
  PaymentStatus get paymentStatus => _paymentStatus;
  List<String> get filePaths => List.unmodifiable(_filePaths);
  String get details => _details;
  bool get doesRepeat => _doesRepeat;
  Account? get selectedFund => _selectedFund;
  Account? get selectedAccount => _selectedAccount;
  List<Ledger> get funds => _funds;

  List<Ledger> get fAccounts => _ledgers;

  List<AccountType> accountTypes = [];

  // Setters with notifyListeners
  set account(Account? value) {
    _account = value;
    notifyListeners();
  }

  set fund(Account? value) {
    _fund = value;
    notifyListeners();
  }

  set interval(BudgetInterval? value) {
    _interval = value;
    notifyListeners();
  }

  set day(int? value) {
    _day = value;
    notifyListeners();
  }

  set amount(int value) {
    _amount = value;
    notifyListeners();
  }

  set paymentDate(DateTime? value) {
    _paymentDate = value;
    notifyListeners();
  }

  set paymentStatus(PaymentStatus value) {
    _paymentStatus = value;
    notifyListeners();
  }

  set details(String value) {
    _details = value;
    notifyListeners();
  }

  set doesRepeat(bool value) {
    _doesRepeat = value;
    _day = null;
    _interval = BudgetInterval.monthly;
    _paymentDate = null;
    notifyListeners();
  }

  set selectedFund(Account? value) {
    _selectedFund = value;
    notifyListeners();
  }

  set selectedAccount(Account? value) {
    _selectedAccount = value;
    if (value == _selectedFund) {
      _selectedFund = null;
    }
    notifyListeners();
  }

  void addImage(String path) {
    if (!_filePaths.contains(path)) {
      _filePaths.add(path);
      notifyListeners();
    }
  }

  void removeImage(String path) {
    _filePaths.remove(path);
    notifyListeners();
  }

  void resetErrorText() {
    errorText = "";
    notifyListeners();
  }

  void init() async {
    loadingStatus = LoadingStatus.loading;
    notifyListeners();
    await getAccounts();

    if (_reminder != null) {
      _account = _reminder!.account;
      _fund = _reminder!.fund;
      _interval = _reminder!.interval;
      _amount = _reminder!.amount;
      _day = _reminder!.day;
      _paymentDate = _reminder!.paymentDate;
      _paymentStatus = _reminder!.paymentStatus;
      _filePaths = List.from(_reminder!.filePaths);
      _details = _reminder!.details;
      if (_reminder?.paymentDate == null) {
        _doesRepeat = true;
        _interval = _reminder?.interval;
      }
    }

    loadingStatus = LoadingStatus.completed;
    notifyListeners();
  }

  Future<void> getAccounts() async {
    _ledgers = await _accountsRepository.getLedgers(profileId: _profile.dbID);
    _funds = await _accountsRepository.getLedgersByCategory(
        profileId: _profile.dbID, accTypeIDs: fundingAccountIDs);

    accountTypes = await _accountTypesRepository.getAll();

    // _ledgers.where((a) => a.accType.dbID <= 3).toList();
    notifyListeners();
  }

  bool _validate() {
    bool isValid = true;
    amountError = '';
    detailsError = '';
    selectedFundError = "";
    selectedAccountError = "";
    paymentDateError = "";
    intervalError = "";
    weekDayError = "";
    monthDayError = "";

    if (_amount <= 0) {
      amountError = "Amount must be greater than 0";
      isValid = false;
    }

    if (_details.length > 200) {
      detailsError = "Details too long";
      isValid = false;
    }

    if (_details.isEmpty) {
      detailsError = "Enter details";
      isValid = false;
    }

    if (_doesRepeat) {
      if (_interval == BudgetInterval.monthly) {
        if ((_day == null || _day! > 31)) {
          monthDayError = "Enter a valid day";
          isValid = false;
        }
      } else if (_interval == BudgetInterval.weekly) {
        if (_day == null || _day! > 7) {
          weekDayError = "Select a valid day";
          isValid = false;
        }
      } else {
        intervalError = "Select a valid interval";
        isValid = false;
      }
    } else {
      if (_paymentDate == null) {
        paymentDateError = "Enter a valid date";
        isValid = false;
      }
    }

    notifyListeners();
    return isValid;
  }

  Future<bool> save() async {
    if (!_validate()) return false;

    loadingStatus = LoadingStatus.submitting;
    notifyListeners();

    try {
      if (_reminder == null) {
        final newId = await _paymentRemindersRepository.insertPaymentReminder(
          profile: _profile.dbID,
          account: _account,
          fund: _fund,
          interval: _interval,
          day: _day ?? 0,
          amount: _amount,
          paymentDate: _paymentDate,
          status: _paymentStatus,
          details: _details,
        );
        for (var p in filePaths) {
          await _filePathsRepository.insertFilePath(
              path: p,
              parentTableID: newId,
              tableType: DBTableType.paymentReminder);
        }
        NotificationService.schedulePaymentReminder(
          id: newId,
          title:
              "Today's payment reminder : ${amount.toCurrencyStringWSymbol(_profile.currency)}",
          body: "Towards $details",
          isWeekly: _interval == BudgetInterval.weekly,
          startDateTime: DateTime.now().copyWith(hour: 8, minute: 0, second: 0),
          monthDay: _interval == BudgetInterval.monthly ? day : null,
          weekday: _interval == BudgetInterval.weekly ? day : null,
        );
        _reminder =
            await _paymentRemindersRepository.getPaymentReminderByID(newId);
      } else {
        await _filePathsRepository.deleteFilePathByParentID(_reminder!.dbID);
        await _paymentRemindersRepository.updatePaymentReminder(
          id: _reminder!.dbID,
          profile: _profile.dbID,
          account: _account,
          fund: _fund,
          interval: _interval,
          day: _day ?? 0,
          amount: _amount,
          paymentDate: _paymentDate,
          status: _paymentStatus,
          details: _details,
        );
        for (var p in filePaths) {
          await _filePathsRepository.insertFilePath(
              path: p,
              parentTableID: _reminder!.dbID,
              tableType: DBTableType.paymentReminder);
        }
        NotificationService.cancelReminder(id: _reminder!.dbID);
        NotificationService.schedulePaymentReminder(
          id: _reminder!.dbID,
          title:
              "Today's payment reminder : ${amount.toCurrencyStringWSymbol(_profile.currency)}",
          body: "Towards $details",
          isWeekly: _interval == BudgetInterval.weekly,
          startDateTime: DateTime.now().copyWith(hour: 8, minute: 0, second: 0),
          monthDay: _interval == BudgetInterval.monthly ? day : null,
          weekday: _interval == BudgetInterval.weekly ? day : null,
        );
      }

      loadingStatus = LoadingStatus.submitted;
      notifyListeners();
      return true;
    } catch (e) {
      errorText = 'Failed to save reminder: ${e.toString()}';
      loadingStatus = LoadingStatus.error;
      notifyListeners();
      return false;
    }
  }
}
