import 'package:pursenal/core/abstracts/base_repository.dart';
import 'package:pursenal/core/db/database.dart';
import 'package:pursenal/utils/app_logger.dart';

class AccTypesDriftRepository
    implements BaseRepository<AccType, AccTypesCompanion> {
  AccTypesDriftRepository(this.db);
  final MyDatabase db;

  Future<List<AccType>> getAll() async {
    try {
      return await db.getAccTypes();
    } catch (e) {
      AppLogger.instance.error("Failed to get AccType list. ${e.toString()}");
      rethrow;
    }
  }

  @override
  Future<int> delete(int id) async {
    try {
      return 0;
    } catch (e) {
      AppLogger.instance.error("Failed to delete AccType. ${e.toString()}");
      rethrow;
    }
  }

  @override
  Future<AccType> getById(int id) async {
    try {
      return await db.getAccTypeById(id);
    } catch (e) {
      AppLogger.instance.error("Failed to get AccType. ${e.toString()}");
      rethrow;
    }
  }

  Future<List<AccType>> getFundAccTypes() async {
    try {
      return await db.getFundAccTypes();
    } catch (e) {
      AppLogger.instance
          .error("Failed to get Fund AccType list. ${e.toString()}");
      rethrow;
    }
  }

  Future<List<AccType>> getCreditAccTypes() async {
    try {
      return await db.getCreditAccTypes();
    } catch (e) {
      AppLogger.instance
          .error("Failed to get Credi AccType list. ${e.toString()}");
      rethrow;
    }
  }

  Future<List<AccType>> getFundingAccTypes() async {
    try {
      return await db.getFundingAccTypes();
    } catch (e) {
      AppLogger.instance.error(
          "Failed to get Funding Accounts AccType list. ${e.toString()}");
      rethrow;
    }
  }

  Future<AccType> getAccTypeByType(int type) async {
    try {
      return await db.getAccTypeByType(type);
    } catch (e) {
      AppLogger.instance.error(
          "Failed to get Accounts AccType by primary type. ${e.toString()}");
      rethrow;
    }
  }

  Future<List<AccType>> getBalanceAccTypes() async {
    try {
      return await db.getBalanceAccTypes();
    } catch (e) {
      AppLogger.instance.error(
          "Failed to get Balance Accounts AccType list. ${e.toString()}");
      rethrow;
    }
  }
}
