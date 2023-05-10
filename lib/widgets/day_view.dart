import 'dart:ui';

import 'package:ezak/model/course.dart';
import 'package:flutter/material.dart';

class PansDayView extends StatelessWidget{

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
          ... courses.map((e) => e.toWidget(context)).toList(),
          // just a little space underneath to prevent fabs from covering
          // courses (spotted on windows, may not appear elsewhere)
          const SizedBox(height: 90,),
        ],
      ),
    );
  }

}