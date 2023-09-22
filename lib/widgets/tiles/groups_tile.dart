import 'package:ezak/model/group.dart';
import 'package:ezak/model/settings.dart';
import 'package:ezak/providers/schedule_provider.dart';
import 'package:ezak/providers/settings_provider.dart';
import 'package:ezak/utils/l10n/l10n.g.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PansGroupsTile extends ConsumerWidget{
  const PansGroupsTile({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final groups = ref.watch(SettingsProvider.instance.select((settings) => settings.groups));
    // final schedule = ref.watch(ScheduleProvider.instance);
    final teacherMode = ref.watch(SettingsProvider.instance.select((settings) => settings.isTeacher));
    final isSpecializationSelected = ref.watch(
      SettingsProvider.instance.select((settings) => settings.specializationKey)
    ) != Settings.defaultSpecializationKey;

    if(teacherMode || !isSpecializationSelected){
      return const SizedBox.shrink();
    }

    return ref.watch(ScheduleProvider.instance).when(
      data:(data){
        // final maxGroup = data.getMaxGroupNumber();

        return Column(
          mainAxisSize: MainAxisSize.min,
          children: Group.values.map((group) {
            final maxGroups = data.getMaxGroupNumber(group);
            if(maxGroups==0){
              return const SizedBox.shrink();
            }
            return ListTile(
              title: Text("${L10n
                  .of(context)
                  .group} ${group.symbol} (${L10n.of(context).group_name(
                  group.name)})"),
              trailing: SizedBox(
                width: MediaQuery
                    .of(context)
                    .size
                    .width * .6,
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  // child: ToggleButtons(
                  //   isSelected: List.generate(maxGroup, (index)=>
                  //     groups[group]!.contains(index+1)
                  //   ),
                  //   children: List.generate(maxGroup, (index)=> Text("${index+1}")),
                  //   onPressed: (index)=>{
                  //     ref.read(SettingsProvider.instance.notifier).toggleGroupNumber(
                  //       group,
                  //       index+1
                  //     )
                  //   },
                  // ),
                  child: SegmentedButton<int>(
                    emptySelectionAllowed: true,
                    showSelectedIcon: false,
                    multiSelectionEnabled: true,
                    selected: groups[group]!,
                    segments: List.generate(maxGroups, (
                        index) =>
                        ButtonSegment(
                            value: index + 1,
                            // enabled: !groups[group]!.contains(index+1),
                            label: Text("${index + 1}")
                        )
                    ),
                    onSelectionChanged: (selection) {
                      ref.read(SettingsProvider.instance.notifier)
                          .setGroupNumbers(group, selection);
                    },
                  ),
                ),
              ),
              onTap: () {},
            );
          }).toList()
        );
      },
      loading: ()=> const CircularProgressIndicator.adaptive(),
      error: (err, stack)=> Text('$err'),
    );

  }

}