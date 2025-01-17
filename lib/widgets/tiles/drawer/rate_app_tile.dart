import 'package:ezak/l10n/l10n.g.dart';
import 'package:ezak/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class PansRateTile extends StatelessWidget{
  const PansRateTile({super.key});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(Icons.rate_review),
      title: Text(L10n.of(context).rate_app),
      onTap: () async=> launchUrl(Constants.googlePlayUrl, mode: LaunchMode.externalNonBrowserApplication),
    );
  }
  
}