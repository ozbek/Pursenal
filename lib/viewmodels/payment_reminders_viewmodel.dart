import 'package:flutter/foundation.dart';
import 'package:pursenal/core/abstracts/payment_reminders_repository.dart';
import 'package:pursenal/core/enums/loading_status.dart';
import 'package:pursenal/core/enums/payment_status.dart';
import 'package:pursenal/core/models/domain/account_type.dart';
import 'package:pursenal/core/models/domain/payment_reminder.dart';
import 'package:pursenal/core/models/domain/profile.dart';
import 'package:pursenal/core/abstracts/account_types_repository.dart';
import 'package:pursenal/utils/app_logger.dart';

class PaymentRemindersViewmodel extends ChangeNotifier {
  final PaymentRemindersRepository _paymentRemindersRepository;
  final AccountTypesRepository _accountTypesRepository;

  PaymentRemindersViewmodel(
      this._paymentRemindersRepository, this._accountTypesRepository,
      {required Profile profile, int accTypeID = 4})
      : _profile = profile,
        _accTypeID = accTypeID;

  int _accTypeID;

  get accTypeID => _accTypeID;

  bool isPayment = false;

  final Profile _profile;
  Profile get profile => _profile;

  List<PaymentReminder> _paymentReminders = [];
  List<PaymentReminder> _fPaymentReminders = [];

  AccountType? _accType;
  get accType => _accType;

  List<AccountType> accTypes = [];

  set accType(value) => _accType = value;

  LoadingStatus loadingStatus = LoadingStatus.idle;
  LoadingStatus searchLoadingStatus = LoadingStatus.idle;

  String _searchTerm = "";

  String get searchTerm => _searchTerm;
  List<PaymentReminder> get fPaymentReminders => _fPaymentReminders;

  Set<PaymentStatus> statusCriterias = {};
  Set<PaymentStatus> statusFilters = {};

  Future<void> init() async {
    loadingStatus = LoadingStatus.loading;
    try {
      await setAccountType(_accTypeID);
      loadingStatus = LoadingStatus.completed;
    } catch (e) {
      AppLogger.instance.error(' ${e.toString()}');
      loadingStatus = LoadingStatus.error;
      errorText = 'Error: Failed to initialise paymentReminders';
    }
    notifyListeners();
  }

  set searchTerm(String value) {
    _searchTerm = value.toLowerCase();
    _filterPaymentReminders();
  }

  String errorText = "";

  set accTypeID(final value) {
    _accTypeID = value;
    setAccountType(_accTypeID);
    notifyListeners();
  }

  Future<void> getPaymentReminders() async {
    try {
      _paymentReminders = await _paymentRemindersRepository
          .getAllPaymentReminders(profile.dbID);
      _paymentReminders.sort(
        (a, b) => a.paymentStatus.index.compareTo(b.paymentStatus.index),
      );
      statusCriterias = _paymentReminders.map((a) => a.paymentStatus).toSet();
      AppLogger.instance.info("PaymentReminders loaded from database");
    } catch (e) {
      AppLogger.instance
          .error("Error loading paymentReminders ${e.toString()}");
    }
    notifyListeners();
  }

  _filterPaymentReminders() {
    searchLoadingStatus = LoadingStatus.loading;
    notifyListeners();
    try {
      _fPaymentReminders = List.from(_paymentReminders);
      _fPaymentReminders = _fPaymentReminders
          .where((a) => a.toString().contains(_searchTerm))
          .where((aa) => !statusFilters.contains(aa.paymentStatus))
          .toList();

      searchLoadingStatus = LoadingStatus.completed;
    } catch (e) {
      searchLoadingStatus = LoadingStatus.error;
      AppLogger.instance
          .error("Failed to filter PaymentReminders. ${e.toString()}");
    }

    notifyListeners();
  }

  addToFilter({PaymentStatus? status}) async {
    if (status != null) {
      if (statusFilters.contains(status)) {
        statusFilters.remove(status);
      } else {
        statusFilters.add(status);
      }
    }

    notifyListeners();
    _filterPaymentReminders();
  }

  setAccountType(int id) async {
    _accType = await _accountTypesRepository.getById(id);
    notifyListeners();
    await getPaymentReminders();
    _filterPaymentReminders();
  }

  Future<bool> deleteReminder(int id) async {
    try {
      _paymentRemindersRepository.deletePaymentReminder(id);
      notifyListeners();
      return true;
    } catch (e) {
      AppLogger.instance.error(' ${e.toString()}');
      errorText = 'Error: ';
      notifyListeners();
      return false;
    }
  }

  void resetErrorText() {
    errorText = "";
    notifyListeners();
  }
}
