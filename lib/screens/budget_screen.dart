import 'package:collection/collection.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:provider/provider.dart';
import 'package:pursenal/app/extensions/currency.dart';
import 'package:pursenal/app/global/dimensions.dart';
import 'package:pursenal/core/db/database.dart';
import 'package:pursenal/core/models/budget_plan.dart';
import 'package:pursenal/screens/budget_entry_screen.dart';
import 'package:pursenal/viewmodels/app_viewmodel.dart';
import 'package:pursenal/viewmodels/budget_viewmodel.dart';
import 'package:pursenal/widgets/shared/acc_type_icon.dart';
import 'package:pursenal/widgets/shared/loading_body.dart';
import 'package:pursenal/widgets/shared/progress_bar.dart';
import 'package:pursenal/widgets/shared/the_divider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class BudgetScreen extends StatelessWidget {
  const BudgetScreen(
      {super.key, required this.profile, required this.budgetPlan});
  final Profile profile;
  final BudgetPlan budgetPlan;

  @override
  Widget build(BuildContext context) {
    final db = Provider.of<MyDatabase>(context);
    final appViewmodel = Provider.of<AppViewmodel>(context);
    return ChangeNotifierProvider<BudgetViewmodel>(
      create: (context) =>
          BudgetViewmodel(db: db, profile: profile, budgetPlan: budgetPlan)
            ..init(),
      builder: (context, child) => Consumer<BudgetViewmodel>(
        builder: (context, viewmodel, child) => Scaffold(
            appBar: AppBar(
              actions: [
                IconButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => BudgetEntryScreen(
                              profile: profile,
                              budgetPlan: viewmodel.budgetPlan,
                            ),
                          )).then((_) => viewmodel.refetchBudget());
                    },
                    icon: const Icon(Icons.edit)),
                IconButton(
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                        content: Text(
                            AppLocalizations.of(context)!.deleteBudgetWarning),
                        actions: [
                          TextButton(
                              onPressed: () async {
                                final hasDeleted =
                                    await viewmodel.deleteBudget();
                                if (hasDeleted && context.mounted) {
                                  Navigator.pop(context);
                                  Navigator.pop(context);
                                }
                              },
                              child: Text(
                                AppLocalizations.of(context)!.delete,
                                style: const TextStyle(
                                    color: Colors.red,
                                    fontWeight: FontWeight.bold),
                              )),
                          TextButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              child: Text(AppLocalizations.of(context)!.cancel))
                        ],
                        title: Text(
                            AppLocalizations.of(context)!.deleteThisBudgetQn),
                      ),
                    );
                  },
                  icon: const Icon(Icons.delete),
                  color: Colors.red,
                ),
                const SizedBox(
                  width: 12,
                )
              ],
            ),
            body: LoadingBody(
                loadingStatus: viewmodel.loadingStatus,
                errorText: viewmodel.errorText,
                widget: SingleChildScrollView(
                  child: Column(
                    children: [
                      Center(
                        child: SizedBox(
                          width: smallWidth,
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  Expanded(
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 16, vertical: 4),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            viewmodel.budgetPlan.budget.name,
                                            overflow: TextOverflow.ellipsis,
                                            style: Theme.of(context)
                                                .textTheme
                                                .headlineMedium,
                                          ),
                                          Text(
                                            viewmodel.budgetPlan.budget.details,
                                            overflow: TextOverflow.ellipsis,
                                            style: Theme.of(context)
                                                .textTheme
                                                .titleMedium,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Chip(
                                        label: Text(
                                      viewmodel
                                          .budgetPlan.budget.interval.label,
                                      overflow: TextOverflow.ellipsis,
                                    )),
                                  )
                                ],
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 16),
                                child: Expanded(
                                  child: SingleChildScrollView(
                                    scrollDirection: Axis.horizontal,
                                    child: Row(
                                      children: [
                                        const Text("Tracked Funds : "),
                                        ...viewmodel.budgetPlan.funds.map(
                                          (f) => Padding(
                                            padding: const EdgeInsets.all(1.0),
                                            child: Chip(
                                              avatar: Icon(
                                                getAccTypeIcon(f.accType),
                                                color: Colors.white,
                                              ),
                                              shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(5)),
                                              padding: const EdgeInsets.all(2),
                                              color: WidgetStatePropertyAll(
                                                  Theme.of(context)
                                                      .primaryColor),
                                              label: Text(
                                                f.name,
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(
                                height: 12,
                              )
                            ],
                          ),
                        ),
                      ),
                      Wrap(
                        children: [
                          Card(
                            child: Container(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 24),
                              width: cardWidth,
                              child: Column(
                                children: [
                                  const SizedBox(
                                    height: 12,
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        AppLocalizations.of(context)!.incomes,
                                        style: Theme.of(context)
                                            .textTheme
                                            .titleMedium,
                                      ),
                                      Text(
                                        viewmodel.aIncomeTotal
                                            .toCurrencyString(profile.currency),
                                        style: Theme.of(context)
                                            .textTheme
                                            .titleMedium,
                                      ),
                                    ],
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: [
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              AppLocalizations.of(context)!
                                                  .expected,
                                              overflow: TextOverflow.ellipsis,
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .bodyMedium,
                                            ),
                                            Text(
                                              viewmodel.expectedAvgInc
                                                  .toCurrencyString(
                                                      profile.currency),
                                              overflow: TextOverflow.ellipsis,
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .bodyMedium,
                                            ),
                                          ],
                                        ),
                                      ),
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              AppLocalizations.of(context)!
                                                  .budgeted,
                                              overflow: TextOverflow.ellipsis,
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .bodyMedium,
                                            ),
                                            Text(
                                              viewmodel.bIncomeTotal
                                                  .toCurrencyString(
                                                      profile.currency),
                                              overflow: TextOverflow.ellipsis,
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .bodyMedium,
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                  const Padding(
                                    padding:
                                        EdgeInsets.symmetric(vertical: 2.0),
                                    child: TheDivider(
                                      indent: 0,
                                    ),
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        AppLocalizations.of(context)!.expenses,
                                        style: Theme.of(context)
                                            .textTheme
                                            .titleMedium,
                                      ),
                                      Text(
                                        viewmodel.aExpenseTotal
                                            .toCurrencyString(profile.currency),
                                        style: Theme.of(context)
                                            .textTheme
                                            .titleMedium,
                                      ),
                                    ],
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: [
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              AppLocalizations.of(context)!
                                                  .expected,
                                              overflow: TextOverflow.ellipsis,
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .bodyMedium,
                                            ),
                                            Text(
                                              viewmodel.expectedAvgExp
                                                  .toCurrencyString(
                                                      profile.currency),
                                              overflow: TextOverflow.ellipsis,
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .bodyMedium,
                                            ),
                                          ],
                                        ),
                                      ),
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              AppLocalizations.of(context)!
                                                  .budgeted,
                                              overflow: TextOverflow.ellipsis,
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .bodyMedium,
                                            ),
                                            Text(
                                              viewmodel.bExpenseTotal
                                                  .toCurrencyString(
                                                      profile.currency),
                                              overflow: TextOverflow.ellipsis,
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .bodyMedium,
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                  const Padding(
                                    padding:
                                        EdgeInsets.symmetric(vertical: 2.0),
                                    child: TheDivider(
                                      indent: 0,
                                    ),
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        AppLocalizations.of(context)!.savings,
                                        style: Theme.of(context)
                                            .textTheme
                                            .titleMedium,
                                      ),
                                      Text(
                                        viewmodel.aDifference
                                            .toCurrencyString(profile.currency),
                                        style: Theme.of(context)
                                            .textTheme
                                            .titleMedium,
                                      ),
                                    ],
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: [
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              AppLocalizations.of(context)!
                                                  .expected,
                                              overflow: TextOverflow.ellipsis,
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .bodyMedium,
                                            ),
                                            Text(
                                              viewmodel.expectedAvgDif
                                                  .toCurrencyString(
                                                      profile.currency),
                                              overflow: TextOverflow.ellipsis,
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .bodyMedium,
                                            ),
                                          ],
                                        ),
                                      ),
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              AppLocalizations.of(context)!
                                                  .budgeted,
                                              overflow: TextOverflow.ellipsis,
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .bodyMedium,
                                            ),
                                            Text(
                                              viewmodel.bDifference
                                                  .toCurrencyString(
                                                      profile.currency),
                                              overflow: TextOverflow.ellipsis,
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .bodyMedium,
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 12,
                                  )
                                ],
                              ),
                            ),
                          )
                              .animate(delay: 0.ms)
                              .scale(
                                  begin: const Offset(1.02, 1.02),
                                  duration: 100.ms)
                              .fade(curve: Curves.easeInOut, duration: 100.ms),
                          Card(
                            child: Container(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 4),
                              width: cardWidth,
                              child: Column(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 10, vertical: 4),
                                    child: Row(
                                      children: [
                                        const Expanded(child: TheDivider()),
                                        Text(
                                          AppLocalizations.of(context)!
                                              .budgetPerformance,
                                          style: Theme.of(context)
                                              .textTheme
                                              .titleMedium,
                                        ),
                                        const Expanded(child: TheDivider()),
                                      ],
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 8,
                                  ),
                                  Container(
                                    height: 200,
                                    padding: const EdgeInsets.all(2),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(8),
                                      gradient: LinearGradient(
                                          begin: Alignment.bottomCenter,
                                          end: Alignment.topCenter,
                                          colors: [
                                            Theme.of(context)
                                                .scaffoldBackgroundColor,
                                            Theme.of(context)
                                                .scaffoldBackgroundColor
                                                .withAlpha(100)
                                          ]),
                                    ),
                                    child: Row(
                                      children: [
                                        if (viewmodel.incomeTotals.isNotEmpty)
                                          Expanded(
                                            child: PieChart(
                                              duration: const Duration(
                                                  microseconds: 1500),
                                              PieChartData(
                                                  sectionsSpace: 0.5,
                                                  startDegreeOffset: 180,
                                                  centerSpaceRadius: 0,
                                                  sections: [
                                                    PieChartSectionData(
                                                      title:
                                                          "${AppLocalizations.of(context)!.incomes}\n${((viewmodel.aIncomeTotal / viewmodel.bIncomeTotal) * 100).round()}%",
                                                      titleStyle:
                                                          const TextStyle(
                                                              fontSize: 14,
                                                              color:
                                                                  Colors.white,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold),
                                                      color: appViewmodel
                                                          .receiptColor,
                                                      radius: 70,
                                                      value: viewmodel
                                                          .aIncomeTotal
                                                          .abs()
                                                          .toCurrency(),
                                                    ),
                                                    if (viewmodel.aIncomeTotal
                                                            .abs() <
                                                        viewmodel.bIncomeTotal
                                                            .abs())
                                                      PieChartSectionData(
                                                        title: "",
                                                        color: Colors.grey
                                                            .withAlpha(110),
                                                        radius: 70,
                                                        value: (viewmodel
                                                                    .bIncomeTotal
                                                                    .abs() -
                                                                viewmodel
                                                                    .aIncomeTotal
                                                                    .abs())
                                                            .abs()
                                                            .toCurrency(),
                                                      ),
                                                  ]),
                                            ),
                                          ),
                                        if (viewmodel.expenseTotals.isNotEmpty)
                                          Expanded(
                                            child: PieChart(
                                              duration: const Duration(
                                                  microseconds: 1500),
                                              PieChartData(
                                                  sectionsSpace: 0.5,
                                                  startDegreeOffset: 180,
                                                  centerSpaceRadius: 0,
                                                  sections: [
                                                    PieChartSectionData(
                                                      title:
                                                          "${AppLocalizations.of(context)!.expenses}\n${((viewmodel.aExpenseTotal / viewmodel.bExpenseTotal) * 100).round()}%",
                                                      titleStyle:
                                                          const TextStyle(
                                                              fontSize: 14,
                                                              color:
                                                                  Colors.white,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold),
                                                      color: appViewmodel
                                                          .paymentColor,
                                                      radius: 70,
                                                      value: viewmodel
                                                          .aExpenseTotal
                                                          .abs()
                                                          .toCurrency(),
                                                    ),
                                                    if (viewmodel.aExpenseTotal
                                                            .abs() <
                                                        viewmodel.bExpenseTotal
                                                            .abs())
                                                      PieChartSectionData(
                                                        title: "",
                                                        color: Colors.grey
                                                            .withAlpha(110),
                                                        radius: 70,
                                                        value: (viewmodel
                                                                    .bExpenseTotal -
                                                                viewmodel
                                                                    .aExpenseTotal)
                                                            .abs()
                                                            .toCurrency(),
                                                      ),
                                                  ]),
                                            ),
                                          ),
                                      ],
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 16,
                                  )
                                ],
                              ),
                            ),
                          )
                              .animate(delay: 50.ms)
                              .scale(
                                  begin: const Offset(1.02, 1.02),
                                  duration: 100.ms)
                              .fade(curve: Curves.easeInOut, duration: 100.ms),
                          Card(
                            child: Container(
                              width: cardWidth,
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 4.0),
                              child: Column(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 10, vertical: 4),
                                    child: Row(
                                      children: [
                                        const Expanded(child: TheDivider()),
                                        Text(
                                          "${AppLocalizations.of(context)!.incomes} V/s ${AppLocalizations.of(context)!.expenses}",
                                          style: Theme.of(context)
                                              .textTheme
                                              .titleMedium,
                                        ),
                                        const Expanded(child: TheDivider()),
                                      ],
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 6,
                                  ),
                                  Container(
                                    height: 200,
                                    padding: const EdgeInsets.all(2),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(8),
                                      gradient: LinearGradient(
                                          begin: Alignment.bottomCenter,
                                          end: Alignment.topCenter,
                                          colors: [
                                            Theme.of(context)
                                                .scaffoldBackgroundColor,
                                            Theme.of(context)
                                                .scaffoldBackgroundColor
                                                .withAlpha(100)
                                          ]),
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.all(16.0),
                                      child: LineChart(LineChartData(
                                        titlesData: FlTitlesData(
                                          topTitles: const AxisTitles(),
                                          leftTitles: const AxisTitles(),
                                          bottomTitles: AxisTitles(
                                            sideTitles: SideTitles(
                                              showTitles: true,
                                              getTitlesWidget: (double value,
                                                  TitleMeta meta) {
                                                // Format date from your list
                                                final dateIndex = value
                                                    .toInt(); // Convert X value to index
                                                if (dateIndex >= 0 &&
                                                    dateIndex <
                                                        viewmodel.rangeDates
                                                            .length) {
                                                  final date = viewmodel
                                                      .rangeDates[dateIndex];
                                                  return Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            top: 8.0),
                                                    child: Text(
                                                      ("${date.day}"), // Use a formatter for your date
                                                      style: Theme.of(context)
                                                          .textTheme
                                                          .labelSmall,
                                                    ),
                                                  );
                                                }
                                                return const SizedBox();
                                              },
                                            ),
                                          ),
                                        ),
                                        borderData: FlBorderData(show: false),
                                        lineBarsData: [
                                          LineChartBarData(
                                            curveSmoothness: 0.02,
                                            spots: [
                                              ...viewmodel
                                                  .dailyTotalTransactions
                                                  .mapIndexed((i, t) => FlSpot(
                                                      i.toDouble(),
                                                      t.paymentsTotal
                                                          .toCurrency()
                                                          .roundToDouble()))
                                            ],
                                            isCurved: true,
                                            color: appViewmodel.paymentColor,
                                            dotData:
                                                const FlDotData(show: false),
                                            aboveBarData: BarAreaData(
                                              show: true,
                                              color: Colors.red.shade200,
                                              applyCutOffY: true,
                                            ),
                                          ),
                                          LineChartBarData(
                                            curveSmoothness: 0.02,
                                            spots: [
                                              ...viewmodel
                                                  .dailyTotalTransactions
                                                  .mapIndexed((i, t) => FlSpot(
                                                      i.toDouble(),
                                                      t.receiptsTotal
                                                          .toCurrency()
                                                          .roundToDouble()))
                                            ],
                                            isCurved: true,
                                            color: appViewmodel.receiptColor,
                                            dotData:
                                                const FlDotData(show: false),
                                            aboveBarData: BarAreaData(
                                              show: true,
                                              color: Colors.red.shade200,
                                              applyCutOffY: true,
                                            ),
                                          ),
                                        ],
                                      )),
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 16,
                                  )
                                ],
                              ),
                            ),
                          )
                              .animate(delay: 100.ms)
                              .scale(
                                  begin: const Offset(1.02, 1.02),
                                  duration: 100.ms)
                              .fade(curve: Curves.easeInOut, duration: 100.ms),
                          Card(
                            child: Container(
                              width: cardWidth,
                              padding: const EdgeInsets.all(4.0),
                              child: Column(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 10, vertical: 4),
                                    child: Row(
                                      children: [
                                        const Expanded(child: TheDivider()),
                                        Text(
                                          AppLocalizations.of(context)!
                                              .budgetedExpenses,
                                          style: Theme.of(context)
                                              .textTheme
                                              .titleMedium,
                                        ),
                                        const Expanded(child: TheDivider()),
                                      ],
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 6,
                                  ),
                                  Container(
                                    padding: const EdgeInsets.all(2),
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(8),
                                        color: Theme.of(context)
                                            .scaffoldBackgroundColor),
                                    child: Column(
                                      children: [
                                        ...viewmodel.budgetPlan.expenses.entries
                                            .mapIndexed((index, b) {
                                          final Account acc = b.key;

                                          int expA = viewmodel
                                                  .expenseTotals.entries
                                                  .firstWhereOrNull(
                                                      (e) => e.key.id == acc.id)
                                                  ?.value ??
                                              0;

                                          int expB = viewmodel
                                                  .budgetPlan.expenses[acc] ??
                                              0;
                                          return Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Expanded(
                                                child: Text(
                                                  acc.name,
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .labelSmall,
                                                  textAlign: TextAlign.end,
                                                  maxLines: 2,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                ),
                                              ),
                                              Expanded(
                                                flex: 5,
                                                child: ProgressBar(
                                                    currency: profile.currency,
                                                    progress:
                                                        (-expA).toCurrency(),
                                                    max: (-expB).toCurrency()),
                                              ),
                                            ],
                                          );
                                        })
                                      ],
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 12,
                                  )
                                ],
                              ),
                            ),
                          )
                              .animate(delay: 150.ms)
                              .scale(
                                  begin: const Offset(1.02, 1.02),
                                  duration: 100.ms)
                              .fade(curve: Curves.easeInOut, duration: 100.ms),
                        ],
                      ),
                      const SizedBox(
                        height: 24,
                      )
                    ],
                  ),
                ),
                resetErrorTextFn: () {
                  viewmodel.resetErrorText();
                })),
      ),
    );
  }
}
