import 'package:ezak/model/course.dart';
import 'package:ezak/utils/extensions.dart';
import 'package:ezak/utils/l10n/l10n.g.dart';
import 'package:ezak/widgets/abstract/widget_transformable.dart';
import 'package:flutter/material.dart';

mixin CourseWidget on CourseModel implements WidgetTransformable{

  @override
  Widget toWidget(BuildContext context){
    return Container(
      padding: const EdgeInsets.all(15),
      margin: const EdgeInsets.fromLTRB(15, 15, 15, 0),
      decoration: BoxDecoration(
        color: group.color.withOpacity(.2),
        borderRadius: const BorderRadius.all(Radius.circular(10))
      ),
      child: Row(
        children: [
          Column( // hours
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(L10n.of(context).from_hour(startHour.toPansString())),
              Text(L10n.of(context).to_hour(endHour.toPansString())),
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
                isOnline()?
                  Text(L10n.of(context).online_course):
                  Text(L10n.of(context).building_and_room(location, roomNumber)),
              ],
            ),
          ),
          const SizedBox(width: 15,),
          isOnline()?
            const Icon(Icons.online_prediction):
            const Icon(Icons.home),
        ],
      ),
    );
  }

}