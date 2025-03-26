import 'dart:io';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:provider/provider.dart';
import 'package:pursenal/app/global/date_formats.dart';
import 'package:pursenal/app/global/dimensions.dart';
import 'package:pursenal/app/global/values.dart';
import 'package:pursenal/app/extensions/currency.dart';
import 'package:pursenal/core/db/database.dart';
import 'package:pursenal/core/enums/voucher_type.dart';
import 'package:pursenal/core/models/double_entry.dart';
import 'package:pursenal/screens/transaction_entry_screen.dart';
import 'package:pursenal/viewmodels/app_viewmodel.dart';
import 'package:pursenal/viewmodels/transaction_viewmodel.dart';
import 'package:pursenal/widgets/shared/loading_body.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class TransactionScreen extends StatelessWidget {
  const TransactionScreen({
    super.key,
    required this.profile,
    required this.doubleEntry,
  });
  final Profile profile;

  final DoubleEntry doubleEntry;

  @override
  Widget build(BuildContext context) {
    final db = Provider.of<MyDatabase>(context);
    final appViewmodel = Provider.of<AppViewmodel>(context);
    return ChangeNotifierProvider<TransactionViewmodel>(
      create: (context) => TransactionViewmodel(
          profile: profile, db: db, doubleEntry: doubleEntry)
        ..init(),
      child: Consumer<TransactionViewmodel>(
        builder: (context, viewmodel, child) {
          final Transaction transaction = viewmodel.doubleEntry.transaction;

          return LoadingBody(
              loadingStatus: viewmodel.loadingStatus,
              errorText: viewmodel.errorText,
              resetErrorTextFn: () {
                viewmodel.resetErrorText();
              },
              widget: Scaffold(
                appBar: AppBar(
                  title: Text(AppLocalizations.of(context)!
                      .transactionNo(transaction.id)),
                  actions: [
                    Padding(
                      padding: const EdgeInsets.all(2.0),
                      child: IconButton(
                          onPressed: () {
                            Navigator.of(context)
                                .push(MaterialPageRoute(
                              builder: (context) => TransactionEntryScreen(
                                doubleEntry: viewmodel.doubleEntry,
                                profile: profile,
                              ),
                            ))
                                .then((_) {
                              viewmodel.refetchTransaction();
                            });
                          },
                          icon: const Icon(Icons.edit)),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(2.0),
                      child: IconButton(
                          onPressed: () {
                            Navigator.of(context)
                                .push(MaterialPageRoute(
                              builder: (context) => TransactionEntryScreen(
                                dupeTransaction: transaction,
                                profile: profile,
                              ),
                            ))
                                .then((_) {
                              viewmodel.init();
                            });
                          },
                          icon: const Icon(Icons.copy)),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(2.0),
                      child: IconButton(
                          color: Colors.red,
                          onPressed: () {
                            showDialog(
                              context: context,
                              builder: (context) => AlertDialog(
                                actions: [
                                  TextButton(
                                      onPressed: () async {
                                        final hasDeleted =
                                            await viewmodel.deleteTransaction();
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
                                      child: Text(
                                          AppLocalizations.of(context)!.cancel))
                                ],
                                title: Text(AppLocalizations.of(context)!
                                    .deleteThisTransactionQn),
                              ),
                            );
                          },
                          icon: const Icon(Icons.delete)),
                    ),
                    const SizedBox(
                      width: 8,
                    )
                  ],
                ),
                body: SizedBox(
                  height: double.infinity,
                  child: SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        children: [
                          viewmodel.doubleEntry.filePaths.isNotEmpty
                              ? Padding(
                                  padding: const EdgeInsets.all(14.0),
                                  child: SingleChildScrollView(
                                    scrollDirection: Axis.horizontal,
                                    child: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      spacing: 8,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: viewmodel.doubleEntry.filePaths
                                          .mapIndexed((index, filePath) {
                                        return Material(
                                          elevation: 3,
                                          child: ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(0),
                                            child: GestureDetector(
                                              onTap: () {
                                                showDialog(
                                                  context: context,
                                                  builder: (context) => Stack(
                                                    children: [
                                                      Dialog(
                                                        backgroundColor:
                                                            Colors.transparent,
                                                        shape: Border.all(),
                                                        child: SizedBox(
                                                          child: Image.file(
                                                            errorBuilder: (context,
                                                                    error,
                                                                    stackTrace) =>
                                                                const Center(
                                                              child: Padding(
                                                                padding:
                                                                    EdgeInsets
                                                                        .all(
                                                                            8.0),
                                                                child: Text(
                                                                    "Media error"),
                                                              ),
                                                            ),
                                                            File(
                                                                filePath.path!),
                                                            fit:
                                                                BoxFit.fitWidth,
                                                          ),
                                                        ),
                                                      ),
                                                      Positioned(
                                                        top: -5,
                                                        right: -5,
                                                        child: Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(24.0),
                                                          child: IconButton(
                                                            onPressed: () {
                                                              Navigator.pop(
                                                                  context);
                                                            },
                                                            icon: const Icon(
                                                              Icons.close,
                                                              color: Colors.red,
                                                              size: 30,
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                );
                                              },
                                              child: ConstrainedBox(
                                                constraints:
                                                    const BoxConstraints(
                                                        maxHeight: 400),
                                                child: Image.file(
                                                  errorBuilder: (context, error,
                                                          stackTrace) =>
                                                      const Center(
                                                    child: Padding(
                                                      padding:
                                                          EdgeInsets.all(8.0),
                                                      child:
                                                          Text("Media error"),
                                                    ),
                                                  ),
                                                  File(filePath.path!),
                                                  fit: BoxFit.cover,
                                                ),
                                              )
                                                  .animate(
                                                      delay: (index * 50).ms)
                                                  .fade(duration: 250.ms),
                                            ),
                                          ),
                                        );
                                      }).toList(),
                                    ),
                                  ),
                                )
                              : const SizedBox(
                                  height: 100,
                                ),
                          Center(
                            child: SizedBox(
                              width: smallWidth,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    transaction.narr.isNotEmpty
                                        ? '"${transaction.narr}"'
                                        : "",
                                    style:
                                        Theme.of(context).textTheme.titleMedium,
                                  ),
                                  const SizedBox(
                                    height: 6,
                                  ),
                                  Text(
                                    transaction.vchType == VoucherType.payment
                                        ? viewmodel.doubleEntry.drAccount.name
                                        : viewmodel.doubleEntry.crAccount.name,
                                    overflow: TextOverflow.ellipsis,
                                    style:
                                        Theme.of(context).textTheme.titleLarge,
                                  ),
                                  const SizedBox(
                                    height: 12,
                                  ),
                                  Text(
                                    transaction.amount.toCurrencyStringWSymbol(
                                        viewmodel.profile.currency),
                                    style:
                                        Theme.of(context).textTheme.titleLarge,
                                  ),
                                  Text(
                                    transaction.vchType != VoucherType.payment
                                        ? AppLocalizations.of(context)!
                                            .receivedIn(viewmodel
                                                .doubleEntry.drAccount.name)
                                        : fundingAccountIDs.contains(viewmodel
                                                    .doubleEntry
                                                    .crAccount
                                                    .accType) &&
                                                fundingAccountIDs.contains(viewmodel
                                                    .doubleEntry
                                                    .drAccount
                                                    .accType)
                                            ? AppLocalizations.of(context)!
                                                .transferFrom(viewmodel
                                                    .doubleEntry.crAccount.name)
                                            : AppLocalizations.of(context)!.paidFrom(
                                                viewmodel.doubleEntry.crAccount.name),
                                    overflow: TextOverflow.ellipsis,
                                    style:
                                        Theme.of(context).textTheme.titleMedium,
                                  ),
                                  Visibility(
                                    visible: transaction.refNo.isNotEmpty,
                                    child: Text(
                                      "${AppLocalizations.of(context)!.referenceNo}${transaction.refNo}",
                                      overflow: TextOverflow.ellipsis,
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleSmall,
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 16,
                                  ),
                                  SizedBox(
                                    width: smallWidth,
                                    child: Align(
                                      alignment: Alignment.centerRight,
                                      child: Padding(
                                        padding: const EdgeInsets.all(2.0),
                                        child: Text(
                                          "${appViewmodel.dateFormat.format(
                                            transaction.vchDate,
                                          )}, ${timeFormat.format(transaction.vchDate)}",
                                          style: Theme.of(context)
                                              .textTheme
                                              .titleSmall,
                                        ),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 20,
                                  ),
                                ],
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ));
        },
      ),
    );
  }
}
