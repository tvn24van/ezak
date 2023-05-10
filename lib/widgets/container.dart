import 'package:flutter/material.dart';

class PansCard extends Card{
  final List<Widget> children;

  PansCard({super.key, required this.children}):super(
    child: Container(
      padding: const EdgeInsets.all(15),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: children,
      ),
    )
  );

}