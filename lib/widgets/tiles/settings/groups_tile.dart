import 'package:ezak/providers/max_groups_provider.dart';
import 'package:ezak/providers/settings_provider.dart';
import 'package:ezak/l10n/l10n.g.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final class PansGroupsTile extends ConsumerWidget{
  const PansGroupsTile({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final groups = ref.watch(SettingsProvider.groups);
    final isLecturer = ref.watch(SettingsProvider.isLecturer);

    final settingsCompleted = ref.watch(SettingsProvider.completed);

    if(isLecturer || !settingsCompleted){
      return const SizedBox.shrink();
    }

    return ref.watch(maxGroupsProvider).when(
      skipLoadingOnReload: true,
      data:(data){

        return Column(
          mainAxisSize: MainAxisSize.min,
          children: data.entries.map((e) {
            final group = e.key;
            final max = e.value;
            return ListTile(
              title: Text(L10n.of(context).group_name(group.name)),
              subtitle: Text("${L10n.of(context).group} ${group.symbol}"),
              trailing: ConstrainedBox(
                constraints: BoxConstraints(maxWidth: MediaQuery.of(context).size.width * .6),
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: SegmentedButton<int>(
                    emptySelectionAllowed: true,
                    showSelectedIcon: false,
                    multiSelectionEnabled: true,
                    selected: groups[group]!,
                    segments: List.generate(max, (index) =>
                      ButtonSegment(
                        value: index + 1,
                        label: Text("${index + 1}")
                      )
                    ),
                    onSelectionChanged: (selection) {
                      ref.read(SettingsProvider.instance.notifier)
                          .setGroupNumbers(group, selection);
                      HapticFeedback.selectionClick();
                    },
                  ),
                ),
              ),
              onTap: () {},
            );
          },).toList()
        );
      },
      loading: ()=> const CircularProgressIndicator(),
      error: (err, stack)=> Text('$err'),
    );

  }

}