import 'package:ezak/l10n/l10n.g.dart';
import 'package:ezak/utils/constants.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class PansLinksTile extends StatelessWidget{
  const PansLinksTile({super.key});

  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      leading: Icon(Icons.web_sharp),
      title: Text(L10n.of(context).useful_links),
      iconColor: IconTheme.of(context).color,
      children: [
        ListTile(
          title: Text(L10n.of(context).university_website),
          onTap: () => launchUrl(Constants.pansWebsiteUrl),
        ),
        ListTile(
          title: Text("Elearning"),
          onTap: () => launchUrl(Constants.pansElearningUrl),
        ),
        if(!kIsWeb)
          ListTile(
            title: Text(L10n.of(context).web_app),
            onTap: () => launchUrl(Constants.webAppUrl),
          )
        else
          ListTile(
            title: Text(L10n.of(context).mobile_app),
            onTap: () => launchUrl(Constants.googlePlayUrl),
          )
      ],
    );
  }

}