import 'package:flutter/material.dart';

class TextDivider extends StatelessWidget{
  const TextDivider({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Row(children: <Widget>[
      Expanded(
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 20),
          child: const Divider()
        ),
      ),
      child,
      Expanded(
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 20),
          child: const Divider()
        ),
      ),
    ]);
  }

}