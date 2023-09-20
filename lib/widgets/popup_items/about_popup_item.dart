import 'package:ezak/utils/constants.dart';
import 'package:ezak/utils/l10n/l10n.g.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:url_launcher/url_launcher.dart';

class PansAboutAppPopupItem extends PopupMenuItem{
  final BuildContext context;

  PansAboutAppPopupItem(this.context, {super.key}):super(
    onTap: ()async{
      final appInfo = await PackageInfo.fromPlatform();
      if(context.mounted) {
        showAboutDialog(
          context: context,
          applicationName: Constants.appName,
          applicationVersion: appInfo.version,
          applicationLegalese: L10n.of(context).caption,
          applicationIcon: SvgPicture.asset(
            'assets/logotypes/crest.svg',
            width: 160,
            height: 180,
          ),

          children: [
            const SizedBox(height: 10,),
            Wrap(
              alignment: WrapAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: () async{
                    await launchUrl(Constants.github, mode: LaunchMode.externalApplication);
                  },
                  child: const Text("Github")
                ),
                ElevatedButton(
                    onPressed: () async{
                      await launchUrl(Constants.supportMail);
                    },
                    child: Text(L10n.of(context).mail_us)
                ),
                ElevatedButton(
                  onPressed: () async{
                    await launchUrl(Constants.pansWebsite, mode: LaunchMode.externalApplication);
                  },
                  child: Text(L10n.of(context).university_website)
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