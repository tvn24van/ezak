import 'package:ezak/model/course.dart';
import 'package:ezak/widgets/app_bar.dart';
import 'package:ezak/widgets/mixins/course_widget.dart';
import 'package:ezak/widgets/popup_items/about_popup_item.dart';
import 'package:ezak/widgets/popup_items/settings_popup_item.dart';
import 'package:flutter/material.dart';
import 'package:maps_launcher/maps_launcher.dart';

class CourseHero extends StatelessWidget{
  final Course course;
  const CourseHero({super.key, required this.course});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PansAppBar(
        pansLeading: Tooltip(
          message: MaterialLocalizations.of(context).backButtonTooltip,
          child: IconButton(
              onPressed: () => Navigator.pop(context),
              icon: Icon(Icons.adaptive.arrow_back)
          ),
        ),
        leadingText: course.name,
        popupItems: [
          PansSettingsPopupItem(context),
          PansAboutAppPopupItem(context)
        ],
        context: context,
      ),
      backgroundColor: lerpColorWithBackground(context, course.group.color),
      body: Column(
        children: [
          Hero(
              tag: course,
              child: CourseWidget.getIconDescribingCourse(course)
          ),
          Text(
            CourseWidget.getTranslationDescribingCourseLocation(course, context)
          ),
          IconButton(
            onPressed: ()async=> MapsLauncher.launchQuery(course.getLocationQuery()),
            icon: const Icon(Icons.map)
          )
        ],
      ),
    );
  }

  static Color? lerpColorWithBackground(BuildContext context, Color color){
    return Color.lerp(Theme.of(context).colorScheme.background, color, .2);
  }

}