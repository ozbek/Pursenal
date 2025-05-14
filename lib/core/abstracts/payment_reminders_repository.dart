import 'package:pursenal/core/enums/budget_interval.dart';
import 'package:pursenal/core/enums/payment_status.dart';
import 'package:pursenal/core/models/domain/account.dart';
import 'package:pursenal/core/models/domain/payment_reminder.dart';

abstract class PaymentRemindersRepository {
  Future<int> insertPaymentReminder({
    Account? account,
    required int profile,
    PaymentStatus status = PaymentStatus.pending,
    required int amount,
    BudgetInterval? interval,
    required String details,
    DateTime? paymentDate,
    Account? fund,
    int day = 1,
    required List<String> filePaths,
  });

  Future<bool> updatePaymentReminder({
    required int id,
    Account? account,
    required int profile,
    PaymentStatus status = PaymentStatus.pending,
    required int amount,
    BudgetInterval? interval,
    required String details,
    DateTime? paymentDate,
    Account? fund,
    int day = 1,
    required List<String> filePaths,
  });

  Future<bool> updatePaymentReminderStatus({
    required int id,
    Account? account,
    required int profile,
    PaymentStatus status = PaymentStatus.pending,
    required int amount,
    BudgetInterval? interval,
    required String details,
    DateTime? paymentDate,
    Account? fund,
    int day = 1,
  });

  Future<int> delete(int id);
  Future<int> deletePaymentReminder(int id, {bool deleteTransactions = false});
  Future<PaymentReminder> getById(int id);
  Future<List<PaymentReminder>> getAllPaymentReminders(int profile);
  Future<PaymentReminder?> getPaymentReminderByID(int id);
}
