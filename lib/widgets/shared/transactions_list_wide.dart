import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:pursenal/app/global/values.dart';
import 'package:pursenal/core/db/database.dart';
import 'package:pursenal/core/enums/voucher_type.dart';
import 'package:pursenal/core/models/double_entry.dart';
import 'package:pursenal/screens/transaction_screen.dart';
import 'package:pursenal/widgets/shared/transaction_tile.dart';

class TransactionsListWide extends StatelessWidget {
  const TransactionsListWide({
    super.key,
    required this.scrollController,
    required this.fTransactions,
    required this.profile,
    required this.initFn,
    this.account,
  });

  final ScrollController scrollController;
  final List<DoubleEntry> fTransactions;
  final Profile profile;
  final Function initFn;
  final Account? account;

  @override
  Widget build(BuildContext context) {
    final bool hasAccount = account != null;
    final bool isColorful = !hasAccount ||
        (hasAccount && fundingAccountIDs.contains(account!.accType));
    return ListView.builder(
      cacheExtent: 20,
      controller: scrollController,
      padding: const EdgeInsets.only(bottom: 100),
      itemCount: fTransactions.length,
      itemBuilder: (context, index) {
        final t = fTransactions[index];
        final int amount = t.transaction.amount;

        final bool isTransfer =
            fundingAccountIDs.contains(t.drAccount.accType) &&
                fundingAccountIDs.contains(t.crAccount.accType) &&
                !hasAccount;

        final Account acc = hasAccount
            ? [t.crAccount, t.drAccount].firstWhere((a) => a.id != account!.id)
            : (t.transaction.vchType == VoucherType.payment
                ? t.drAccount
                : t.crAccount);

        final bool isNegative = !isTransfer &&
            ((t.transaction.vchType == VoucherType.payment &&
                    (!hasAccount || account!.id == t.crAccount.id)) ||
                (t.transaction.vchType == VoucherType.receipt &&
                    t.crAccount.id != acc.id &&
                    fundingAccountIDs.contains(t.crAccount.accType)));

        final String accountName = acc.name;
        final String? fundName = hasAccount
            ? null
            : (t.transaction.vchType == VoucherType.receipt
                ? t.drAccount.name
                : t.crAccount.name);

        return TransactionTile(
          isColorful: isColorful,
          currency: profile.currency,
          vchDate: t.transaction.vchDate,
          isNegative: isNegative,
          accountName: accountName,
          isTransfer: isTransfer,
          amount: amount,
          onClick: () {
            Navigator.of(context)
                .push(
                  MaterialPageRoute(
                    builder: (context) => TransactionScreen(
                      doubleEntry: t,
                      profile: profile,
                    ),
                  ),
                )
                .then((_) => initFn());
          },
          vchType: t.transaction.vchType,
          transactionID: t.transaction.id,
          narr: t.transaction.narr,
          fundName: fundName,
        ).animate().fade(duration: 250.ms);
      },
    );
  }
}
