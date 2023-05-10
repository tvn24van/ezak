import 'package:ezak/model/schedule.dart';
import 'package:ezak/pages/schedule_page.dart';
import 'package:ezak/providers/schedule_provider.dart';
import 'package:ezak/providers/settings_provider.dart';
import 'package:ezak/utils/l10n/l10n.g.dart';
import 'package:ezak/widgets/day_view.dart';
import 'package:ezak/widgets/abstract/widget_transformable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

mixin ScheduleWidget on ScheduleModel implements ConsumerWidgetTransformable{
  @override
  Widget toConsumerWidget(BuildContext context, WidgetRef ref) {
    final groups = ref.watch(SettingsProvider.instance.select((value) => value.groups));

    return PageView.builder(
      itemCount: getDaysAmount(),
      physics: const BouncingScrollPhysics(),
      controller: ref.read(SchedulePage.pageViewController),
      onPageChanged: (index){
        ref.read(SchedulePage.currentDate.notifier).update((state) =>
          getDateOfIndex(index)
        );
      },
      itemBuilder: (context, index) {
        final isTeacher = ref.watch(
          SettingsProvider.instance.select((settings) => settings.isTeacher)
        );
        final courses = isTeacher?
          getCoursesForDate(getDateOfIndex(index)):
          getCoursesForDate(getDateOfIndex(index))
            ..removeWhere((element) => !groups[element.group]!.contains(element.groupNumber));
        courses.sort((a,b)=> a.startHour.compareTo(b.startHour));
        return RefreshIndicator(
          onRefresh: () async{
            showDialog(
              context: context,
              builder: (context) => AlertDialog(
                title: Text(L10n.of(context).schedule_update_prompt),
                actions: [
                  TextButton(
                    onPressed: (){
                      ref.watch(ScheduleProvider.instance.notifier).redownload();
                      Navigator.of(context).pop();
                    },
                    child: Text(L10n.of(context).force_schedule_redownload)
                  ),
                  TextButton(
                    onPressed: (){
                      ref.watch(ScheduleProvider.instance.notifier).build();
                      Navigator.of(context).pop();
                    },
                    child: Text(L10n.of(context).check_for_schedule_update)
                  ),
                  TextButton(
                    onPressed: (){
                      Navigator.of(context).pop();
                    },
                    child: Text(MaterialLocalizations.of(context).cancelButtonLabel)
                  ),
                ],
              ),
            );
          },
          child: PansDayView(courses)
        );
      },
    );
  }
}