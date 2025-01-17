import 'package:android_intent_plus/android_intent.dart';
import 'package:android_intent_plus/flag.dart';
import 'package:ezak/l10n/l10n.g.dart';
import 'package:ezak/utils/extensions.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher_string.dart';

class PansEmailTutorTile extends StatelessWidget{
  const PansEmailTutorTile({super.key});

  @override
  Widget build(BuildContext context) {
    return !defaultTargetPlatform.isMobile()? SizedBox.shrink() : ListTile(
      leading: Icon(Icons.email_outlined),
      title: Text(L10n.of(context).access_to_universitys_email),
      onTap: (){
        showDialog(context: context, builder: (context) {
          return AlertDialog.adaptive(
            title: Text(L10n.of(context).access_to_universitys_email),
            content: Text(L10n.of(context).email_access_explanation),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                  _launchMailApp();
                },
                child: Text(L10n.of(context).open_default_email_app)
              ),
              TextButton(
                onPressed: () => Navigator.of(context).pop(),
                child: Text(MaterialLocalizations.of(context).cancelButtonLabel)
              )
            ],
          );
        });

      },
    );
  }

  static void _launchMailApp(){
    if (defaultTargetPlatform == TargetPlatform.android && !kIsWeb) {
      final intent = AndroidIntent(
        action: 'android.intent.action.MAIN',
        category: 'android.intent.category.APP_EMAIL',
        flags: [Flag.FLAG_ACTIVITY_NEW_TASK]
      );
      intent.launch();
    } else if (defaultTargetPlatform == TargetPlatform.iOS) {
      launchUrlString("message://");
    }
  }

}