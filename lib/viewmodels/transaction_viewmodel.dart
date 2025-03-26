import 'package:flutter/material.dart';
import 'package:pursenal/core/db/database.dart';
import 'package:pursenal/core/enums/loading_status.dart';
import 'package:pursenal/core/models/double_entry.dart';
import 'package:pursenal/core/repositories/balances_drift_repository.dart';
import 'package:pursenal/core/repositories/transactions_drift_repository.dart';
import 'package:pursenal/utils/app_logger.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TransactionViewmodel extends ChangeNotifier {
  final TransactionsDriftRepository _transactionsDriftRepository;
  final BalancesDriftRepository _balancesDriftRepository;

  TransactionViewmodel({
    required Profile profile,
    required MyDatabase db,
    required DoubleEntry doubleEntry,
  })  : _profile = profile,
        _doubleEntry = doubleEntry,
        _transactionsDriftRepository = TransactionsDriftRepository(db),
        _balancesDriftRepository = BalancesDriftRepository(db);

  DoubleEntry _doubleEntry;
  DoubleEntry get doubleEntry => _doubleEntry;

  final Profile _profile;
  get profile => _profile;

  LoadingStatus loadingStatus = LoadingStatus.idle;
  String errorText = "";

  SharedPreferences? _prefs;

  init() async {
    try {
      loadingStatus = LoadingStatus.loading;
      _prefs = await SharedPreferences.getInstance();
      notifyListeners();
      try {
        loadingStatus = LoadingStatus.completed;
      } catch (e) {
        loadingStatus = LoadingStatus.error;
        errorText = "Cannot load Transaction";
      }
      notifyListeners();
    } catch (e) {
      AppLogger.instance.error(' ${e.toString()}');
      errorText = 'Error: Failed to initialise Transaction';
      loadingStatus = LoadingStatus.error;
      notifyListeners();
    }
  }

  deleteTransaction() async {
    try {
      await _transactionsDriftRepository.delete(_doubleEntry.transaction.id);
      await _balancesDriftRepository.updateBalanceByAccount(
          account: _doubleEntry.transaction.cr);
      await _balancesDriftRepository.updateBalanceByAccount(
          account: _doubleEntry.transaction.dr);
      notifyListeners();
      await setLastUpdatedTimeStamp();
      return true;
    } catch (e) {
      loadingStatus = LoadingStatus.error;
      errorText = "Couldn't delete transaction";
      return false;
    }
  }

  void resetErrorText() {
    errorText = "";
    notifyListeners();
  }

  Future<void> setLastUpdatedTimeStamp() async {
    try {
      final timeStamp = DateTime.now();
      _prefs?.setInt('lastUpdated', timeStamp.millisecondsSinceEpoch);
    } catch (e) {
      AppLogger.instance
          .error("Error setting Last updated timestamp ${e.toString()}");
    }
  }

  void refetchTransaction() async {
    try {
      loadingStatus = LoadingStatus.loading;
      notifyListeners();
      _doubleEntry = await _transactionsDriftRepository.getDoubleEntryById(
          transactionID: doubleEntry.transaction.id);
      loadingStatus = LoadingStatus.completed;
    } catch (e) {
      errorText = "Failed to fetch transaction";
      loadingStatus = LoadingStatus.error;
    }
    notifyListeners();
  }
}
