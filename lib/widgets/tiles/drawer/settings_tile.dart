import 'package:ezak/l10n/l10n.g.dart';
import 'package:flutter/material.dart';

class PansSettingsTile extends StatelessWidget{
  const PansSettingsTile({super.key});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(Icons.settings),
      title: Text(L10n.of(context).settings),
      onTap: () {
        Navigator.of(context)..pop()..pushNamed("/settings");
      },
    );
  }

}