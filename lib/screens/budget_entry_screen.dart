import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:pursenal/app/global/dimensions.dart';
import 'package:pursenal/app/extensions/currency.dart';
import 'package:pursenal/core/db/database.dart';
import 'package:pursenal/core/enums/budget_interval.dart';
import 'package:pursenal/core/enums/loading_status.dart';
import 'package:pursenal/core/models/budget_plan.dart';
import 'package:pursenal/viewmodels/budget_entry_viewmodel.dart';
import 'package:pursenal/widgets/shared/calculated_field.dart';
import 'package:pursenal/widgets/shared/loading_body.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class BudgetEntryScreen extends StatelessWidget {
  const BudgetEntryScreen({super.key, required this.profile, this.budgetPlan});

  final Profile profile;

  final BudgetPlan? budgetPlan;
  @override
  Widget build(BuildContext context) {
    final db = Provider.of<MyDatabase>(context);

    return ChangeNotifierProvider<BudgetEntryViewmodel>(
      create: (context) =>
          BudgetEntryViewmodel(db: db, profile: profile, budgetPlan: budgetPlan)
            ..init(),
      child: Consumer<BudgetEntryViewmodel>(
        builder: (context, viewmodel, child) => Scaffold(
          appBar: AppBar(
            title: Text(AppLocalizations.of(context)!.budgetForm),
            actions: [
              Visibility(
                  visible: budgetPlan != null,
                  child: IconButton(
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                          content: Text(AppLocalizations.of(context)!
                              .deleteBudgetWarning),
                          actions: [
                            TextButton(
                                onPressed: () async {
                                  final hasDeleted =
                                      await viewmodel.deleteBudget();
                                  if (hasDeleted && context.mounted) {
                                    Navigator.pop(context);
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
                                child:
                                    Text(AppLocalizations.of(context)!.cancel))
                          ],
                          title: Text(
                              AppLocalizations.of(context)!.deleteThisBudgetQn),
                        ),
                      );
                    },
                    icon: const Icon(Icons.delete),
                    color: Colors.red,
                  )),
              const SizedBox(
                width: 12,
              ),
            ],
          ),
          body: LoadingBody(
            errorText: viewmodel.errorText,
            loadingStatus: viewmodel.loadingStatus,
            resetErrorTextFn: () {
              viewmodel.resetErrorText();
            },
            widget: BudgetForm(
              profile: profile,
              viewmodel: viewmodel,
            ),
          ),
        ),
      ),
    );
  }
}

class BudgetForm extends StatelessWidget {
  const BudgetForm({super.key, required this.viewmodel, required this.profile});

  final BudgetEntryViewmodel viewmodel;

  final Profile profile;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        width: smallWidth,
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 4, horizontal: 8),
                      child: TextFormField(
                        initialValue: viewmodel.name,
                        decoration: InputDecoration(
                          labelText: AppLocalizations.of(context)!.budgetName,
                          errorText: viewmodel.nameError.isNotEmpty
                              ? viewmodel.nameError
                              : null,
                        ),
                        onChanged: (value) {
                          viewmodel.name = value;
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 4, horizontal: 8),
                      child: TextFormField(
                        initialValue: viewmodel.details,
                        decoration: InputDecoration(
                          labelText: AppLocalizations.of(context)!.details,
                          errorText: viewmodel.detailsError.isNotEmpty
                              ? viewmodel.detailsError
                              : null,
                        ),
                        onChanged: (value) {
                          viewmodel.details = value;
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 4, horizontal: 8),
                      child: DropdownMenu<BudgetInterval>(
                        initialSelection: viewmodel.interval,
                        errorText: viewmodel.intervalError.isNotEmpty
                            ? viewmodel.intervalError
                            : null,
                        label: Text(AppLocalizations.of(context)!.accountType),
                        width: smallWidth,
                        dropdownMenuEntries: [
                          ...BudgetInterval.values.map(
                            (a) => DropdownMenuEntry(
                              style: ButtonStyle(
                                  textStyle: WidgetStatePropertyAll(
                                Theme.of(context).textTheme.bodyMedium,
                              )),
                              value: a,
                              label: a.label,
                            ),
                          ),
                        ],
                        onSelected: (value) {
                          if (value != null) {
                            viewmodel.interval = value;
                          }
                        },
                      ),
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    ExpansionTile(
                      title: Text(
                        AppLocalizations.of(context)!.funds,
                        style: Theme.of(context).textTheme.headlineSmall,
                      ),
                      children: [
                        ...viewmodel.funds.map((e) => CheckboxListTile(
                              value: viewmodel.selectedFunds.contains(e.id),
                              onChanged: (v) {
                                viewmodel.toggleFund(e.id);
                              },
                              title: Text(e.name),
                            ))
                      ],
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    ExpansionTile(
                      initiallyExpanded: true,
                      title: Text(
                        AppLocalizations.of(context)!.incomes,
                        style: Theme.of(context).textTheme.headlineSmall,
                      ),
                      trailing: Text(
                        viewmodel.incomesTotal
                            .toCurrencyStringWSymbol(profile.currency),
                        style: Theme.of(context).textTheme.headlineSmall,
                      ),
                      children: [
                        ...viewmodel.incomes.map((e) => ListTile(
                              title: Row(
                                children: [
                                  Expanded(child: Text(e.name)),
                                  Expanded(
                                      child: CalculatedField(
                                    currency: profile.currency,
                                    onChanged: (value) {
                                      if (value != null) {
                                        viewmodel.addIncome(
                                            e.id, (value * 1000).toInt());
                                      }
                                    },
                                    label: e.name,
                                    amount: viewmodel.getIncomeAmt(e.id) / 1000,
                                  )),
                                ],
                              ),
                            ))
                      ],
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    ExpansionTile(
                      initiallyExpanded: true,
                      title: Text(
                        AppLocalizations.of(context)!.expenses,
                        style: Theme.of(context).textTheme.headlineSmall,
                      ),
                      trailing: Text(
                        viewmodel.expenseTotal
                            .toCurrencyStringWSymbol(profile.currency),
                        style: Theme.of(context).textTheme.headlineSmall,
                      ),
                      children: [
                        ...viewmodel.expenses.map((e) => ListTile(
                              title: Row(
                                children: [
                                  Expanded(child: Text(e.name)),
                                  Expanded(
                                      child: CalculatedField(
                                    currency: profile.currency,
                                    onChanged: (value) {
                                      if (value != null) {
                                        viewmodel.addExpense(
                                            e.id, (value * 1000).toInt());
                                      }
                                    },
                                    label: e.name,
                                    amount:
                                        viewmodel.getExpenseAmt(e.id) / 1000,
                                  )),
                                ],
                              ),
                            ))
                      ],
                    ),
                  ],
                ),
              ),
            ),
            ListTile(
              leading: Text(
                AppLocalizations.of(context)!.savings,
                style: Theme.of(context).textTheme.headlineSmall,
              ),
              trailing: Text(
                viewmodel.difference.toCurrencyStringWSymbol(profile.currency),
                style: Theme.of(context).textTheme.headlineSmall,
              ),
            ),
            Center(
              child: SizedBox(
                width: smallWidth,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ElevatedButton(
                    onPressed: () async {
                      if (viewmodel.loadingStatus != LoadingStatus.submitting) {
                        bool isSaved = await viewmodel.save();
                        if (isSaved && context.mounted) {
                          Navigator.pop(context);
                        }
                      }
                    },
                    child: Text(AppLocalizations.of(context)!.save,
                        style: const TextStyle(fontSize: 22)),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
