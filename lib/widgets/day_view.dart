import 'dart:ui';

import 'package:ezak/model/course.dart';
import 'package:ezak/model/decoders/hours_decoder.dart';
import 'package:ezak/widgets/break_indicator.dart';
import 'package:flutter/material.dart';

class PansDayView extends StatelessWidget{

  final List<Course> courses;

  const PansDayView(this.courses, {super.key});
  // add timer for counting to next course
  // if date is equal to actual
  @override
  Widget build(BuildContext context) {
    var lastHour = courses.first.endHour;
    return ScrollConfiguration(
      behavior: ScrollConfiguration.of(context).copyWith(
        dragDevices: PointerDeviceKind.values.toSet()
      ),
      child: ListView(
        physics: const AlwaysScrollableScrollPhysics(parent: BouncingScrollPhysics()),
        children: [

          ...courses.map((e){
            final currentBreak = e.startHour - lastHour;
            lastHour = e.endHour;

            return [
              if (currentBreak > HoursDecoder.breakLength)
                PansBreakIndicator(currentBreak),
              e.toWidget(context),
            ];
          }).expand((widget) => widget),

          // just a little space underneath to prevent fabs from covering
          // courses (spotted on windows, may not appear elsewhere)
          const SizedBox(height: 90,),
        ],
      ),
    );
  }

}