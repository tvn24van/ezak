import 'package:ezak/providers/settings_provider.dart';
import 'package:ezak/utils/l10n/l10n.g.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PansThemeButton extends ConsumerWidget{
  const PansThemeButton({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    
    final darkTheme = ref.watch(
      SettingsProvider.instance.select((settings) => settings.darkTheme)
    );
    
    return IconButton(
      icon: Icon(darkTheme? Icons.light_mode : Icons.dark_mode),
      tooltip: L10n.of(context).theme_change,
      onPressed: () {
        ref.read(SettingsProvider.instance.notifier).toggleTheme();
      },
    );
  }
  
}