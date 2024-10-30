import 'package:ezak/l10n/l10n.g.dart';
import 'package:ezak/pages/schedule_page.dart';
import 'package:ezak/providers/displayed_date_provider.dart';
import 'package:ezak/providers/schedule_provider.dart';
import 'package:ezak/utils/extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final class PansDateButton extends ConsumerWidget{
  const PansDateButton({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final allAndInitialDate = ref.watch(ScheduleProvider.instance);
    final currentDate = ref.watch(displayedDate);

    return Tooltip(
      message: L10n.of(context).date_selection,
      child: allAndInitialDate.when(
        data: (data) {
          final dates = data.dates;
          return ElevatedButton(
            onPressed: () async {
              DateTime? selectedDate = await showDatePicker(
                context: context,
                locale: Localizations.localeOf(context),
                keyboardType: TextInputType.datetime,
                helpText: L10n.of(context).choose_courses_date,
                initialDate: currentDate,
                firstDate: dates.first,
                lastDate: dates.last,
                selectableDayPredicate: (DateTime value)=> dates.contains(value)
              );
              if(selectedDate==null) return;
              SchedulePage.pageController?.jumpToPage(dates.indexOf(selectedDate));
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