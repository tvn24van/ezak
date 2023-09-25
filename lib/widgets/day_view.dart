import 'dart:ui';

import 'package:ezak/model/course.dart';
import 'package:ezak/model/decoders/hours_decoder.dart';
import 'package:ezak/widgets/break_indicator.dart';
import 'package:flutter/material.dart';

final class PansDayView extends StatelessWidget{

  final List<Course> courses;

  const PansDayView(this.courses, {super.key});
  // add timer for counting to next course
  // if date is equal to actual
  @override
  Widget build(BuildContext context) {
    return ScrollConfiguration(
      behavior: ScrollConfiguration.of(context).copyWith(
        dragDevices: PointerDeviceKind.values.toSet()
      ),
      child: ListView(
        physics: const AlwaysScrollableScrollPhysics(parent: BouncingScrollPhysics()),
        children: [

          ...courses.asMap().entries.expand((entry) {
            final index = entry.key;
            final course = entry.value;
            final currentBreak = index > 0?
              course.startHour - courses[index - 1].endHour:
              HoursDecoder.breakLength;

            return [
              if (currentBreak > HoursDecoder.breakLength)
                PansBreakIndicator(currentBreak),
              course.toWidget(context),
            ];
          }),

          // just a little space underneath to prevent fabs from covering
          // courses (spotted on windows, may not appear elsewhere)
          const SizedBox(height: 90,),
        ],
      ),
    );
  }

}