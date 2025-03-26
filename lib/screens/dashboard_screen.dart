import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:provider/provider.dart';
import 'package:pursenal/app/global/dimensions.dart';
import 'package:pursenal/app/global/values.dart';
import 'package:pursenal/app/extensions/currency.dart';
import 'package:pursenal/core/db/database.dart';
import 'package:pursenal/core/enums/voucher_type.dart';
import 'package:pursenal/screens/account_entry_screen.dart';
import 'package:pursenal/screens/transaction_screen.dart';
import 'package:pursenal/viewmodels/app_viewmodel.dart';
import 'package:pursenal/viewmodels/dashboard_viewmodel.dart';
import 'package:pursenal/viewmodels/main_viewmodel.dart';
import 'package:pursenal/widgets/shared/transaction_options_dialog.dart';
import 'package:pursenal/widgets/shared/acc_type_icon.dart';
import 'package:pursenal/widgets/shared/loading_body.dart';
import 'package:pursenal/widgets/shared/the_divider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:pursenal/widgets/shared/transaction_tile.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key, required this.profile});
  final Profile profile;

  @override
  Widget build(BuildContext context) {
    final db = Provider.of<MyDatabase>(context);
    final appViewmodel = Provider.of<AppViewmodel>(context);
    return ChangeNotifierProvider<DashboardViewmodel>(
      create: (context) => DashboardViewmodel(db: db, profile: profile)..init(),
      builder: (context, child) => Consumer<DashboardViewmodel>(
        builder: (context, viewmodel, child) => Scaffold(
          body: LoadingBody(
            loadingStatus: viewmodel.loadingStatus,
            errorText: viewmodel.errorText,
            widget: SingleChildScrollView(
              child: Column(
                children: [
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 8),
                      child: Text(
                        AppLocalizations.of(context)!.myDashboard,
                        style: Theme.of(context).textTheme.headlineMedium,
                      ),
                    ),
                  ),
                  Wrap(
                    alignment: WrapAlignment.center,
                    runAlignment: WrapAlignment.center,
                    children: [
                      MyBalanceCard(
                        profile: profile,
                        viewmodel: viewmodel,
                      ),
                      Visibility(
                          visible: viewmodel.canAddTransaction,
                          child: AddTransactionCard(
                            appViewmodel: appViewmodel,
                            profile: profile,
                            viewmodel: viewmodel,
                          )),
                      Visibility(
                          visible: viewmodel.recentTransactions.isNotEmpty,
                          child: TransactionsCard(
                            viewmodel: viewmodel,
                          )),
                      Visibility(
                          visible: viewmodel.fAccTypes.isNotEmpty,
                          child: AddNewAccountCard(
                            viewmodel: viewmodel,
                          )),
                      const SizedBox(
                        height: 300,
                      )
                    ],
                  ),
                ],
              ),
            ),
            resetErrorTextFn: () => viewmodel.resetErrorText(),
          ),
        ),
      ),
    );
  }
}

class AddTransactionCard extends StatelessWidget {
  const AddTransactionCard({
    super.key,
    required this.appViewmodel,
    required this.profile,
    required this.viewmodel,
  });

  final AppViewmodel appViewmodel;
  final Profile profile;
  final DashboardViewmodel viewmodel;

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: const BoxConstraints(
        maxWidth: cardWidth,
      ),
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
                      AppLocalizations.of(context)!.add,
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    const Expanded(child: TheDivider()),
                  ],
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.all(2.0),
                child: SizedBox(
                  width: double.maxFinite,
                  height: 50,
                  child: ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor:
                          WidgetStatePropertyAll(appViewmodel.receiptColor),
                      shape: WidgetStateProperty.all(
                        const RoundedRectangleBorder(
                          borderRadius: BorderRadius.only(
                            topRight: Radius.circular(10),
                            topLeft: Radius.circular(10),
                          ),
                        ),
                      ),
                    ),
                    onPressed: () async {
                      await showDialog(
                        context: context,
                        builder: (context) => TransactionOptionsDialog(
                          currency: profile.currency,
                          ledgers: viewmodel.allLedgers,
                          profile: profile,
                          vType: VoucherType.receipt,
                          reloadFn: () async {
                            await viewmodel.init();
                          },
                        ),
                      );
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          AppLocalizations.of(context)!.receipt,
                          style: Theme.of(context)
                              .textTheme
                              .titleMedium
                              ?.copyWith(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Icon(getAccTypeIcon(incomeTypeID)),
                      ],
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(2.0),
                child: SizedBox(
                  width: double.maxFinite,
                  height: 50,
                  child: ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor:
                          WidgetStatePropertyAll(appViewmodel.paymentColor),
                      shape: WidgetStateProperty.all(
                        const RoundedRectangleBorder(
                          borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(10),
                            bottomRight: Radius.circular(10),
                          ),
                        ),
                      ),
                    ),
                    onPressed: () async {
                      await showDialog(
                        context: context,
                        builder: (context) => TransactionOptionsDialog(
                          currency: profile.currency,
                          ledgers: viewmodel.allLedgers,
                          profile: profile,
                          vType: VoucherType.payment,
                          reloadFn: () async {
                            await viewmodel.init();
                          },
                        ),
                      );
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          AppLocalizations.of(context)!.payment,
                          style: Theme.of(context)
                              .textTheme
                              .titleMedium
                              ?.copyWith(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Icon(getAccTypeIcon(expenseTypeID)),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      )
          .animate(delay: 50.ms)
          .scale(begin: const Offset(1.02, 1.02), duration: 100.ms)
          .fade(curve: Curves.easeInOut, duration: 100.ms),
    );
  }
}

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

