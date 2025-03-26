import 'package:drift/drift.dart';
import 'package:pursenal/core/abstracts/base_repository.dart';
import 'package:pursenal/core/db/database.dart';
import 'package:pursenal/utils/app_logger.dart';

class WalletsDriftRepository
    implements BaseRepository<Wallet, WalletsCompanion> {
  WalletsDriftRepository(this.db);
  final MyDatabase db;

  Future<int> insertWallet({required int account}) async {
    try {
      final wallet = WalletsCompanion(
        account: Value(account),
      );
      return await db.insertWallet(wallet);
    } catch (e) {
      AppLogger.instance.error("Failed to insert wallet. ${e.toString()}");
      rethrow;
    }
  }

  Future<bool> updateWallet({required int account, required int id}) async {
    try {
      final wallet = WalletsCompanion(
          account: Value(account),
          id: Value(id),
          updateDate: Value(DateTime.now()));
      return await db.updateWallet(wallet);
    } catch (e) {
      AppLogger.instance.error("Failed to update wallet. ${e.toString()}");
      rethrow;
    }
  }

  @override
  Future<int> delete(int id) async {
    try {
      return await db.deleteWallet(id);
    } catch (e) {
      AppLogger.instance.error("Failed to delete wallet. ${e.toString()}");
      rethrow;
    }
  }

  @override
  Future<Wallet> getById(int id) async {
    try {
      return await db.getWalletById(id);
    } catch (e) {
      AppLogger.instance.error("Failed to get wallet. ${e.toString()}");
      rethrow;
    }
  }
}
