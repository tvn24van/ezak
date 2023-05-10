import 'package:flutter/material.dart';

class PansPopupButton extends StatelessWidget{
  final List<PopupMenuItem> items;

  const PansPopupButton({super.key, this.items=const []});

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton(
      icon: Icon(Icons.adaptive.more),
      tooltip: MaterialLocalizations.of(context).moreButtonTooltip,
      itemBuilder: (context)=> items,
    );
  }

}