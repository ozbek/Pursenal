import 'package:drift/drift.dart';
import 'package:pursenal/core/abstracts/base_repository.dart';
import 'package:pursenal/core/db/database.dart';
import 'package:pursenal/core/enums/voucher_type.dart';
import 'package:pursenal/core/models/double_entry.dart';
import 'package:pursenal/utils/app_logger.dart';

class TransactionsDriftRepository
    implements BaseRepository<Transaction, TransactionsCompanion> {
  TransactionsDriftRepository(this.db);
  final MyDatabase db;

  Future<int> insertTransaction(
      {required DateTime vchDate,
      required String narr,
      required String refNo,
      required int dr,
      required int cr,
      required int amount,
      required VoucherType vchType,
      required int profile,
      int? project}) async {
    try {
      final transaction = TransactionsCompanion(
          vchDate: Value(vchDate),
          narr: Value(narr),
          refNo: Value(refNo),
          dr: Value(dr),
          cr: Value(cr),
          project: Value(project),
          amount: Value(amount),
          vchType: Value(vchType),
          profile: Value(profile));
      AppLogger.instance.info("Inserting transaction");
      return await db.insertTransaction(transaction);
    } catch (e) {
      AppLogger.instance.error("Failed to insert transaction. ${e.toString()}");
      rethrow;
    }
  }

  Future<bool> updateTransaction(
      {required int id,
      required DateTime vchDate,
      required String narr,
      required String refNo,
      required int dr,
      required int cr,
      required int amount,
      required VoucherType vchType,
      required int profile,
      int? project}) async {
    try {
      final transaction = TransactionsCompanion(
          id: Value(id),
          vchDate: Value(vchDate),
          narr: Value(narr),
          refNo: Value(refNo),
          dr: Value(dr),
          cr: Value(cr),
          amount: Value(amount),
          vchType: Value(vchType),
          profile: Value(profile),
          project: Value(project),
          updateDate: Value(DateTime.now()));
      AppLogger.instance.info("Updating transaction id: $id");
      return await db.updateTransaction(transaction);
    } catch (e) {
      AppLogger.instance.error("Failed to update transaction. ${e.toString()}");
      rethrow;
    }
  }

  @override
  Future<int> delete(int id) async {
    try {
      AppLogger.instance.info("Deleting Transaction: $id");
      return await db.deleteTransaction(id);
    } catch (e) {
      AppLogger.instance.error("Failed to delete transaction. ${e.toString()}");
      rethrow;
    }
  }

  @override
  Future<Transaction> getById(int id) async {
    try {
      return await db.getTransactionById(id);
    } catch (e) {
      AppLogger.instance.error("Failed to get transaction. ${e.toString()}");
      rethrow;
    }
  }

  Future<List<DoubleEntry>> getDoubleEntries(
      {required DateTime startDate,
      required DateTime endDate,
      required int profileId}) async {
    try {
      AppLogger.instance.info("Loading Transactions");
      return await db.getDoubleEntries(
          startDate: startDate.copyWith(hour: 0, minute: 0, second: 0),
          endDate: endDate.copyWith(hour: 23, minute: 59, second: 59),
          profileId: profileId);
    } catch (e) {
      AppLogger.instance
          .error("Failed to get transactions list. ${e.toString()}");
      rethrow;
    }
  }

  Future<List<DoubleEntry>> getDoubleEntriesbyAccount(
      {required DateTime startDate,
      required DateTime endDate,
      required int profileId,
      required int accountId,
      reversed = true}) async {
    try {
      AppLogger.instance.info("Loading Transactions for account : $accountId");

      return await db.getDoubleEntriesbyAccount(
        startDate: startDate.copyWith(hour: 0, minute: 0, second: 0),
        endDate: endDate.copyWith(hour: 23, minute: 59, second: 59),
        profileId: profileId,
        accountId: accountId,
        reversed: reversed,
      );
    } catch (e) {
      AppLogger.instance
          .error("Failed to get transactions list. ${e.toString()}");
      rethrow;
    }
  }

  Future<int?> getLastTransactionID() async {
    try {
      return await db.getLastTransactionID();
    } catch (e) {
      AppLogger.instance.error("Failed to get transaction id. ${e.toString()}");
      rethrow;
    }
  }

  Future<List<DoubleEntry>> getNDoubleEntries(
      {required int n, required int profileId}) async {
    try {
      AppLogger.instance.info("Loading $n Transactions");

      return await db.getNDoubleEntries(n, profileId);
    } catch (e) {
      AppLogger.instance
          .error("Failed to get transactions list. ${e.toString()}");
      rethrow;
    }
  }

  Future<DoubleEntry> getDoubleEntryById({required int transactionID}) async {
    try {
      AppLogger.instance.info("Loading Transaction");

      return await db.getDoubleEntryById(transactionID);
    } catch (e) {
      AppLogger.instance.error("Failed to get transaction. ${e.toString()}");
      rethrow;
    }
  }

  Future<List<DoubleEntry>> getDoubleEntriesbyProject({
    required int profileID,
    required int projectID,
  }) async {
    try {
      AppLogger.instance.info("Loading Transactions for project : $projectID");

      return await db.getDoubleEntriesbyProject(
          profileID: profileID, projectID: projectID);
    } catch (e) {
      AppLogger.instance
          .error("Failed to get transactions list. ${e.toString()}");
      rethrow;
    }
  }
}
