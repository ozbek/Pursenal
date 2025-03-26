import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ExportButton extends StatelessWidget {
  const ExportButton({
    super.key,
    required this.pdfExportFn,
    required this.xlsxExportFn,
  });

  final Function pdfExportFn;
  final Function xlsxExportFn;

  @override
  Widget build(BuildContext context) {
    return IconButton(
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) => SimpleDialog(
              title: Text(AppLocalizations.of(context)!.export),
              children: [
                ListTile(
                  title: Text(
                    "PDF",
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  onTap: () {
                    pdfExportFn();
                    if (context.mounted) Navigator.pop(context);
                  },
                ),
                ListTile(
                  title: Text(
                    "Spreadsheet",
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  onTap: () {
                    xlsxExportFn();
                    if (context.mounted) Navigator.pop(context);
                  },
                ),
                const SizedBox(
                  height: 12,
                )
              ],
            ),
          );
        },
        icon: const Icon(Icons.file_download_outlined));
  }
}
