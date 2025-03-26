import 'package:drift/drift.dart';
import 'package:pursenal/core/abstracts/base_repository.dart';
import 'package:pursenal/core/db/database.dart';
import 'package:pursenal/core/enums/currency.dart';
import 'package:pursenal/utils/app_logger.dart';

class ProfilesDriftRepository
    implements BaseRepository<Profile, ProfilesCompanion> {
  ProfilesDriftRepository(this.db);
  final MyDatabase db;

  Future<List<Profile>> getAll() async {
    try {
      return await db.getProfiles();
    } catch (e) {
      AppLogger.instance.error("Failed to get profiles list. ${e.toString()}");
      rethrow;
    }
  }

  Future<int> insertProfile({
    required String name,
    required String? alias,
    required Currency currency,
    required String? address,
    required String? zip,
    required String? email,
    required String? phone,
    required String? tin,
  }) async {
    try {
      final profile = ProfilesCompanion(
        name: Value(name),
        alias: Value(alias),
        currency: Value(currency),
        address: Value(address),
        zip: Value(zip),
        email: Value(email),
        phone: Value(phone),
        tin: Value(tin),
      );
      return await db.insertProfile(profile);
    } catch (e) {
      AppLogger.instance.error("Failed to insert profile. ${e.toString()}");
      rethrow;
    }
  }

  Future<bool> updateProfile({
    required int id,
    required String name,
    required String? alias,
    required Currency currency,
    required String? address,
    required String? zip,
    required String? email,
    required String? phone,
    required String? tin,
  }) async {
    try {
      final profile = ProfilesCompanion(
          id: Value(id),
          name: Value(name),
          alias: Value(alias),
          currency: Value(currency),
          address: Value(address),
          zip: Value(zip),
          email: Value(email),
          phone: Value(phone),
          tin: Value(tin),
          updateDate: Value(DateTime.now()));
      return await db.updateProfile(profile);
    } catch (e) {
      AppLogger.instance.error("Failed to update profile. ${e.toString()}");
      rethrow;
    }
  }

  @override
  Future<int> delete(int id) async {
    try {
      return await db.deleteProfile(id);
    } catch (e) {
      AppLogger.instance.error("Failed to delete profile. ${e.toString()}");
      rethrow;
    }
  }

  @override
  Future<Profile> getById(int id) async {
    try {
      return await db.getProfileById(id);
    } catch (e) {
      AppLogger.instance.error("Failed to get profile. ${e.toString()}");
      rethrow;
    }
  }

  Future<Profile?> getSelectedProfile() async {
    try {
      return await db.getSelectedProfile();
    } catch (e) {
      AppLogger.instance
          .error("Failed to get selected profile. ${e.toString()}");
      rethrow;
    }
  }

  Future<void> setSelectedProfile(int id) async {
    try {
      return await db.setSelectedProfile(id);
    } catch (e) {
      AppLogger.instance
          .error("Failed to set selected profile. ${e.toString()}");
      rethrow;
    }
  }
}
