// Helper class for getting an Account and related tables as a single model.
import 'package:pursenal/core/db/database.dart';

class Ledger {
  final Account account;
  final AccType accType;
  final Balance balance;
  Ledger({required this.account, required this.accType, required this.balance});

  @override
  String toString() =>
      '${account.name} ${accType.name} ${(balance.amount / 1000).toStringAsFixed(3)}'
          .toLowerCase();
}
