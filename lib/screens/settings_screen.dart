import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:pursenal/app/global/dimensions.dart';
import 'package:pursenal/app/extensions/color.dart';
import 'package:pursenal/core/enums/app_date_format.dart';
import 'package:pursenal/core/enums/app_font.dart';
import 'package:pursenal/providers/theme_provider.dart';
import 'package:pursenal/viewmodels/app_viewmodel.dart';
import 'package:pursenal/widgets/shared/color_picker_dialog.dart';
import 'package:pursenal/widgets/shared/the_divider.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    double colorCircleRadius = 34;
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pop(context);
            }),
        title: Text(AppLocalizations.of(context)!.settings),
      ),
      body: Consumer<AppViewmodel>(
        builder: (context, viewmodel, child) => Padding(
          padding: const EdgeInsets.all(8.0),
          child: Center(
            child: SizedBox(
              height: double.maxFinite,
              width: smallWidth,
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16.0, vertical: 20),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(AppLocalizations.of(context)!.theme),
                          const Expanded(child: TheDivider())
                        ],
                      ),
                      SwitchListTile(
                          activeColor: Theme.of(context)
                              .colorScheme
                              .primary, // Changes selected color
                          inactiveTrackColor: Theme.of(context)
                              .colorScheme
                              .secondary, // Optional
                          value: viewmodel.isSystemDefaultTheme,
                          title: Text(
                            AppLocalizations.of(context)!.useSystemTheme,
                            style: TextStyle(
                              color: Theme.of(context).listTileTheme.textColor,
                            ),
                          ),
                          onChanged: (v) {
                            viewmodel.isSystemDefaultTheme = v;
                            if (v) {
                              AdaptiveTheme.of(context).setSystem();
                            }
                          }),
                      const SizedBox(
                        height: 16,
                      ),
                      Row(
                        children: [
                          Text(AppLocalizations.of(context)!.personalisation),
                          const Expanded(child: TheDivider())
                        ],
                      ),
                      Consumer<ThemeProvider>(
                        builder: (context, themeProvider, child) => ListTile(
                          title:
                              Text(AppLocalizations.of(context)!.primaryColor),
                          onTap: () {
                            showDialog(
                              context: context,
                              builder: (context) => ColorPickerDialog(
                                selectedColor: themeProvider.primaryColor,
                                setColorFn: (c) {
                                  if (c != null) {
                                    themeProvider.primaryColor = c;
                                    AdaptiveTheme.of(context).setTheme(
                                        light: themeProvider.getLightTheme(),
                                        dark: themeProvider.getDarkTheme());
                                  }
                                },
                              ),
                            );
                          },
                          trailing: Container(
                            width: colorCircleRadius,
                            height: colorCircleRadius,
                            decoration: BoxDecoration(
                              color: themeProvider.primaryColor,
                              shape: BoxShape.circle,
                            ),
                          ),
                        ),
                      ),
                      ListTile(
                        title: Text(AppLocalizations.of(context)!.paymentColor),
                        trailing: Container(
                          width: colorCircleRadius,
                          height: colorCircleRadius,
                          decoration: BoxDecoration(
                            color: viewmodel.paymentColor,
                            shape: BoxShape.circle,
                          ),
                        ),
                        onTap: () {
                          showDialog(
                            context: context,
                            builder: (context) => ColorPickerDialog(
                              selectedColor: viewmodel.paymentColor
                                  .toHex()
                                  .hexToMaterialColor(),
                              setColorFn: (c) {
                                if (c != null) {
                                  viewmodel.paymentColor = c;
                                }
                              },
                            ),
                          );
                        },
                      ),
                      ListTile(
                        title: Text(AppLocalizations.of(context)!.receiptColor),
                        trailing: Container(
                          width: colorCircleRadius,
                          height: colorCircleRadius,
                          decoration: BoxDecoration(
                            color: viewmodel.receiptColor,
                            shape: BoxShape.circle,
                          ),
                        ),
                        onTap: () {
                          showDialog(
                            context: context,
                            builder: (context) => ColorPickerDialog(
                              selectedColor: viewmodel.receiptColor
                                  .toHex()
                                  .hexToMaterialColor(),
                              setColorFn: (c) {
                                if (c != null) {
                                  viewmodel.receiptColor = c[500]!;
                                }
                              },
                            ),
                          );
                        },
                      ),
                      const SizedBox(
                        height: 4,
                      ),
                      Consumer<ThemeProvider>(
                        builder: (context, themeProvider, child) => Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 8, horizontal: 4),
                          child: DropdownMenu<AppFont>(
                              width: smallWidth,
                              enableSearch: false,
                              label: const Text("Select font"),
                              initialSelection: AppFont.values.firstWhereOrNull(
                                      (a) =>
                                          a.name ==
                                          themeProvider.selectedFont) ??
                                  AppFont.values.first,
                              onSelected: (a) {
                                if (a != null) {
                                  themeProvider.setFont(a.label);
                                  AdaptiveTheme.of(context).setTheme(
                                      light: themeProvider.getLightTheme(),
                                      dark: themeProvider.getDarkTheme());
                                }
                              },
                              dropdownMenuEntries: [
                                ...AppFont.values.map((f) => DropdownMenuEntry(
                                    value: f,
                                    label: f.label,
                                    trailingIcon: Text(
                                      "Sample",
                                      style: TextStyle(fontFamily: f.name),
                                    )))
                              ]),
                        ),
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      Row(
                        children: [
                          Text(AppLocalizations.of(context)!.reminder),
                          const Expanded(child: TheDivider()),
                        ],
                      ),
                      SwitchListTile(
                          activeColor: Theme.of(context)
                              .colorScheme
                              .primary, // Changes selected color
                          inactiveTrackColor: Theme.of(context)
                              .colorScheme
                              .secondary, // Optional
                          value: viewmodel.reminderStatus,
                          title: Text(
                            AppLocalizations.of(context)!.setDailyReminder,
                            style: TextStyle(
                              color: Theme.of(context).listTileTheme.textColor,
                            ),
                          ),
                          subtitle: viewmodel.reminderStatus
                              ? Text(AppLocalizations.of(context)!
                                  .reminderSetTime(viewmodel.reminderTime))
                              : null,
                          onChanged: (v) async {
                            await viewmodel.toggleReminder(v);

                            if (context.mounted) {
                              if (v) {
                                showTimePicker(
                                  context: context,
                                  initialTime: TimeOfDay.now(),
                                ).then((t) {
                                  if (t != null) {
                                    viewmodel.setRemindTime(t);
                                  } else {
                                    viewmodel.toggleReminder(false);
                                  }
                                });
                              }
                            }
                          }),
                      const SizedBox(
                        height: 16,
                      ),
                      Row(
                        children: [
                          Text(AppLocalizations.of(context)!.dates),
                          const Expanded(child: TheDivider()),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 8, horizontal: 4),
                        child: DropdownMenu<AppDateFormat>(
                          width: smallWidth,
                          enableSearch: false,
                          label: const Text("Set Date Format"),
                          initialSelection: AppDateFormat.values
                              .firstWhereOrNull((a) =>
                                  a.pattern == viewmodel.dateFormat.pattern),
                          onSelected: (a) {
                            if (a != null) {
                              viewmodel.setAppDateFormat(a.pattern);
                            }
                          },
                          dropdownMenuEntries: [
                            ...AppDateFormat.values.map(
                              (f) {
                                DateFormat df = DateFormat(f.pattern);
                                DateTime now = DateTime.now();
                                return DropdownMenuEntry(
                                    value: f,
                                    label: f.pattern,
                                    trailingIcon: Text(
                                      df.format(now),
                                    ));
                              },
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
