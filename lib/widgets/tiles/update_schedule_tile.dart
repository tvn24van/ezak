import 'package:ezak/model/settings.dart';
import 'package:ezak/pages/schedule_page.dart';
import 'package:ezak/providers/settings_provider.dart';
import 'package:ezak/l10n/l10n.g.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final class PansUpdateScheduleTile extends ConsumerWidget{
  const PansUpdateScheduleTile({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isSpecializationSelected = ref.watch(
        SettingsProvider.instance.select((settings) => settings.specializationKey)
    )!=Settings.defaultSpecializationKey;
    return ListTile(
      leading: const Icon(Icons.update),
      title: Text(L10n.of(context).schedule_updating),
      trailing: FilledButton(
        onPressed: isSpecializationSelected?
          ()async=> SchedulePage.showUpdateDialog(context, ref):
          null,
        child: const Icon(Icons.update)
      ),
      onTap: () => {},
    );
  }

}