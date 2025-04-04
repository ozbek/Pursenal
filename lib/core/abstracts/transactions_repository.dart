import 'package:pursenal/core/enums/voucher_type.dart';
import 'package:pursenal/core/models/domain/transaction.dart';

abstract class TransactionsRepository {
  Future<int> insertTransaction(
      {required DateTime vchDate,
      required String narr,
      required String refNo,
      required int dr,
      required int cr,
      required int amount,
      required VoucherType vchType,
      required int profile,
      int? project});

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
      int? project});

  Future<int> delete(int id);

  Future<List<Transaction>> getTransactions(
      {required DateTime startDate,
      required DateTime endDate,
      required int profileId});

  Future<List<Transaction>> getTransactionsbyAccount(
      {required DateTime startDate,
      required DateTime endDate,
      required int profileId,
      required int accountId,
      reversed = true});

  Future<int?> getLastTransactionID();

  Future<List<Transaction>> getNTransactions(
      {required int n, required int profileId});

  Future<Transaction> getTransactionById({required int transactionID});

  Future<List<Transaction>> getTransactionsbyProject({
    required int profileID,
    required int projectID,
  });

  Future<int> insertPhotoPath({required String path, required int transaction});

  Future<bool> updatePhotoPath(
      {required String path, required int transaction, required int id});

  Future<int> deletePath(int id);

  Future<String> getById(int id);

  Future<int> deletePhotoPathbyPath(String path);
}
