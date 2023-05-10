import 'package:ezak/model/settings.dart';
import 'package:ezak/pages/schedule_page.dart';
import 'package:ezak/providers/settings_provider.dart';
import 'package:ezak/utils/l10n/l10n.g.dart';
import 'package:ezak/visuals/appereance.dart';
import 'package:ezak/widgets/app_bar.dart';
import 'package:ezak/widgets/groups_tile.dart';
import 'package:ezak/widgets/popup_items/about_popup_item.dart';
import 'package:ezak/widgets/specialization_tile.dart';
import 'package:ezak/widgets/language_tile.dart';
import 'package:ezak/widgets/teacher_tile.dart';
import 'package:feature_discovery/feature_discovery.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SettingsPage extends StatelessWidget{
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {

    return FeatureDiscovery(
      recordStepsInSharedPreferences: false,
      child: Scaffold(
        appBar: PansAppBar(
          context,
          pansLeading: Tooltip(
            message: MaterialLocalizations.of(context).backButtonTooltip,
            child: Consumer(
              builder:(context, ref, child){
                final firstLaunch = ref.watch(
                  SettingsProvider.instance.select((settings) => settings.specializationKey)
                ) == Settings.defaultSpecializationKey;

                if(firstLaunch){
                  WidgetsBinding.instance.addPostFrameCallback((_) =>
                    FeatureDiscovery.discoverFeatures(
                      context,
                      {
                        "language",
                        "teacher_mode",
                        "specialization",
                        "go_to_schedule"
                      }
                    )
                  );
                }

                final iconButton = IconButton(
                  onPressed: firstLaunch? null : (){
                    if(Navigator.canPop(context)) {
                      Navigator.of(context).pop();
                    }else{
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (_) => const SchedulePage())
                      );
                    }
                  },
                  icon: Icon(Icons.adaptive.arrow_back)
                );

                return DescribedFeatureOverlay(
                  featureId: "go_to_schedule",
                  title: Text(L10n.of(context).go_to_schedule),
                  backgroundColor: Colors.green,
                  tapTarget: iconButton,
                  child: iconButton,
                );
              },
            ),
          ),
          popupItems: [
            PansAboutAppPopupItem(context)
          ],
        ),
        body: Column(
          children: const [
            PansLanguageTile(),
            PansTeacherTile(),
            PansSpecializationTile(),
            PansGroupsTile()
          ],
        ),
      ),
    );
  }

}