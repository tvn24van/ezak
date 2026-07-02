import 'package:ezak/model/group.dart';
import 'package:ezak/l10n/l10n.g.dart';
import 'package:ezak/providers/settings_provider.dart';
import 'package:ezak/utils/extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final class PansInfoButton extends ConsumerWidget{
  const PansInfoButton({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    
    return IconButton(
      onPressed: (){
        final highContrast = ref.read(SettingsProvider.instance.select((s) => s.highContrast));
        showDialog(context: context, builder: (context) {
          return AlertDialog(
            title: Text(L10n.of(context).informations),
            content: SizedBox(
              width: 275, //hardcoded width to stop dialog from being too wide
              child: Wrap(
                runSpacing: 5,
                spacing: 5,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    spacing: 5,
                    children: Group.values.map((group) {
                      return Row(
                        mainAxisSize: MainAxisSize.min,
                        spacing: 5,
                        children: [
                          Container(
                            padding: const EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              color: highContrast?
                                group.color.ensureWcagAaContrast(context):
                                Color.lerp(Theme.of(context).scaffoldBackgroundColor, group.color, .5),
                              shape: BoxShape.circle
                            ),
                          ),
                          Text(L10n.of(context).group_name(group.name))
                        ],
                      );
                    }).toList(),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    spacing: 5,
                    children: [
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        spacing: 5,
                        children: [
                          const Icon(Icons.home_work),
                          Text(L10n.of(context).full_time_course)
                        ],
                      ),
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        spacing: 5,
                        children: [
                          const Icon(Icons.computer),
                          Text(L10n.of(context).online_course)
                        ],
                      ),
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        spacing: 5,
                        children: [
                          const Icon(Icons.share_arrival_time_outlined),
                          Text(L10n.of(context).longer_break)
                        ],
                      )
                    ],
                  )
                ],
              ),
            ),
            actions: [
              TextButton(
                onPressed: (){
                  Navigator.of(context).pop();
                },
                child: Text(MaterialLocalizations.of(context).closeButtonLabel)
              )
            ],
          );
        },);
      },
      tooltip: L10n.of(context).informations,
      icon: const Icon(Icons.info_outline)
    );
  }

}