import 'package:ezak/model/course.dart';
import 'package:ezak/utils/extensions.dart';
import 'package:ezak/utils/l10n/l10n.g.dart';
import 'package:ezak/widgets/abstract/widget_transformable.dart';
import 'package:flutter/material.dart';

mixin CourseWidget on CourseModel implements WidgetTransformable{

  @override
  Widget toWidget(BuildContext context){
    return Container(
      padding: const EdgeInsets.all(10),
      margin: const EdgeInsets.fromLTRB(15, 15, 15, 0),
      decoration: BoxDecoration(
        color: group.color.withOpacity(.2),
        borderRadius: const BorderRadius.all(Radius.circular(10))
      ),
      child: Row(
        children: [
          Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(L10n.of(context).from_hour(startHour.toPansString())),
              Text(L10n.of(context).to_hour(endHour.toPansString())),
            ],
          ),
          // const Spacer(),
          Expanded(
            child: Wrap(
              alignment: WrapAlignment.spaceAround,
              children: [
                Text('$name, $lecturer'),
                Wrap(
                  children: isOnline()?
                  [
                    Text(L10n.of(context).online_course),
                    const Icon(Icons.online_prediction),
                  ]:
                  [
                    Text(L10n.of(context).building_and_room(location, roomNumber)),
                    const Icon(Icons.home),
                  ],
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

}