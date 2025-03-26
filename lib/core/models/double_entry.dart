// Helper class for getting a transaction and related tables as a single model.
import 'package:pursenal/core/db/database.dart';

class DoubleEntry {
  final Transaction transaction;
  final Account drAccount;
  final Account crAccount;
  final List<FilePath> filePaths;

  DoubleEntry({
    required this.transaction,
    required this.drAccount,
    required this.crAccount,
    required this.filePaths,
  });

  @override
  String toString() {
    return "#${transaction.id} ${drAccount.id} ${drAccount.name} ${crAccount.id} ${crAccount.name} ${(transaction.amount / 1000).toStringAsFixed(3)} ${transaction.refNo} ${transaction.narr}"
        .toLowerCase();
  }
}