class TransactionsCard extends StatelessWidget {
  const TransactionsCard({
    super.key,
    required this.viewmodel,
  });

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
                      AppLocalizations.of(context)!.recentTransactions,
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    const Expanded(child: TheDivider()),
                  ],
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              ...viewmodel.recentTransactions.map((d) => TransactionTile(
                  isColorful: true,
                  isNegative: d.transaction.vchType == VoucherType.payment,
                  vchDate: d.transaction.vchDate,
                  accountName: d.transaction.vchType == VoucherType.payment
                      ? d.drAccount.name
                      : d.crAccount.name,
                  amount: d.transaction.amount,
                  isTransfer:
                      (fundingAccountIDs.contains(d.drAccount.accType) &&
                          fundingAccountIDs.contains(d.crAccount.accType)),
                  onClick: () {
                    Navigator.of(context)
                        .push(MaterialPageRoute(
                      builder: (context) => TransactionScreen(
                        doubleEntry: d,
                        profile: viewmodel.selectedProfile,
                      ),
                    ))
                        .then((_) {
                      viewmodel.init();
                    });
                  },
                  vchType: d.transaction.vchType,
                  transactionID: d.transaction.id,
                  narr: d.transaction.narr,
                  currency: viewmodel.selectedProfile.currency)),
              viewmodel.recentTransactions.length >= viewmodel.recentCount
                  ? Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextButton(
                          onPressed: () {
                            Provider.of<MainViewmodel>(context, listen: false)
                                .setIndex(2);
                          },
                          child: Text(AppLocalizations.of(context)!.more)),
                    )
                  : const SizedBox(
                      height: 12,
                    )
            ],
          ),
        ),
      )
          .animate(delay: 100.ms)
          .scale(begin: const Offset(1.02, 1.02), duration: 100.ms)
          .fade(curve: Curves.easeInOut, duration: 100.ms),
    );
  }
}

class AddNewAccountCard extends StatelessWidget {
  const AddNewAccountCard({
    super.key,
    required this.viewmodel,
  });
  final DashboardViewmodel viewmodel;

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: const BoxConstraints(
        maxWidth: cardWidth,
      ),
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
                      AppLocalizations.of(context)!.addAccount,
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    const Expanded(child: TheDivider()),
                  ],
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              ...viewmodel.fAccTypes.map((a) => _createAddNewAccountBtn(
                  context, viewmodel.selectedProfile, a.name, a)),
              const SizedBox(
                height: 12,
              ),
            ],
          ),
        ),
      )
          .animate(delay: 150.ms)
          .scale(begin: const Offset(1.02, 1.02), duration: 100.ms)
          .fade(curve: Curves.easeInOut, duration: 100.ms),
    );
  }

  Padding _createAddNewAccountBtn(
      BuildContext context, Profile profile, String label, AccType acctype) {
    return Padding(
      padding: const EdgeInsets.all(2.0),
      child: SizedBox(
        width: double.maxFinite,
        height: 50,
        child: ElevatedButton(
          style: ButtonStyle(
            backgroundColor: WidgetStatePropertyAll(
                Theme.of(context).primaryColor.withAlpha(20)),
            elevation: const WidgetStatePropertyAll(0),
            shape: WidgetStatePropertyAll(
              RoundedRectangleBorder(
                borderRadius: const BorderRadius.all(Radius.circular(10)),
                side: BorderSide(
                  color: Theme.of(context).primaryColor,
                  width: 0.5,
                ),
              ),
            ),
          ),
          onPressed: () async {
            Navigator.of(context)
                .push(MaterialPageRoute(
              builder: (context) => AccountEntryScreen(
                profile: profile,
                accType: acctype,
              ),
            ))
                .then((_) {
              viewmodel.init();
            });
          },
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                label,
                style: Theme.of(context)
                    .textTheme
                    .bodyLarge
                    ?.copyWith(fontWeight: FontWeight.bold, fontSize: 20),
              ),
              Icon(
                getAccTypeIcon(acctype.id),
                size: 24,
                color: Theme.of(context).textTheme.bodyLarge?.color,
              )
            ],
          ),
        ),
      ),
    );
  }
}
