import 'package:ezak/l10n/l10n.g.dart';
import 'package:ezak/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:url_launcher/url_launcher.dart';

class PansAboutTile extends StatelessWidget{
  const PansAboutTile({super.key});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(Icons.app_shortcut),
      title: Text(L10n.of(context).about_app),
      onTap: () async{
        final appInfo = await PackageInfo.fromPlatform();
      if(context.mounted) {
        showAboutDialog(
          context: context,
          applicationName: Constants.appName,
          applicationVersion: appInfo.version,
          applicationLegalese: L10n.of(context).caption(Constants.appName),
          applicationIcon: SvgPicture.asset(
            'assets/logotypes/crest.svg',
            width: MediaQuery.sizeOf(context).width*.1,
          ),
          children: [
            const SizedBox(height: 10,),
            Wrap(
              alignment: WrapAlignment.center,
              runSpacing: 5,
              spacing: 5,
              children: [
                TextButton.icon(
                  icon: Icon(Icons.ondemand_video),
                  onPressed: () async{
                    await launchUrl(Constants.videoClip, mode: LaunchMode.externalApplication);
                  },
                  label: Text(L10n.of(context).video_clip)
                ),
                TextButton.icon(
                  icon: Icon(Icons.code),
                  onPressed: () async{
                    await launchUrl(Constants.githubUrl, mode: LaunchMode.externalApplication);
                  },
                  label: Text(L10n.of(context).source_code)
                ),
              ],
            )
          ]
        );
      }
      },
    );
  }

}