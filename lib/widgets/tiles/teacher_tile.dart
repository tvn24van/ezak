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
      title: Text(L10n.of(context).academic_teacher_mode),
      leading: const Icon(Icons.person),
      trailing: Switch.adaptive(
        value: isTeacher,
        onChanged: (value){
          ref.read(SettingsProvider.instance.notifier)
              .toggleTeacherMode();
        }
      ),
      onTap: (){},
    );

  }

}