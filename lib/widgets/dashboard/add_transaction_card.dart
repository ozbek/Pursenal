import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:pursenal/app/global/dimensions.dart';
import 'package:pursenal/core/db/database.dart';
import 'package:pursenal/core/enums/voucher_type.dart';
import 'package:pursenal/viewmodels/app_viewmodel.dart';
import 'package:pursenal/viewmodels/dashboard_viewmodel.dart';
import 'package:pursenal/widgets/shared/transaction_options_dialog.dart';
import 'package:pursenal/widgets/shared/the_divider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

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
                        const Icon(
                          Icons.arrow_drop_up,
                          size: 30,
                        ),
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
                        const Icon(
                          Icons.arrow_drop_down,
                          size: 30,
                        ),
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
