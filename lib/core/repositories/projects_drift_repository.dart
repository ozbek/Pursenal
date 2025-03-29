import 'package:drift/drift.dart';
import 'package:pursenal/core/abstracts/base_repository.dart';
import 'package:pursenal/core/db/database.dart';
import 'package:pursenal/core/enums/project_status.dart';
import 'package:pursenal/core/models/project_plan.dart';
import 'package:pursenal/utils/app_logger.dart';

class ProjectsDriftRepository
    implements BaseRepository<Project, ProjectsCompanion> {
  ProjectsDriftRepository(this.db);
  final MyDatabase db;

  Future<int> insertProject({
    required String name,
    ProjectStatus projectStatus = ProjectStatus.pending,
    required int profile,
    int? budget,
    String? description,
    DateTime? startDate,
    DateTime? endDate,
    required List<String> filePaths,
  }) async {
    try {
      final project = ProjectsCompanion.insert(
        status: projectStatus,
        name: name,
        description: Value(description),
        profile: profile,
        startDate: Value(startDate),
        endDate: Value(endDate),
        budget: Value(budget),
      );

      final p = await db.insertProject(project);

      if (filePaths.isNotEmpty) {
        for (var f in filePaths) {
          final fp = ProjectPhotosCompanion.insert(project: p, path: f);
          db.insertProjectPhoto(fp);
        }
      }

      return p;
    } catch (e) {
      AppLogger.instance.error("Failed to insert project. ${e.toString()}");
      rethrow;
    }
  }

  Future<bool> updateProject({
    required int id,
    required String name,
    required int profile,
    ProjectStatus projectStatus = ProjectStatus.pending,
    int? budget,
    String? description,
    DateTime? startDate,
    DateTime? endDate,
    required List<String> filePaths,
  }) async {
    try {
      db.deleteProjectPhotobyProject(id);
      final project = ProjectsCompanion(
          id: Value(id),
          status: Value(projectStatus),
          name: Value(name),
          profile: Value(profile),
          description: Value(description),
          startDate: Value(startDate),
          endDate: Value(endDate),
          budget: Value(budget),
          updateDate: Value(DateTime.now()));

      if (filePaths.isNotEmpty) {
        for (var f in filePaths) {
          final fp = ProjectPhotosCompanion.insert(project: id, path: f);
          db.insertProjectPhoto(fp);
        }
      }

      return await db.updateProject(project);
    } catch (e) {
      AppLogger.instance.error("Failed to update project. ${e.toString()}");
      rethrow;
    }
  }

  Future<bool> updateProjectStatus({
    required int id,
    required String name,
    required int profile,
    ProjectStatus projectStatus = ProjectStatus.pending,
    int? budget,
    String? description,
    DateTime? startDate,
    DateTime? endDate,
  }) async {
    try {
      final project = ProjectsCompanion(
          id: Value(id),
          status: Value(projectStatus),
          name: Value(name),
          profile: Value(profile),
          description: Value(description),
          startDate: Value(startDate),
          endDate: Value(endDate),
          budget: Value(budget),
          updateDate: Value(DateTime.now()));

      return await db.updateProject(project);
    } catch (e) {
      AppLogger.instance.error("Failed to update project. ${e.toString()}");
      rethrow;
    }
  }

  @override
  Future<int> delete(int id) async {
    try {
      return await db.deleteProject(id);
    } catch (e) {
      AppLogger.instance.error("Failed to delete project. ${e.toString()}");
      rethrow;
    }
  }

  Future<int> deleteProject(int id, {bool deleteTransactions = false}) async {
    try {
      if (deleteTransactions) {
        await db.deleteTransactionsByProject(id);
      }
      return await db.deleteProject(id);
    } catch (e) {
      AppLogger.instance.error("Failed to delete project. ${e.toString()}");
      rethrow;
    }
  }

  @override
  Future<Project> getById(int id) async {
    try {
      return await db.getProjectById(id);
    } catch (e) {
      AppLogger.instance.error("Failed to get project. ${e.toString()}");
      rethrow;
    }
  }

  Future<List<Project>> getAllProjects(int profile) async {
    try {
      return await db.getProjectsByProfile(profile);
    } catch (e) {
      AppLogger.instance.error("Failed to get project. ${e.toString()}");
      rethrow;
    }
  }

  Future<ProjectPlan?> getProjectPlanById(int id) async {
    try {
      return await db.getProjectPlan(id);
    } catch (e) {
      AppLogger.instance.error("Failed to get project plan. ${e.toString()}");
      rethrow;
    }
  }
}
