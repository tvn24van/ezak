import 'package:flutter/material.dart';
import 'package:time/time.dart';

/// {@template pans_colors}
/// All these colors were grabbed from this
/// <a href="https://arc.pans.nysa.pl/sitecontent/logo/ksiega_znaku_PANS.pdf">PDF</a>
/// {@endtemplate}
class _PansColors{
  const _PansColors();

  get red => const Color.fromARGB(255, 226, 0, 26);
  get black => const Color.fromARGB(255, 0, 0, 0);
  get gray => const Color.fromARGB(255, 142, 142, 139);
}

/// {@template pans_page_controller_settings}
/// Default controller settings used by app
/// {@endtemplate}
class _PansPageControllerSettings{
  const _PansPageControllerSettings();

  get duration => 500.milliseconds;
  get curve => Curves.easeInOut;
}

class PansAppereance {

  /// {@macro pans_colors}
  static const colors = _PansColors();

  /// {@macro pans_page_controller_settings}
  static const pageControllerSettings = _PansPageControllerSettings();

  static final ThemeData lightTheme = ThemeData.light().copyWith(
    useMaterial3: true,
    colorScheme: ColorScheme.light(
      primary: colors.red,
      secondary: colors.gray,
      onBackground: colors.gray
    ),
  );

  static final ThemeData darkTheme = ThemeData.dark().copyWith(
    useMaterial3: true,
    colorScheme: ColorScheme.dark(
      primary: colors.red,
      secondary: colors.gray,
      onBackground: colors.gray
    ),
  );

}