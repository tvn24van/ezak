import 'package:ezak/l10n/l10n.g.dart';
import 'package:ezak/pages/schedule_page.dart';
import 'package:ezak/pages/settings_page.dart';
import 'package:ezak/providers/settings_provider.dart';
import 'package:ezak/utils/constants.dart';
import 'package:ezak/widgets/tiles/drawer/about_tile.dart';
import 'package:ezak/widgets/tiles/drawer/contact_tile.dart';
import 'package:ezak/widgets/tiles/drawer/email_tutor_tile.dart';
import 'package:ezak/widgets/tiles/drawer/links_tile.dart';
import 'package:ezak/widgets/tiles/drawer/rate_app_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PansNavigationDrawer extends ConsumerWidget{
  final int page;
  const PansNavigationDrawer({super.key, required this.page});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final settingsCompleted = ref.watch(SettingsProvider.completed);
    return NavigationDrawer(
      selectedIndex: page,
      children: [
        NavigationDrawerDestination(
          icon: Icon(Icons.table_rows_outlined),
          label: Text(L10n.of(context).schedule),
          enabled: settingsCompleted,
        ),
        NavigationDrawerDestination(
          icon: Icon(Icons.settings),
          label: Text(L10n.of(context).settings),
        ),

        Divider(),
        PansEmailTutorTile(),
        PansLinksTile(),
        PansContactTile(),
        PansRateTile(),
        PansAboutTile(),
        Divider(),
        Text("${Constants.appName} 2023 - ${DateTime.now().year}", textAlign: TextAlign.center,)

      ],
      onDestinationSelected: (value) {
        if(value==page)return;
        final navigator = Navigator.of(context);
        switch(value){
          case 0:
            navigator.pop();
            if(navigator.canPop()) {
              navigator.pop();
            }else{
              navigator.pushReplacement(
                MaterialPageRoute(builder: (_) => const SchedulePage())
              );
            }
            break;
          case 1:
            navigator..pop()..push(MaterialPageRoute(
              builder: (_) => const SettingsPage(),
              settings: const RouteSettings(name: "/settings")
            ));
        }
      },
    );
  }

}