import 'package:ezak/l10n/l10n.g.dart';
import 'package:ezak/utils/constants.dart';
import 'package:ezak/utils/query_param_encoder.dart';
import 'package:flutter/material.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:url_launcher/url_launcher.dart';

class PansContactTile extends StatelessWidget{
  const PansContactTile({super.key});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(L10n.of(context).contact),
      leading: Icon(Icons.support_agent),
      onTap: () async{
        showAdaptiveDialog(
          context: context,
          builder: (context) => AlertDialog.adaptive(
            title: Text(L10n.of(context).thank_you_for_your_contact),
            content: Text(L10n.of(context).email_feedback_message),
            actions: [
              TextButton(onPressed: () => Navigator.of(context).pop(), child: Text(MaterialLocalizations.of(context).okButtonLabel))
            ],
          ),
        );
        final version = (await PackageInfo.fromPlatform()).version;
        if(context.mounted) {
          await launchUrl(
            Constants.supportMail.replace(query: encodeQueryParameters({
              'subject': L10n.of(context).email_title(version),
              'body': L10n.of(context).email_body
            }))
          );
        }
      },
    );
  }

}