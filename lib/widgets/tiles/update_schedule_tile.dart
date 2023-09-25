import 'package:ezak/model/settings.dart';
import 'package:ezak/providers/settings_provider.dart';
import 'package:ezak/utils/l10n/l10n.g.dart';
import 'package:ezak/widgets/mixins/schedule_widget.dart';
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
      title: Text(L10n.of(context).check_for_schedule_update),
      trailing: FilledButton(
        onPressed: isSpecializationSelected?
          ()async=> ScheduleWidget.showUpdateDialog(context, ref):
          null,
        child: const Icon(Icons.update)
      ),
      onTap: () => {},
    );
  }

}