import 'package:ezak/utils/extensions.dart';
import 'package:ezak/utils/l10n/l10n.g.dart';
import 'package:ezak/visuals/appereance.dart';
import 'package:flutter/material.dart';

class PansBreakIndicator extends StatelessWidget{
  final Duration breakTime;

  const PansBreakIndicator(this.breakTime, {super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Tooltip(
        message: L10n.of(context).longer_break,
        preferBelow: false,
        child: Column(
          children: [
            Icon(Icons.more_horiz, size: 50, color: PansAppereance.colors.gray,),
            Text(breakTime.toPansString())
          ],
        ),
      ),
    );
  }

}