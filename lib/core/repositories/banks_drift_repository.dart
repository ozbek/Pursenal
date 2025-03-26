import 'package:drift/drift.dart';
import 'package:pursenal/core/abstracts/base_repository.dart';
import 'package:pursenal/core/db/database.dart';
import 'package:pursenal/utils/app_logger.dart';

class BanksDriftRepository implements BaseRepository<Bank, BanksCompanion> {
  BanksDriftRepository(this.db);
  final MyDatabase db;

  Future<int> insertBank(
      {required int account,
      required String? branch,
      required String? branchCode,
      required String? holderName,
      required String? accountNo,
      required String? institution}) async {
    try {
      final bank = BanksCompanion(
        account: Value(account),
        accountNo: Value(accountNo),
        branch: Value(branch),
        branchCode: Value(branchCode),
        holderName: Value(holderName),
        institution: Value(institution),
      );
      return await db.insertBank(bank);
    } catch (e) {
      AppLogger.instance.error("Failed to insert bank. ${e.toString()}");
      rethrow;
    }
  }

  Future<bool> updateBank(
      {required int id,
      required int account,
      required String? branch,
      required String? branchCode,
      required String? accountNo,
      required String? holderName,
      required String? institution}) async {
    try {
      final bank = BanksCompanion(
        id: Value(id),
        account: Value(account),
        accountNo: Value(accountNo),
        branch: Value(branch),
        branchCode: Value(branchCode),
        holderName: Value(holderName),
        institution: Value(
          institution,
        ),
      );
      return await db.updateBank(bank);
    } catch (e) {
      AppLogger.instance.error("Failed to insert bank. ${e.toString()}");
      rethrow;
    }
  }

  @override
  Future<int> delete(int id) async {
    try {
      return await db.deleteBank(id);
    } catch (e) {
      AppLogger.instance.error("Failed to delete bank. ${e.toString()}");
      rethrow;
    }
  }

  @override
  Future<Bank> getById(int id) async {
    try {
      return await db.getBankById(id);
    } catch (e) {
      AppLogger.instance.error("Failed to get bank. ${e.toString()}");
      rethrow;
    }
  }
}
