import 'package:pursenal/core/enums/budget_interval.dart';
import 'package:pursenal/core/models/domain/account.dart';

class PaymentReminder {
  final int dbID;
  final Account? account;
  final Account? fund;
  final int profile;
  final BudgetInterval? interval;
  final int? day;
  final DateTime? paymentDate;
  final int amount;
  final DateTime addedDate;
  final DateTime updateDate;

  PaymentReminder({
    required this.dbID,
    this.account,
    this.fund,
    required this.profile,
    this.interval,
    this.day,
    this.paymentDate,
    required this.amount,
    required this.addedDate,
    required this.updateDate,
  });
}
