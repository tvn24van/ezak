import 'package:ezak/model/group.dart';
import 'package:ezak/l10n/l10n.g.dart';
import 'package:flutter/material.dart';

final class PansInfoButton extends StatelessWidget{
  const PansInfoButton({super.key});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: (){
        showAdaptiveDialog(context: context, builder: (context) {
          return AlertDialog.adaptive(
            title: Text(L10n.of(context).informations),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Wrap(
                  crossAxisAlignment: WrapCrossAlignment.center,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: Group.values.map((group) {
                        return Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Container(
                              padding: const EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                color: Color.lerp(Theme.of(context).dialogBackgroundColor, group.color, .6),
                                shape: BoxShape.circle
                              ),
                            ),
                            const SizedBox(width: 10, height: 30,),
                            Text(L10n.of(context).group_name(group.name))
                          ],
                        );
                      }).toList(),
                    ),
                    const VerticalDivider(),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const Icon(Icons.home),
                            const SizedBox(width: 10, height: 30,),
                            Text(L10n.of(context).full_time_course)
                          ],
                        ),
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const Icon(Icons.online_prediction),
                            const SizedBox(width: 10, height: 30,),
                            Text(L10n.of(context).online_course)
                          ],
                        )
                      ],
                    )
                  ],
                )
              ],
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