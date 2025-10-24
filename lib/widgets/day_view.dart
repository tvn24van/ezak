import 'package:ezak/model/course.dart';
import 'package:ezak/model/decoders/time_decoder.dart';
import 'package:ezak/utils/extensions.dart';
import 'package:ezak/widgets/break_indicator.dart';
import 'package:flutter/material.dart';

final class PansDayView extends StatelessWidget{

  final List<Course> courses;

  const PansDayView(this.courses, {super.key});
  // add timer for counting to next course
  // if date is equal to actual
  @override
  Widget build(BuildContext context) {
    return SizedBox.expand(
      child: SingleChildScrollView(
        physics: const AlwaysScrollableScrollPhysics(
          parent: BouncingScrollPhysics(),
        ),
        child: Align(
          alignment: Alignment.topCenter,
          child: ConstrainedBox(
            constraints: BoxConstraints(maxWidth: 1000),
            child: Column(
              children: [
                ...courses.asMap().entries.expand((entry) {
                  final index = entry.key;
                  final course = entry.value;
                  final int currentBreak = index > 0
                      ? (course.startTime - courses[index - 1].endTime).totalMinutes
                      : TimeDecoder.breakLengthInMinutes;

                  return [
                    if (currentBreak > TimeDecoder.breakLengthInMinutes)
                      PansBreakIndicator(Duration(minutes: currentBreak)),
                    course.toWidget(context),
                  ];
                }),
                // just a little space underneath to prevent fabs from covering courses
                const SizedBox(height: 90),
              ],
            ),
          ),
        ),
      ),
    );
  }

}