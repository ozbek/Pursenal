import 'package:drift/drift.dart';
import 'package:pursenal/core/abstracts/base_repository.dart';
import 'package:pursenal/core/db/database.dart';
import 'package:pursenal/utils/app_logger.dart';

class CCardsDriftRepository implements BaseRepository<CCard, CCardsCompanion> {
  CCardsDriftRepository(this.db);
  final MyDatabase db;

  Future<int> insertCCard({
    required int account,
    required String? institution,
    required String? cardNetwork,
    required String? cardNo,
    required int? statementDate,
  }) async {
    try {
      final card = CCardsCompanion(
        account: Value(account),
        institution: Value(institution),
        cardNetwork: Value(cardNetwork),
        cardNo: Value(cardNo),
        statementDate: Value(statementDate),
      );
      return await db.insertCCard(card);
    } catch (e) {
      AppLogger.instance.error("Failed to insert card. ${e.toString()}");
      rethrow;
    }
  }

  Future<bool> updateCCard({
    required int id,
    required int account,
    required String? institution,
    required String? cardNetwork,
    required String? cardNo,
    required int? statementDate,
  }) async {
    try {
      final card = CCardsCompanion(
        id: Value(id),
        account: Value(account),
        institution: Value(institution),
        cardNetwork: Value(cardNetwork),
        cardNo: Value(cardNo),
        statementDate: Value(statementDate),
      );
      return await db.updateCCard(card);
    } catch (e) {
      AppLogger.instance.error("Failed to update card. ${e.toString()}");
      rethrow;
    }
  }

  @override
  Future<int> delete(int id) async {
    try {
      return await db.deleteCCard(id);
    } catch (e) {
      AppLogger.instance.error("Failed to delete card. ${e.toString()}");
      rethrow;
    }
  }

  @override
  Future<CCard> getById(int id) async {
    try {
      return await db.getCCardById(id);
    } catch (e) {
      AppLogger.instance.error("Failed to get card. ${e.toString()}");
      rethrow;
    }
  }
}
