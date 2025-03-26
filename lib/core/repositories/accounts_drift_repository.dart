import 'package:drift/drift.dart';
import 'package:pursenal/core/abstracts/base_repository.dart';
import 'package:pursenal/core/db/database.dart';
import 'package:pursenal/core/models/ledger.dart';
import 'package:pursenal/utils/app_logger.dart';

class AccountsDriftRepository
    implements BaseRepository<Account, AccountsCompanion> {
  AccountsDriftRepository(this.db);
  final MyDatabase db;

  Future<int> insertAccount(
      {required String name,
      required int openBal,
      required DateTime openDate,
      required int accType,
      required int profile}) async {
    try {
      final account = AccountsCompanion(
        name: Value(name),
        accType: Value(accType),
        openBal: Value(openBal),
        openDate: Value(openDate),
        profile: Value(profile),
      );
      AppLogger.instance.info("Creating account $name.");
      return await db.insertAccount(account);
    } catch (e) {
      AppLogger.instance.error("Failed to update account. ${e.toString()}");
      rethrow;
    }
  }

  Future<bool> updateAccount(
      {required int id,
      required String name,
      required int openBal,
      required DateTime openDate,
      required int accType,
      required int profile}) async {
    try {
      final account = AccountsCompanion(
        id: Value(id),
        name: Value(name),
        accType: Value(accType),
        openBal: Value(openBal),
        openDate: Value(openDate),
        profile: Value(profile),
        updateDate: Value(DateTime.now()),
      );
      AppLogger.instance.info("Updating account $name.");
      return await db.updateAccount(account);
    } catch (e) {
      AppLogger.instance.error("Failed to insert account. ${e.toString()}");
      rethrow;
    }
  }

  @override
  Future<int> delete(int id) async {
    try {
      return await db.deleteAccount(id);
    } catch (e) {
      AppLogger.instance.error("Failed to delete account. ${e.toString()}");
      rethrow;
    }
  }

  @override
  Future<Account> getById(int id) async {
    try {
      return await db.getAccountbyId(id);
    } catch (e) {
      AppLogger.instance.error("Failed to get account. ${e.toString()}");
      rethrow;
    }
  }

  Future<List<Account>> getAccountsByProfile({required int profileId}) async {
    try {
      return await db.getAccountsByProfile(profileId);
    } catch (e) {
      AppLogger.instance.error("Failed to get accounts list. ${e.toString()}");
      rethrow;
    }
  }

  Future<List<Ledger>> getLedgers({required int profileId}) async {
    try {
      return await db.getLedgers(profileId: profileId);
    } catch (e) {
      AppLogger.instance.error("Failed to get accounts list. ${e.toString()}");
      rethrow;
    }
  }

  Future<List<Ledger>> getLedgersByAccType(
      {required int profileId, required int accTypeID}) async {
    try {
      return await db.getLedgersByAccType(
          profileId: profileId, accTypeID: accTypeID);
    } catch (e) {
      AppLogger.instance.error("Failed to get accounts list. ${e.toString()}");
      rethrow;
    }
  }

  Future<List<Ledger>> getFunds({required int profileId}) async {
    try {
      return await db.getFunds(profileId: profileId);
    } catch (e) {
      AppLogger.instance.error("Failed to get Funds list. ${e.toString()}");
      rethrow;
    }
  }

  Future<List<Ledger>> getCredits({required int profileId}) async {
    try {
      return await db.getCredits(profileId: profileId);
    } catch (e) {
      AppLogger.instance.error("Failed to get Credits list. ${e.toString()}");
      rethrow;
    }
  }

  Future<List<Ledger>> getFundingLedgers({required int profileId}) async {
    try {
      return await db.getFundingLedgers(profileId: profileId);
    } catch (e) {
      AppLogger.instance.error("Failed to get Credits list. ${e.toString()}");
      rethrow;
    }
  }

  Future<List<Account>> getFundAccounts({required int profileId}) async {
    try {
      return await db.getFundAccounts(profileId);
    } catch (e) {
      AppLogger.instance.error("Failed to get Funds list. ${e.toString()}");
      rethrow;
    }
  }

  Future<Map<Bank, Account>> getBanksWithAccounts() async {
    try {
      return await db.getBanksWithAccounts();
    } catch (e) {
      AppLogger.instance.error("Failed to get Banks list. ${e.toString()}");
      rethrow;
    }
  }

  Future<Map<Wallet, Account>> getWalletsWithAccounts() async {
    try {
      return await db.getWalletsWithAccounts();
    } catch (e) {
      AppLogger.instance.error("Failed to get Wallets list. ${e.toString()}");
      rethrow;
    }
  }

  Future<Map<Loan, Account>> getLoansWithAccounts() async {
    try {
      return await db.getLoansWithAccounts();
    } catch (e) {
      AppLogger.instance.error("Failed to get Loans list. ${e.toString()}");
      rethrow;
    }
  }

  Future<Map<CCard, Account>> getCCardsWithAccounts() async {
    try {
      return await db.getCCardsWithAccounts();
    } catch (e) {
      AppLogger.instance
          .error("Failed to get Credit Card list. ${e.toString()}");
      rethrow;
    }
  }

  Future<Wallet> getWalletByAccount(int id) async {
    try {
      return await db.getWalletByAccount(id);
    } catch (e) {
      AppLogger.instance.error("Failed to get Wallet. ${e.toString()}");
      rethrow;
    }
  }

  Future<Bank> getBankByAccount(int id) async {
    try {
      return await db.getBankByAccount(id);
    } catch (e) {
      AppLogger.instance.error("Failed to get Bank. ${e.toString()}");
      rethrow;
    }
  }

  Future<Loan> getLoanByAccount(int id) async {
    try {
      return await db.getLoanByAccount(id);
    } catch (e) {
      AppLogger.instance.error("Failed to get Loan. ${e.toString()}");
      rethrow;
    }
  }

  Future<CCard> getCCardByAccount(int id) async {
    try {
      return await db.getCCardByAccount(id);
    } catch (e) {
      AppLogger.instance.error("Failed to get Credit Card. ${e.toString()}");
      rethrow;
    }
  }

  Future<List<Account>> getAccountsByAccType(int profileId, int accType) async {
    try {
      return await db.getAccountsByAccType(profileId, accType);
    } catch (e) {
      AppLogger.instance.error("Failed to get accounts list. ${e.toString()}");
      rethrow;
    }
  }

  Future<void> insertAccountsBulk(
      List<String> names, int accType, int profile, DateTime openDate) async {
    try {
      List<AccountsCompanion> accounts = names
          .map((a) => AccountsCompanion.insert(
              name: a,
              accType: accType,
              profile: profile,
              openDate: Value(openDate)))
          .toList();
      return await db.insertAccounts(accounts);
    } catch (e) {
      AppLogger.instance
          .error("Failed to insert bulk accounts. ${e.toString()}");
      rethrow;
    }
  }
}
