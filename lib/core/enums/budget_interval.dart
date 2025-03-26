// Time Interval for a budget to be based on.
enum BudgetInterval {
  weekly('Weekly'),
  monthly('Monthly'),
  annual('Annual'),
  ;

  const BudgetInterval(this.label);
  final String label;
}
