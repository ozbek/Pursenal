import 'package:drift/drift.dart';
import 'package:pursenal/core/abstracts/base_repository.dart';
import 'package:pursenal/core/db/database.dart';
import 'package:pursenal/utils/app_logger.dart';

class FilePathsDriftRepository
    implements BaseRepository<FilePath, FilePathsCompanion> {
  FilePathsDriftRepository(this.db);
  final MyDatabase db;

  Future<int> insertPath(
      {required String path, required int transaction}) async {
    try {
      final filePath = FilePathsCompanion(
          path: Value(path), transaction: Value(transaction));
      return await db.insertFilePath(filePath);
    } catch (e) {
      AppLogger.instance.error("Failed to insert filePath. ${e.toString()}");
      rethrow;
    }
  }

  Future<bool> updatePath(
      {required String path, required int transaction, required int id}) async {
    try {
      final filePath = FilePathsCompanion(
          id: Value(id), path: Value(path), transaction: Value(transaction));
      return await db.updateFilePath(filePath);
    } catch (e) {
      AppLogger.instance.error("Failed to update filePath. ${e.toString()}");
      rethrow;
    }
  }

  @override
  Future<int> delete(int id) async {
    try {
      return await db.deleteFilePath(id);
    } catch (e) {
      AppLogger.instance.error("Failed to delete filePath. ${e.toString()}");
      rethrow;
    }
  }

  @override
  Future<FilePath> getById(int id) async {
    try {
      return await db.getFilePathById(id);
    } catch (e) {
      AppLogger.instance.error("Failed to get filePath. ${e.toString()}");
      rethrow;
    }
  }

  Future<int> deletePath(String path) async {
    try {
      return await db.deletePath(path);
    } catch (e) {
      AppLogger.instance.error("Failed to delete filePath. ${e.toString()}");
      rethrow;
    }
  }
}
