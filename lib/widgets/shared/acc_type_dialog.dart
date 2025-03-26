import 'package:flutter/material.dart';
import 'package:pursenal/core/db/database.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:pursenal/screens/account_entry_screen.dart';
import 'package:pursenal/widgets/shared/acc_type_icon.dart';

class AccTypeDialog extends StatelessWidget {
  const AccTypeDialog({
    super.key,
    required this.profile,
    required this.initFn,
    required this.accTypes,
  });

  final Profile profile;
  final Function initFn;
  final List<AccType> accTypes;

  @override
  Widget build(BuildContext context) {
    return SimpleDialog(
      title: Text(AppLocalizations.of(context)!
          .select(AppLocalizations.of(context)!.accountType)),
      children: [
        ...accTypes.map(
          (a) => ListTile(
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
            title: Text(a.name,
                overflow: TextOverflow.ellipsis,
                style: Theme.of(context)
                    .textTheme
                    .headlineMedium
                    ?.copyWith(fontSize: 24)),
            minTileHeight: 50,
            minLeadingWidth: 28,
            leading: Icon(getAccTypeIcon(a.id)),
            onTap: () {
              Navigator.pop(context);
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => AccountEntryScreen(
                    profile: profile,
                    accType: a,
                  ),
                ),
              ).then((_) {
                initFn();
              });
            },
          ),
        ),
        const SizedBox(
          height: 12,
        ),
      ],
    );
  }
}
