import 'package:ezak/providers/settings_provider.dart';
import 'package:ezak/utils/l10n/l10n.g.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PansAutoUpdateTile extends ConsumerWidget{
  const PansAutoUpdateTile({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final autoUpdates = ref.watch(SettingsProvider.instance.select((settings) => settings.autoUpdates));

    return ListTile(
      leading: const Icon(Icons.auto_mode_outlined),
      title: Text(L10n.of(context).auto_updates),
      subtitle: Text(L10n.of(context).auto_updates_subtitle),
      trailing: Switch.adaptive(
        value: autoUpdates,
        onChanged:(value) {
          ref.read(SettingsProvider.instance.notifier).toggleAutoUpdates();
        },
      ),
      onTap: (){},
    );
  }

}