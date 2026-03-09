import 'package:ezak/model/course.dart';
import 'package:ezak/l10n/l10n.g.dart';
import 'package:ezak/providers/settings_provider.dart';
import 'package:ezak/utils/extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CourseWidget extends ConsumerWidget {
  final Course course;
  
  const CourseWidget({super.key, required this.course});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final highContrast = ref.watch(SettingsProvider.instance.select((s) => s.highContrast));

    return Card.filled(
      clipBehavior: Clip.hardEdge,
      color: highContrast?
        course.group.color.ensureWcagAaContrast(context):
        Color.lerp(Theme.of(context).scaffoldBackgroundColor, course.group.color, .2),
      child: InkWell(
        onTap: ()async=> {},
        //   Navigator.push(
        //     context,
        //     MaterialPageRoute(builder: (context) => CourseHero(course: this))
        //   ),

        child: Padding(
          padding: EdgeInsets.all(15),
          child: Row(
            spacing: 15,
            children: [
              Column(
                children: [
                  Text(L10n.of(context).from_hour(course.startTime.format(context))),
                  Text(L10n.of(context).to_hour(course.endTime.format(context))),
                ],
              ),
              Expanded(
                child: Wrap(
                  alignment: WrapAlignment.spaceBetween,
                  spacing: 15,
                  children: [
                    Text(course.name),
                    Text(course.lecturer),
                    Text(
                        getTranslationDescribingCourseLocation(course, context)
                    ),
                  ],
                ),
              ),
              Hero(
                tag: this,
                child: getIconDescribingCourse(course),
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