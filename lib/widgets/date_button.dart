import 'package:ezak/pages/schedule_page.dart';
import 'package:ezak/l10n/l10n.g.dart';
import 'package:ezak/providers/courses_provider.dart';
import 'package:ezak/utils/extensions.dart';
import 'package:ezak/visuals/appereance.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final class PansDateButton extends ConsumerWidget{
  const PansDateButton({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final courses = ref.watch(CoursesProvider.instance);

    return Tooltip(
      message: L10n.of(context).date_selection,
      child: courses.when(
        data: (data) {
          final currentDate = ref.watch(SchedulePage.currentDate);
          return ElevatedButton(
            onPressed: () async {
              DateTime? selectedDate = await showDatePicker(
                context: context,
                locale: Localizations.localeOf(context),
                keyboardType: TextInputType.datetime,
                helpText: L10n.of(context).choose_courses_date,
                initialDate: currentDate,
                firstDate: data.entries.first.key,
                lastDate: data.entries.last.key,
                selectableDayPredicate: (DateTime value)=> data.keys.contains(value)
                  // data.containsDate(value),
              );
              if(selectedDate==null) {
                return;
              }
              ref.read(SchedulePage.pageViewController).animateToPage(
                // data.getIndexOfDate(selectedDate),
                data.keys.toList().indexOf(selectedDate),
                duration: PansAppereance.pageControllerSettings.duration,
                curve: PansAppereance.pageControllerSettings.curve,
              );

              ref.read(SchedulePage.currentDate.notifier).update((state) =>
                selectedDate
              );
            },
            child: Text(currentDate.toLocaleString(Localizations.localeOf(context))),
          );
        },
        error: (err, stack)=> ElevatedButton(
          onPressed: null,
          child: Text(MaterialLocalizations.of(context).unspecifiedDate),
        ),
        loading: ()=> ElevatedButton(
          onPressed: (){},
          child: const CircularProgressIndicator.adaptive()
        )
      ),
    );
  }

}