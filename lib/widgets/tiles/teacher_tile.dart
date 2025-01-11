import 'package:ezak/providers/settings_provider.dart';
import 'package:ezak/l10n/l10n.g.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final class PansTeacherTile extends ConsumerWidget{
  const PansTeacherTile({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isTeacher = ref.watch(SettingsProvider.instance.select(
      (settings) => settings.isLecturer
    ));

    return ListTile(
      title: Text(L10n.of(context).user_profile),
      leading: const Icon(Icons.school),
      trailing: SegmentedButton<bool>(
        segments: [
          ButtonSegment(
            value: false,
            label: Text(L10n.of(context).student)
          ),
          ButtonSegment(
            value: true,
            label: Text(L10n.of(context).lecturer)
          )
        ],
        selected: {isTeacher},
        onSelectionChanged: (_) => ref.read(SettingsProvider.instance.notifier).toggleTeacherMode(),
        showSelectedIcon: false,
      ),
      onTap: (){},
    );

  }

}