import 'package:flutter/material.dart';
import 'package:pursenal/app/global/dimensions.dart';
import 'package:pursenal/app/extensions/currency.dart';
import 'package:pursenal/core/enums/currency.dart';
import 'package:pursenal/core/models/domain/ledger.dart';
import 'package:pursenal/widgets/shared/search_field.dart';

class AccountsSearchDialog extends StatefulWidget {
  const AccountsSearchDialog(
      {super.key, required this.ledgers, required this.currency});

  final List<Ledger> ledgers;
  final Currency currency;

  @override
  AccountsSearchDialogState createState() => AccountsSearchDialogState();
}

class AccountsSearchDialogState extends State<AccountsSearchDialog> {
  final TextEditingController _searchController = TextEditingController();
  List<Ledger> fLedgers = [];

  @override
  void initState() {
    fLedgers = List.from(widget.ledgers);
    super.initState();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      insetPadding: const EdgeInsets.all(20),
      child: SizedBox(
        width: smallWidth,
        child: Padding(
          padding: const EdgeInsets.all(2),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SearchField(
                autoFocus: true,
                searchFn: (query) {
                  filterList(query);
                },
              ),
              const SizedBox(height: 16),
              fLedgers.isNotEmpty
                  ? SizedBox(
                      height: fLedgers.length > 5 ? 350 : null,
                      child: ListView(
                        padding: const EdgeInsets.only(bottom: 8),
                        shrinkWrap: true,
                        children: fLedgers
                            .map((a) => Material(
                                  color: Colors.transparent,
                                  child: ListTile(
                                    title: Text(a.account.name,
                                        textAlign: TextAlign.start,
                                        overflow: TextOverflow.ellipsis,
                                        style: Theme.of(context)
                                            .textTheme
                                            .titleMedium),
                                    trailing: Column(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.end,
                                      children: [
                                        Text(
                                          a.balance.toCurrencyString(
                                              widget.currency),
                                          style: Theme.of(context)
                                              .textTheme
                                              .titleSmall
                                              ?.copyWith(
                                                  fontWeight: FontWeight.bold),
                                        ),
                                        Text(
                                          a.accountType.name,
                                          style: Theme.of(context)
                                              .textTheme
                                              .labelSmall,
                                        ),
                                      ],
                                    ),
                                    onTap: () {
                                      Navigator.of(context).pop(a.account);
                                    },
                                  ),
                                ))
                            .toList(),
                      ),
                    )
                  : Center(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          "No Items",
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                      ),
                    ),
              const SizedBox(
                height: 8,
              )
            ],
          ),
        ),
      ),
    );
  }

  filterList(String query) {
    setState(() {
      fLedgers = widget.ledgers
          .where(
            (l) => l.toString().toLowerCase().contains(query.toLowerCase()),
          )
          .toList();
    });
  }
}
