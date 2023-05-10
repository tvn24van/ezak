import 'package:ezak/providers/settings_provider.dart';
import 'package:ezak/utils/l10n/l10n.g.dart';
import 'package:ezak/visuals/appereance.dart';
import 'package:feature_discovery/feature_discovery.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PansTeacherTile extends ConsumerWidget{
  const PansTeacherTile({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isTeacher = ref.watch(SettingsProvider.instance.select(
      (settings) => settings.isTeacher
    ));

    final button = Switch.adaptive(
      value: isTeacher,
      onChanged: (value){
        ref.read(SettingsProvider.instance.notifier)
          .toggleTeacherMode();
      }
    );

    return ListTile(
      title: Text(L10n.of(context).academic_teacher_mode),
      leading: const Icon(Icons.person),
      trailing: DescribedFeatureOverlay(
        featureId: "teacher_mode",
        title: Text(L10n.of(context).set_whether_you_are_a_teacher),
        backgroundColor: PansAppereance.colors.gray,
        tapTarget: AbsorbPointer(
          absorbing: true,
          child: button
        ),
        child: button,
      ),
      onTap: (){},
    );

  }

}