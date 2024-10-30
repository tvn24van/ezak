import 'package:ezak/pages/schedule_page.dart';
import 'package:ezak/pages/settings_page.dart';
import 'package:ezak/providers/settings_provider.dart';
import 'package:ezak/utils/constants.dart';
import 'package:ezak/l10n/l10n.g.dart';
import 'package:ezak/visuals/appereance.dart';
import 'package:ezak/visuals/scroll_behavior.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final class PansApp extends ConsumerWidget {
  const PansApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final darkTheme = ref.watch(
      SettingsProvider.instance.select((settings) => settings.darkTheme)
    );
    final locale = ref.watch(
      SettingsProvider.instance.select((settings) => settings.locale)
    );

    final settingsCompleted = ref.watch(SettingsProvider.completed);

    return Listener(
      onPointerDown: (e)=> FocusManager.instance.primaryFocus?.unfocus(),
      child: MaterialApp(
        debugShowMaterialGrid: false,
        debugShowCheckedModeBanner: false,
        checkerboardOffscreenLayers: kDebugMode,
        checkerboardRasterCacheImages: kDebugMode,

        title: Constants.appName,

        localizationsDelegates: L10n.localizationsDelegates,
        supportedLocales: L10n.supportedLocales,
        locale: locale,

        scrollBehavior: PansScrollBehavior(),

        theme: PansAppereance.lightTheme,
        darkTheme: PansAppereance.darkTheme,
        themeMode: darkTheme? ThemeMode.dark : ThemeMode.light,

        routes: {
          "/settings": (context)=> const SettingsPage(), // todo idk if it is the best way for routing
        },

        home: kIsWeb && settingsCompleted? Banner(
          message: "TEST",
          location: BannerLocation.bottomStart,
          child: settingsCompleted? const SchedulePage() : const SettingsPage(),
        ): settingsCompleted? const SchedulePage() : const SettingsPage(),
      ),
    );
  }
}