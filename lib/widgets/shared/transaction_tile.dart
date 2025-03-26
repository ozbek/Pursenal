import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:pursenal/app/global/date_formats.dart';
import 'package:pursenal/app/extensions/currency.dart';
import 'package:pursenal/core/enums/currency.dart';
import 'package:pursenal/core/enums/voucher_type.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:pursenal/viewmodels/app_viewmodel.dart';

class TransactionTile extends StatelessWidget {
  const TransactionTile(
      {super.key,
      required this.vchDate,
      required this.accountName,
      required this.amount,
      required this.onClick,
      required this.vchType,
      required this.transactionID,
      this.fundName,
      required this.narr,
      this.isTransfer = false,
      required this.currency,
      this.isColorful = false,
      this.isNegative = false});
  final DateTime vchDate;
  final String accountName;
  final int amount;
  final Function onClick;
  final VoucherType vchType;
  final int transactionID;
  final String? fundName;
  final String narr;
  final bool isTransfer;
  final bool isNegative;
  final Currency currency;
  final bool isColorful;

  @override
  Widget build(BuildContext context) {
    final appViewmodel = Provider.of<AppViewmodel>(context);
    return Material(
      color: Colors.transparent,
      child: ListTile(
        minVerticalPadding: 2,
        visualDensity: const VisualDensity(horizontal: 0.5, vertical: 0.5),
        title: LayoutBuilder(builder: (context, constraints) {
          bool isWide = constraints.maxWidth > 800;
          if (isWide) {
            return Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    "#$transactionID",
                    style: Theme.of(context)
                        .textTheme
                        .labelSmall
                        ?.copyWith(fontWeight: FontWeight.bold),
                  ),
                ),
                Expanded(
                  flex: 4,
                  child: Text(
                    appViewmodel.dateFormat.format(vchDate),
                  ),
                ),
                Expanded(
                  flex: 6,
                  child: Text(
                    accountName,
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context).textTheme.titleMedium,
                    maxLines: 2,
                  ),
                ),
                Expanded(
                  flex: 4,
                  child: Text(
                    fundName != null
                        ? isTransfer
                            ? AppLocalizations.of(context)!
                                .transferFrom(fundName!)
                            : vchType == VoucherType.payment
                                ? AppLocalizations.of(context)!
                                    .paidFrom(fundName!)
                                : AppLocalizations.of(context)!
                                    .receivedIn(fundName!)
                        : narr,
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.start,
                    style: Theme.of(context).textTheme.titleSmall,
                  ),
                ),
                Expanded(
                  flex: 4,
                  child: Text(
                    "${isTransfer ? "" : isNegative ? "-" : "+"} ${amount.toCurrencyString(currency)}",
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        color: (isTransfer) || !isColorful
                            ? null
                            : isNegative
                                ? appViewmodel.paymentColor
                                : appViewmodel.receiptColor),
                    maxLines: 2,
                    overflow: TextOverflow.fade,
                    textAlign: TextAlign.end,
                  ),
                ),
              ],
            );
          }
          return Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "#$transactionID",
                    style: Theme.of(context)
                        .textTheme
                        .labelSmall
                        ?.copyWith(fontWeight: FontWeight.bold),
                  ),
                  Expanded(
                    child: Text(
                      fundName != null
                          ? isTransfer
                              ? AppLocalizations.of(context)!
                                  .transferFrom(fundName!)
                              : vchType == VoucherType.payment
                                  ? AppLocalizations.of(context)!
                                      .paidFrom(fundName!)
                                  : AppLocalizations.of(context)!
                                      .receivedIn(fundName!)
                          : "",
                      overflow: TextOverflow.ellipsis,
                      textAlign: TextAlign.end,
                      style: Theme.of(context).textTheme.titleSmall,
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(2, 2, 2, 2),
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            style: const TextStyle(
                                fontSize: 20, fontWeight: FontWeight.w500),
                            vchDate.day.toString(),
                          ),
                          Text(
                            style: const TextStyle(fontSize: 10),
                            monthString.format(vchDate),
                          ),
                          Text(
                            yearString.format(vchDate),
                            style: const TextStyle(fontSize: 10),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          accountName,
                          overflow: TextOverflow.ellipsis,
                          style: Theme.of(context).textTheme.titleMedium,
                          maxLines: 2,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 10),
                          child: Text(narr,
                              overflow: TextOverflow.ellipsis,
                              style: Theme.of(context).textTheme.titleSmall),
                        )
                      ],
                    ),
                  ),
                  Text(
                    "${isTransfer ? "" : isNegative ? "-" : "+"} ${amount.toCurrencyString(currency)}",
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        color: (isTransfer) || !isColorful
                            ? null
                            : isNegative
                                ? appViewmodel.paymentColor
                                : appViewmodel.receiptColor),
                    maxLines: 2,
                    overflow: TextOverflow.fade,
                  ),
                ],
              ),
            ],
          );
        }),
        onTap: () {
          onClick();
        },
      ),
    );
  }
}
