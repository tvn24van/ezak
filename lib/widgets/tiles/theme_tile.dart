import 'package:ezak/providers/settings_provider.dart';
import 'package:ezak/utils/l10n/l10n.g.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final class PansThemeTile extends ConsumerWidget{
  const PansThemeTile({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {

    final isDark = ref.watch(SettingsProvider.instance.select((settings) => settings.darkTheme));

    return ListTile(
      leading: const Icon(Icons.dark_mode),
      title: Text(L10n.of(context).dark_theme),
      trailing: Switch.adaptive(
        value: isDark,
        onChanged:(value) =>
          ref.read(SettingsProvider.instance.notifier).toggleTheme(),
      ),
      onTap: (){},
    );
  }

}