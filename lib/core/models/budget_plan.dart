// Helper class for getting budgets and related tables as a single model.
import 'package:pursenal/core/db/database.dart';

class BudgetPlan {
  final Budget budget;
  final List<Account> funds;
  final Map<Account, int> incomes;
  final Map<Account, int> expenses;

  BudgetPlan(
    this.incomes,
    this.expenses, {
    required this.budget,
    required this.funds,
  });

  @override
  String toString() {
    return '${budget.name} ${funds.map((f) => f.name)} ${incomes.keys.map((f) => f.name)} ${expenses.keys.map((f) => f.name)}'
        .toLowerCase();
  }
}
