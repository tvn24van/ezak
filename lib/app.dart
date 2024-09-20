import 'package:ezak/model/settings.dart';
import 'package:ezak/pages/schedule_page.dart';
import 'package:ezak/pages/settings_page.dart';
import 'package:ezak/providers/settings_provider.dart';
import 'package:ezak/utils/constants.dart';
import 'package:ezak/utils/l10n/l10n.g.dart';
import 'package:ezak/visuals/appereance.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final class PansApp extends ConsumerWidget {
  const PansApp({super.key});

  static const bool debug = bool.fromEnvironment('debug', defaultValue: false);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final darkTheme = ref.watch(
      SettingsProvider.instance.select((settings) => settings.darkTheme)
    );
    final locale = ref.watch(
      SettingsProvider.instance.select((settings) => settings.locale)
    );
    final firstLaunch = ref.read(
      SettingsProvider.instance.select((settings) => settings.specializationKey)
    ) == Settings.defaultSpecializationKey;

    return MaterialApp(
      debugShowCheckedModeBanner: debug,
      checkerboardOffscreenLayers: debug,
      checkerboardRasterCacheImages: debug,
      debugShowMaterialGrid: debug,

      title: Constants.appName,

      localizationsDelegates: L10n.localizationsDelegates,
      supportedLocales: L10n.supportedLocales,
      locale: locale,

      theme: PansAppereance.lightTheme,
      darkTheme: PansAppereance.darkTheme,
      themeMode: darkTheme? ThemeMode.dark : ThemeMode.light,

      routes: {
        "/settings": (context)=> const SettingsPage(), // idk if it is needed
      },

      home: !firstLaunch? const SchedulePage() : const SettingsPage(),
    );
  }
}