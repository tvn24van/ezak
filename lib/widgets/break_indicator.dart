import 'package:ezak/l10n/l10n.g.dart';
import 'package:ezak/utils/extensions.dart';
import 'package:flutter/material.dart';

final class PansBreakIndicator extends StatelessWidget{
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
            Icon(Icons.share_arrival_time_outlined,  color: Theme.of(context).colorScheme.onSurface),
            Text(breakTime.formatTime(context))
          ],
        ),
      ),
    );
  }

}