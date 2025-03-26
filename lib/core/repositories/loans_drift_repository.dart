import 'package:drift/drift.dart';
import 'package:pursenal/core/abstracts/base_repository.dart';
import 'package:pursenal/core/db/database.dart';
import 'package:pursenal/utils/app_logger.dart';

class LoansDriftRepository implements BaseRepository<Loan, LoansCompanion> {
  LoansDriftRepository(this.db);
  final MyDatabase db;

  Future<int> insertLoan(
      {required int account,
      required String? institution,
      required String? accountNo,
      required String? agreementNo,
      required double? interestRate,
      required DateTime? startDate,
      required DateTime? endDate}) async {
    try {
      final loan = LoansCompanion(
          account: Value(account),
          institution: Value(institution),
          accountNo: Value(accountNo),
          agreementNo: Value(agreementNo),
          interestRate: Value(interestRate),
          startDate: Value(startDate),
          endDate: Value(endDate));
      return await db.insertLoan(loan);
    } catch (e) {
      AppLogger.instance.error("Failed to insert loan. ${e.toString()}");
      rethrow;
    }
  }

  Future<bool> updateLoan(
      {required int id,
      required int account,
      required String? institution,
      required String? accountNo,
      required String? agreementNo,
      required double? interestRate,
      required DateTime? startDate,
      required DateTime? endDate}) async {
    try {
      final loan = LoansCompanion(
        id: Value(id),
        account: Value(account),
        institution: Value(institution),
        accountNo: Value(accountNo),
        agreementNo: Value(agreementNo),
        interestRate: Value(interestRate),
        startDate: Value(startDate),
        endDate: Value(endDate),
      );
      return await db.updateLoan(loan);
    } catch (e) {
      AppLogger.instance.error("Failed to insert loan. ${e.toString()}");
      rethrow;
    }
  }

  @override
  Future<int> delete(int id) async {
    try {
      return await db.deleteLoan(id);
    } catch (e) {
      AppLogger.instance.error("Failed to delete loan. ${e.toString()}");
      rethrow;
    }
  }

  @override
  Future<Loan> getById(int id) async {
    try {
      return await db.getLoanById(id);
    } catch (e) {
      AppLogger.instance.error("Failed to get loan. ${e.toString()}");
      rethrow;
    }
  }
}
