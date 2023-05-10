import 'package:ezak/pages/schedule_page.dart';
import 'package:ezak/providers/schedule_provider.dart';
import 'package:ezak/utils/l10n/l10n.g.dart';
import 'package:ezak/visuals/appereance.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PansFloatingActionButtons extends ConsumerWidget{
  const PansFloatingActionButtons({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final disabled = !ref.watch(ScheduleProvider.instance).hasValue;

    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          FloatingActionButton(
            onPressed: disabled? null : (){
              final controller = ref.read(SchedulePage.pageViewController);
              controller.previousPage(
                duration: PansAppereance.pageControllerSettings.duration,
                curve: PansAppereance.pageControllerSettings.curve,
              );
            },
            heroTag: null,
            tooltip: L10n.of(context).previous_day,
            child: Icon(Icons.adaptive.arrow_back),
          ),
          FloatingActionButton(
            onPressed: disabled? null : (){
              final controller = ref.read(SchedulePage.pageViewController);
              controller.nextPage(
                duration: PansAppereance.pageControllerSettings.duration,
                curve: PansAppereance.pageControllerSettings.curve,
              );
            },
            heroTag: null,
            tooltip: L10n.of(context).next_day,
            child: Icon(Icons.adaptive.arrow_forward),
          ),
        ],
      ),
    );
  }
}