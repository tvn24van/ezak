import 'package:flutter/material.dart';

/// {@template pans_colors}
/// All these colors were grabbed from this
/// <a href="https://arc.pans.nysa.pl/sitecontent/logo/ksiega_znaku_PANS.pdf">PDF</a>
/// {@endtemplate}
final class _PansColors{
  const _PansColors();

  get red => const Color.fromARGB(255, 226, 0, 26);
  get black => const Color.fromARGB(255, 0, 0, 0);
  get gray => const Color.fromARGB(255, 142, 142, 139);
}

final class PansAppereance {

  /// {@macro pans_colors}
  static const colors = _PansColors();

  static final ThemeData lightTheme = ThemeData(
    useMaterial3: true,
    colorScheme: ColorScheme.fromSeed(
      brightness: Brightness.light,
      seedColor: colors.red,
      primary: colors.red,
      secondary: colors.gray,
    )
  );

  static final ThemeData darkTheme = ThemeData(
    useMaterial3: true,
    colorScheme: ColorScheme.fromSeed(
      brightness: Brightness.dark,
      seedColor: colors.red,
      primary: colors.red,
      secondary: colors.gray,
    )
  );

  static final ThemeData lightHighContrastTheme = ThemeData.from(
    colorScheme: ColorScheme.highContrastLight(
      primary: Colors.black,
      onPrimary: Colors.yellow,
    ),
  );

  static final ThemeData darkHighContrastTheme = ThemeData.from(
    colorScheme: ColorScheme.highContrastDark(
      primary: Colors.yellow,
      onPrimary: Colors.black,
    ),
  );

}