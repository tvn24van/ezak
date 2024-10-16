import 'package:flutter/material.dart';

final class PansPopupButton extends StatelessWidget{
  final List<PopupMenuItem> items;

  const PansPopupButton({super.key, this.items=const []});

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton( // todo use this for language selection and maybe find better alternative for this popup as it should get PopupMenuItem but instead it gets just widgets
      icon: Icon(Icons.adaptive.more),
      tooltip: MaterialLocalizations.of(context).moreButtonTooltip,
      itemBuilder: (context)=> items,
    );
  }

}