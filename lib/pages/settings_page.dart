import 'package:ezak/pages/schedule_page.dart';
import 'package:ezak/providers/settings_provider.dart';
import 'package:ezak/l10n/l10n.g.dart';
import 'package:ezak/widgets/app_bar.dart';
import 'package:ezak/widgets/drawer.dart';
import 'package:ezak/widgets/text_divider.dart';
import 'package:ezak/widgets/tiles/settings/auto_update_tile.dart';
import 'package:ezak/widgets/tiles/settings/clear_data_tile.dart';
import 'package:ezak/widgets/tiles/settings/theme_tile.dart';
import 'package:ezak/widgets/tiles/settings/update_schedule_tile.dart';
import 'package:ezak/widgets/tiles/settings/groups_tile.dart';
import 'package:ezak/widgets/tiles/settings/keys_tile.dart';
import 'package:ezak/widgets/tiles/settings/language_tile.dart';
import 'package:ezak/widgets/tiles/settings/teacher_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final class SettingsPage extends StatelessWidget{
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: PansAppBar(
        pansLeading: Tooltip(
          message: MaterialLocalizations.of(context).backButtonTooltip,
          child: Consumer(
            builder:(context, ref, child){
              final settingsCompleted = ref.watch(SettingsProvider.completed);

              return IconButton(
                onPressed: !settingsCompleted? null : (){
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
            },
          ),
        ),
        leadingText: L10n.of(context).settings,
        context: context,
      ),
      endDrawer: PansNavigationDrawer(page: 1),
      body: Consumer(
        builder: (context, ref, child) {

          return PopScope(
            canPop: ref.watch(SettingsProvider.completed),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  TextDivider(child: Text(L10n.of(context).section_of_personalization)),
                  const PansLanguageTile(),
                  const PansThemeTile(),
                  TextDivider(child: Text(L10n.of(context).section_of_schedule_configuration)),
                  const PansAutoUpdateTile(),
                  const PansTeacherTile(),
                  const PansKeysTile(),
                  const PansGroupsTile(),
                  TextDivider(child: Text(L10n.of(context).section_of_schedule_management)),
                  const PansUpdateScheduleTile(),
                  const PansClearDataTile()
                ],
              ),
            ),
          );
        },
      ),
    );
  }

}