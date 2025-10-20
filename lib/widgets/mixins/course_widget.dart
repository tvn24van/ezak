import 'package:ezak/model/course.dart';
import 'package:ezak/pages/hero/course_hero.dart';
import 'package:ezak/l10n/l10n.g.dart';
import 'package:ezak/widgets/abstract/widget_transformable.dart';
import 'package:flutter/material.dart';

mixin CourseWidget on CourseModel implements WidgetTransformable{

  static const BorderRadius _borderRadius = BorderRadius.all(Radius.circular(16));

  @override
  Widget toWidget(BuildContext context){
    return Container(
      margin: const EdgeInsets.fromLTRB(15, 15, 15, 0),
      child: InkWell(
        borderRadius: _borderRadius,
        onTap: ()async=> {},
        //   Navigator.push(
        //     context,
        //     MaterialPageRoute(builder: (context) => CourseHero(course: this))
        //   ),
        child: Ink(
          padding: const EdgeInsets.all(15),
          decoration: BoxDecoration(
            color: Color.lerp(Theme.of(context).scaffoldBackgroundColor, group.color, .2),
            borderRadius: _borderRadius
          ),
          child: Row(
            children: [
              Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(L10n.of(context).from_hour(startTime.format(context))),
                  Text(L10n.of(context).to_hour(endTime.format(context))),
                ],
              ),
              const SizedBox(width: 15,),
              Expanded(
                child: Wrap(
                  alignment: WrapAlignment.spaceBetween,
                  spacing: 15,
                  children: [
                    Text(name),
                    Text(lecturer),
                    Text(
                      getTranslationDescribingCourseLocation(this, context)
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 15,),
              Hero(
                tag: this,
                child: getIconDescribingCourse(this),
              )
            ],
          ),
        ),
      ),
    );
  }

  static Icon getIconDescribingCourse(CourseModel course){
    return course.isOnline()?
      const Icon(Icons.computer):
      const Icon(Icons.home_work);
  }

  static String getTranslationDescribingCourseLocation(CourseModel course, BuildContext context){
    return course.isOnline()?
      L10n.of(context).online_course:
      L10n.of(context).building_and_room(course.location, course.roomNumber);
  }

}