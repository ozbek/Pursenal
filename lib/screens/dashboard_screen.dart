import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:provider/provider.dart';
import 'package:pursenal/core/db/database.dart';
import 'package:pursenal/screens/accounts_screen.dart';
import 'package:pursenal/screens/budgets_screen.dart';
import 'package:pursenal/viewmodels/app_viewmodel.dart';
import 'package:pursenal/viewmodels/dashboard_viewmodel.dart';
import 'package:pursenal/widgets/dashboard/add_new_account_card.dart';
import 'package:pursenal/widgets/dashboard/add_transaction_card.dart';
import 'package:pursenal/widgets/dashboard/my_balance_card.dart';
import 'package:pursenal/widgets/dashboard/transactions_card.dart';
import 'package:pursenal/widgets/shared/loading_body.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

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
                      Container(
                        padding: const EdgeInsets.all(8),
                        width: double.infinity,
                        height: 92,
                        child: Center(
                          child: SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Card(
                                  elevation: 1,
                                  shape: RoundedRectangleBorder(
                                      side: BorderSide(
                                          color:
                                              Theme.of(context).primaryColor),
                                      borderRadius: BorderRadius.circular(14)),
                                  child: InkWell(
                                    borderRadius: BorderRadius.circular(14),
                                    onTap: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) => BudgetsScreen(
                                              profile:
                                                  viewmodel.selectedProfile,
                                            ),
                                          ));
                                    },
                                    child: Container(
                                      padding: EdgeInsets.all(16),
                                      height: double.maxFinite,
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceAround,
                                        children: [
                                          Text(
                                            AppLocalizations.of(context)!
                                                .myBudgets,
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodyLarge
                                                ?.copyWith(fontSize: 18),
                                          ),
                                          const SizedBox(
                                            width: 10,
                                          ),
                                          Icon(
                                            Icons.calculate,
                                            color: Theme.of(context)
                                                .textTheme
                                                .bodyLarge
                                                ?.color,
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                                Card(
                                  elevation: 1,
                                  shape: RoundedRectangleBorder(
                                      side: BorderSide(
                                          color:
                                              Theme.of(context).primaryColor),
                                      borderRadius: BorderRadius.circular(14)),
                                  child: InkWell(
                                    borderRadius: BorderRadius.circular(14),
                                    onTap: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                AccountsScreen(
                                              profile:
                                                  viewmodel.selectedProfile,
                                            ),
                                          ));
                                    },
                                    child: Container(
                                      padding: EdgeInsets.all(16),
                                      height: double.maxFinite,
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceAround,
                                        children: [
                                          Text(
                                            "${AppLocalizations.of(context)!.expenses} & ${AppLocalizations.of(context)!.incomes}",
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodyLarge
                                                ?.copyWith(fontSize: 18),
                                          ),
                                          const SizedBox(
                                            width: 10,
                                          ),
                                          Icon(
                                            Icons.table_chart_outlined,
                                            color: Theme.of(context)
                                                .textTheme
                                                .bodyLarge
                                                ?.color,
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      )
                          .animate(delay: 100.ms)
                          .scale(
                              begin: const Offset(1.02, 1.02), duration: 100.ms)
                          .fade(curve: Curves.easeInOut, duration: 100.ms),
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
