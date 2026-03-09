import 'package:ezak/pages/schedule_page.dart';
import 'package:ezak/pages/settings_page.dart' deferred as settings_page;
import 'package:ezak/providers/settings_provider.dart';
import 'package:ezak/utils/constants.dart';
import 'package:ezak/l10n/l10n.g.dart';
import 'package:ezak/utils/deferred_page_builder.dart';
import 'package:ezak/visuals/appearance.dart';
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

    final highContrast = ref.watch(
        SettingsProvider.instance.select((settings) => settings.highContrast)
    );

    final locale = ref.watch(
      SettingsProvider.instance.select((settings) => settings.locale)
    );

    final leftHandMode = ref.watch(
      SettingsProvider.instance.select((settings) => settings.leftHandMode)
    );

    final settingsCompleted = ref.read(SettingsProvider.completed);

    ref.listen(SettingsProvider.completed, (previous, completed) {
      if (completed) return;
      var isAlreadyOnSettings = false;

      Navigator.of(context).popUntil((route) {
        if (route.settings.name == '/settings') {
          isAlreadyOnSettings = true;
        }
        return true;
      });

      if (!isAlreadyOnSettings) {
        Navigator.pushReplacementNamed(context, '/settings');
      }
    });

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

        theme: highContrast? PansAppereance.lightHighContrastTheme : PansAppereance.lightTheme,
        darkTheme: highContrast? PansAppereance.darkHighContrastTheme : PansAppereance.darkTheme,
        highContrastTheme: PansAppereance.lightHighContrastTheme,
        highContrastDarkTheme: PansAppereance.darkHighContrastTheme,
        themeMode: darkTheme? ThemeMode.dark : ThemeMode.light,

        routes: {
          "/": (context)=> const SchedulePage(),
          "/settings": (context)=> DeferredPageBuilder(
            future: settings_page.loadLibrary,
            page: () => settings_page.SettingsPage(),
          ),
        },
        initialRoute: settingsCompleted? "/" : "/settings",
        builder: (context, child) => Directionality(
          textDirection: leftHandMode? TextDirection.rtl:TextDirection.ltr,
          child: child!
        ),
      ),
    );
  }
}