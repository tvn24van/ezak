import 'package:ezak/model/group.dart';
import 'package:ezak/utils/l10n/l10n.g.dart';
import 'package:flutter/material.dart';

class PansInfoButton extends StatelessWidget{
  const PansInfoButton({super.key});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: (){
        showDialog(context: context, builder: (context) {
          return AlertDialog(
            title: Text(L10n.of(context).legend),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Column(
                  children: Group.values.map((group) {
                    return Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: group.color.withOpacity(.6),
                            shape: BoxShape.circle
                          ),
                        ),
                        const SizedBox(width: 10, height: 30,),
                        Text(L10n.of(context).group_name(group.name))
                      ],
                    );
                  }).toList(),
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