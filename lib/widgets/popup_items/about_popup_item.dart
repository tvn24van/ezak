import 'package:ezak/utils/constants.dart';
import 'package:ezak/l10n/l10n.g.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:url_launcher/url_launcher.dart';

final class PansAboutAppPopupItem extends PopupMenuItem{
  final BuildContext context;

  PansAboutAppPopupItem(this.context, {super.key}):super(
    onTap: ()async{
      final appInfo = await PackageInfo.fromPlatform();
      if(context.mounted) {
        showAboutDialog(
          context: context,
          applicationName: Constants.appName,
          applicationVersion: appInfo.version,
          applicationLegalese: L10n.of(context).caption(Constants.appName),
          applicationIcon: SvgPicture.asset(
            'assets/logotypes/crest.svg',
            width: 160,
            height: 180,
          ),
          children: [
            const SizedBox(height: 10,),
            Wrap(
              alignment: WrapAlignment.center,
              runSpacing: 5,
              spacing: 5,
              children: [
                ElevatedButton(
                  onPressed: () async{
                    await launchUrl(Constants.videoClip, mode: LaunchMode.externalApplication);
                  },
                  child: Text(L10n.of(context).video_clip)
                ),
                if(!kIsWeb)
                  ElevatedButton(
                    onPressed: () async{
                      await launchUrl(Constants.webAppUrl, mode: LaunchMode.externalApplication);
                    },
                    child: Text(L10n.of(context).web_app)
                  ),
                ElevatedButton(
                  onPressed: () async{
                    await launchUrl(Constants.pansWebsiteUrl, mode: LaunchMode.externalApplication);
                  },
                  child: Text(L10n.of(context).university_website)
                ),
                ElevatedButton(
                  onPressed: () async{
                    await launchUrl(Constants.githubUrl, mode: LaunchMode.externalApplication);
                  },
                  child: const Text("Github")
                ),
                ElevatedButton(
                  onPressed: () async{
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
                    await launchUrl(Constants.supportMail);
                  },
                  child: Text(L10n.of(context).contact)
                ),
              ],
            )
          ]
        );
      }
    },
    padding: EdgeInsets.zero,
    child: ListTile(
      leading: const Icon(Icons.info_outline),
      title: Text(L10n.of(context).about_app),
      mouseCursor: SystemMouseCursors.click,
    )
  );

}