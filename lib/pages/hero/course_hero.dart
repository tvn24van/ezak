import 'package:ezak/model/course.dart';
import 'package:ezak/l10n/l10n.g.dart';
import 'package:ezak/widgets/app_bar.dart';
import 'package:ezak/widgets/mixins/course_widget.dart';
import 'package:ezak/widgets/popup_items/about_popup_item.dart';
import 'package:ezak/widgets/popup_items/settings_popup_item.dart';
import 'package:flutter/material.dart';

final class CourseHero extends StatelessWidget{
  final CourseModel course;
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
            onPressed: (course.isOnline() || course.getLocationAddress()==null?
              null: // todo implement in another way
              ()async=> {} /*MapsLauncher.launchQuery(course.getLocationAddress()!) */
            ),
            icon: const Icon(Icons.map),
            tooltip: L10n.of(context).show_on_map,
          )
        ],
      ),
    );
  }

  static Color? lerpColorWithBackground(BuildContext context, Color color, {double t=.2}){
    return Color.lerp(Theme.of(context).colorScheme.surface, color, t);
  }

}