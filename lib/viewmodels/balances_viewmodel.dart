import 'package:flutter/foundation.dart';
import 'package:pursenal/app/global/values.dart';
import 'package:pursenal/core/db/database.dart';
import 'package:pursenal/core/enums/loading_status.dart';
import 'package:pursenal/core/models/ledger.dart';
import 'package:pursenal/core/repositories/acc_types_drift_repository.dart';
import 'package:pursenal/core/repositories/accounts_drift_repository.dart';
import 'package:pursenal/utils/app_logger.dart';

class BalancesViewmodel extends ChangeNotifier {
  final AccountsDriftRepository _accountsDriftRepository;
  final AccTypesDriftRepository _accTypesDriftRepository;

  BalancesViewmodel({required MyDatabase db, required Profile profile})
      : _profile = profile,
        _accountsDriftRepository = AccountsDriftRepository(db),
        _accTypesDriftRepository = AccTypesDriftRepository(db);

  Future<void> init() async {
    try {
      loadingStatus = LoadingStatus.loading;
      notifyListeners();
      await getFunds();
      await getAccTypes();
      loadingStatus = LoadingStatus.completed;
      notifyListeners();
    } catch (e) {
      AppLogger.instance.error(' ${e.toString()}');
      errorText = 'Error: Failed to initialise funds';
      loadingStatus = LoadingStatus.error;
      notifyListeners();
    }
  }

  final Profile _profile;

  List<AccType> _fundingAccTypes = [];
  List<AccType> get fundingAccTypes => _fundingAccTypes;

  List<AccType> _balanceAccTypes = [];
  List<AccType> get balanceAccTypes => _balanceAccTypes;

  List<Ledger> _funds = [];
  List<Ledger> get funds => _funds;

  List<AccType> _fundAccTypes = [];
  List<AccType> get fundAccTypes => _fundAccTypes;

  List<Ledger> _credits = [];
  List<Ledger> get credits => _credits;

  List<AccType> _creditAccTypes = [];
  List<AccType> get creditAccTypes => _creditAccTypes;

  List<Ledger> _otherAccounts = [];
  List<Ledger> get otherAccounts => _otherAccounts;

  List<AccType> _otherAccountAccTypes = [];
  List<AccType> get otherAccountAccTypes => _otherAccountAccTypes;

  LoadingStatus loadingStatus = LoadingStatus.idle;
  LoadingStatus searchLoadingStatus = LoadingStatus.idle;

  String errorText = "";

  Future<void> getFunds() async {
    try {
      _funds = await _accountsDriftRepository.getFunds(profileId: _profile.id);
      _credits =
          await _accountsDriftRepository.getCredits(profileId: _profile.id);
      _otherAccounts = [
        ...await _accountsDriftRepository.getLedgersByAccType(
            profileId: _profile.id, accTypeID: advanceTypeID),
        ...await _accountsDriftRepository.getLedgersByAccType(
            profileId: _profile.id, accTypeID: peopleTypeID),
      ];
      AppLogger.instance.info("Funds loaded from database");
    } catch (e) {
      loadingStatus = LoadingStatus.error;
      errorText = "Error loading funds";
    }
    notifyListeners();
  }

  Future<void> getAccTypes() async {
    try {
      _fundAccTypes = await _accTypesDriftRepository.getFundAccTypes();
      _fundingAccTypes = await _accTypesDriftRepository.getFundingAccTypes();
      _creditAccTypes = await _accTypesDriftRepository.getCreditAccTypes();
      _otherAccountAccTypes = [
        await _accTypesDriftRepository.getById(advanceTypeID),
        await _accTypesDriftRepository.getById(peopleTypeID),
      ];
      _balanceAccTypes = await _accTypesDriftRepository.getBalanceAccTypes();
    } catch (e) {
      loadingStatus = LoadingStatus.error;
      errorText = "Error loading Account types";
    }
    notifyListeners();
  }

  Future<Wallet> getWalletByAccount(int id) async {
    try {
      return await _accountsDriftRepository.getWalletByAccount(id);
    } catch (e) {
      AppLogger.instance.error("Failed to get Wallet. ${e.toString()}");
      loadingStatus = LoadingStatus.error;
      errorText = "Error loading wallets";
      rethrow;
    }
  }

  Future<Bank> getBankByAccount(int id) async {
    try {
      return await _accountsDriftRepository.getBankByAccount(id);
    } catch (e) {
      AppLogger.instance.error("Failed to get Bank. ${e.toString()}");
      loadingStatus = LoadingStatus.error;
      errorText = "Error loading banks";
      rethrow;
    }
  }

  Future<Loan> getLoanByAccount(int id) async {
    try {
      return await _accountsDriftRepository.getLoanByAccount(id);
    } catch (e) {
      AppLogger.instance.error("Failed to get Loan. ${e.toString()}");
      loadingStatus = LoadingStatus.error;
      errorText = "Error loading loans";
      rethrow;
    }
  }

  Future<CCard> getCCardByAccount(int id) async {
    try {
      return await _accountsDriftRepository.getCCardByAccount(id);
    } catch (e) {
      AppLogger.instance.error("Failed to get Credit Card. ${e.toString()}");
      loadingStatus = LoadingStatus.error;
      errorText = "Error loading cards";
      rethrow;
    }
  }

  void resetErrorText() {
    errorText = "";
    notifyListeners();
  }

  int getBalanceByAccType(int id) {
    int balance = funds
        .where((a) => a.accType.id == id)
        .fold<int>(0, (sum, item) => sum + item.balance.amount);

    return balance;
  }
}
