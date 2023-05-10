import 'package:ezak/pages/settings_page.dart';
import 'package:ezak/utils/l10n/l10n.g.dart';
import 'package:flutter/material.dart';

class PansSettingsPopupItem extends PopupMenuItem{
  final BuildContext context;

  PansSettingsPopupItem(this.context, {super.key}):super(
    onTap: () => Future(() =>
      Navigator.of(context).push(
        MaterialPageRoute(builder: (_) => const SettingsPage()),
      ),
    ),
    child: Text(L10n.of(context).settings),

  );

}