import 'package:ezak/pages/settings_page.dart';
import 'package:ezak/utils/l10n/l10n.g.dart';
import 'package:flutter/material.dart';

final class PansSettingsPopupItem extends PopupMenuItem{
  final BuildContext context;

  PansSettingsPopupItem(this.context, {super.key}):super(
    onTap: () => Future(() =>
      Navigator.of(context).push(
        MaterialPageRoute(builder: (_) => const SettingsPage(), settings: const RouteSettings(name: "/settings")),
      ),
    ),
    padding: EdgeInsets.zero,
    child: ListTile(
      leading: const Icon(Icons.settings),
      title: Text(L10n.of(context).settings),
      mouseCursor: SystemMouseCursors.click,
    ),

  );

}