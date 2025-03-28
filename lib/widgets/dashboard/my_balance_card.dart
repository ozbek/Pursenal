import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:provider/provider.dart';
import 'package:pursenal/app/global/dimensions.dart';
import 'package:pursenal/app/extensions/currency.dart';
import 'package:pursenal/core/db/database.dart';
import 'package:pursenal/viewmodels/dashboard_viewmodel.dart';
import 'package:pursenal/viewmodels/main_viewmodel.dart';
import 'package:pursenal/widgets/shared/the_divider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class MyBalanceCard extends StatelessWidget {
  const MyBalanceCard({
    super.key,
    required this.profile,
    required this.viewmodel,
  });

  final Profile profile;
  final DashboardViewmodel viewmodel;

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: const BoxConstraints(
          maxWidth: cardWidth, minWidth: 300, minHeight: 200),
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Row(
                  children: [
                    const Expanded(child: TheDivider()),
                    Text(
                      AppLocalizations.of(context)!.myBalance,
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    const Expanded(child: TheDivider()),
                  ],
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              SizedBox(
                height: 100,
                child: Stack(
                  children: [
                    Positioned.fill(
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Opacity(
                          opacity: 0.2, // Adjust transparency
                          child: IgnorePointer(
                            child: LineChart(LineChartData(
                              gridData: const FlGridData(show: false),
                              titlesData: const FlTitlesData(show: false),
                              borderData: FlBorderData(show: false),
                              lineBarsData: [
                                LineChartBarData(
                                  spots: List.generate(
                                      viewmodel.balances.length,
                                      (index) => FlSpot(
                                          index.toDouble(),
                                          viewmodel.balances[index]
                                              .toCurrency())),
                                  isCurved: true,
                                  color: Colors.blue,
                                  dotData: const FlDotData(show: false),
                                  belowBarData: BarAreaData(),
                                ),
                              ],
                            )),
                          ),
                        ),
                      ),
                    ),
                    Center(
                      child: Text(
                        viewmodel.closingBalance
                            .toCurrencyStringWSymbol(profile.currency),
                        style: Theme.of(context)
                            .textTheme
                            .headlineLarge
                            ?.copyWith(fontSize: 44),
                        textScaler: const TextScaler.linear(.88),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextButton(
                    onPressed: () {
                      Provider.of<MainViewmodel>(context, listen: false)
                          .setIndex(1);
                    },
                    child: Text(AppLocalizations.of(context)!.details)),
              )
            ],
          ),
        ),
      )
          .animate()
          .scale(begin: const Offset(1.02, 1.02), duration: 100.ms)
          .fade(curve: Curves.easeInOut, duration: 100.ms),
    );
  }
}
