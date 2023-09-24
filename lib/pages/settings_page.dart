import 'package:ezak/model/settings.dart';
import 'package:ezak/pages/schedule_page.dart';
import 'package:ezak/providers/settings_provider.dart';
import 'package:ezak/utils/l10n/l10n.g.dart';
import 'package:ezak/widgets/app_bar.dart';
import 'package:ezak/widgets/tiles/auto_update_tile.dart';
import 'package:ezak/widgets/tiles/theme_tile.dart';
import 'package:ezak/widgets/tiles/update_schedule_tile.dart';
import 'package:ezak/widgets/tiles/groups_tile.dart';
import 'package:ezak/widgets/popup_items/about_popup_item.dart';
import 'package:ezak/widgets/tiles/specialization_tile.dart';
import 'package:ezak/widgets/tiles/language_tile.dart';
import 'package:ezak/widgets/tiles/teacher_tile.dart';
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
          pansLeading: Tooltip(
            message: MaterialLocalizations.of(context).backButtonTooltip,
            child: Consumer(
              builder:(context, ref, child){
                final firstLaunch = ref.watch(
                  SettingsProvider.instance.select((settings) => settings.specializationKey)
                ) == Settings.defaultSpecializationKey;

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
                  targetColor: Theme.of(context).canvasColor,
                  tapTarget: iconButton,
                  child: iconButton,
                );
              },
            ),
          ),
          leadingText: L10n.of(context).settings,
          popupItems: [
            PansAboutAppPopupItem(context)
          ],
          context: context,
        ),
        body: const SingleChildScrollView(
          child: Column(
            children: [
              PansLanguageTile(),
              PansThemeTile(),
              PansAutoUpdateTile(),
              PansTeacherTile(),
              PansSpecializationTile(),
              PansGroupsTile(),
              PansUpdateScheduleTile()
            ],
          ),
        ),
      ),
    );
  }

}