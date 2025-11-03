import 'package:ezak/l10n/l10n.g.dart';
import 'package:ezak/pages/schedule_page.dart';
import 'package:ezak/providers/courses_provider.dart';
import 'package:ezak/providers/dates_provider.dart';
import 'package:ezak/providers/displayed_date_provider.dart';
import 'package:ezak/providers/settings_provider.dart';
import 'package:ezak/utils/extensions.dart';
import 'package:ezak/visuals/appearance.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

final class PansFloatingActionButtons extends ConsumerWidget{
  const PansFloatingActionButtons({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final courses = ref.watch(CoursesProvider.instance);
    final disabled = !courses.hasValue;
    final settingsCompleted = ref.watch(SettingsProvider.completed);
    if(!settingsCompleted) return SizedBox.shrink();

    return Container(
      margin: const EdgeInsets.only(bottom: 20, left: 15, right: 15),
      child: Row(
        mainAxisAlignment: MediaQuery.of(context).orientation==Orientation.portrait?
          MainAxisAlignment.spaceBetween : MainAxisAlignment.spaceEvenly,
        children: [
          FloatingActionButton(
            onPressed: disabled? null : () async{
              final pageController = await ref.read(SchedulePage.pageControllerProvider.future);
              pageController.previousPage(
                duration: PansAppereance.pageControllerSettings.duration,
                curve: PansAppereance.pageControllerSettings.curve
              );
            },
            heroTag: null,
            tooltip: MaterialLocalizations.of(context).previousPageTooltip,
            child: Icon(Icons.adaptive.arrow_back),
          ),
          Consumer(builder: (context, ref, child) {
            final allDates = ref.watch(datesProvider);
            final currentDate = ref.watch(DisplayedDateProvider.instance);
            return allDates.when(
              data: (data) {
                final dates = data;
                return FloatingActionButton.extended(
                  icon: Icon(Icons.date_range),
                  label: currentDate.maybeWhen(data: (data) => Text('${DateFormat.E(L10n.of(context).localeName).format(data)}\n${data.toLocaleString(Localizations.localeOf(context))}', textAlign: TextAlign.center,), orElse: () => CircularProgressIndicator()),
                  tooltip: L10n.of(context).date_selection,
                  onPressed: () async{
                    final selectedDate = await showDatePicker(
                      context: context,
                      locale: Localizations.localeOf(context),
                      keyboardType: TextInputType.datetime,
                      helpText: L10n.of(context).choose_courses_date,
                      initialDate: currentDate.value,
                      firstDate: dates.first,
                      lastDate: dates.last,
                      selectableDayPredicate: (DateTime value)=> dates.contains(value)
                    );
                    if(selectedDate==null) return;
                    final pageController = await ref.read(SchedulePage.pageControllerProvider.future);
                    pageController.jumpToPage(dates.indexOf(selectedDate));
                  },
                );
              },
              error: (err, stack)=> FloatingActionButton.extended(
                onPressed: null,
                icon: Icon(Icons.date_range),
                label: Text(MaterialLocalizations.of(context).unspecifiedDate),
              ),
              loading: ()=> FloatingActionButton.extended(
                onPressed: null,
                icon: Icon(Icons.date_range),
                label: CircularProgressIndicator(),
              )
            );
          }),
          FloatingActionButton(
            onPressed: disabled? null : () async{
              final pageController = await ref.read(SchedulePage.pageControllerProvider.future);
              pageController.nextPage(
                duration: PansAppereance.pageControllerSettings.duration,
                curve: PansAppereance.pageControllerSettings.curve,
              );
            },
            heroTag: null,
            tooltip: MaterialLocalizations.of(context).nextPageTooltip,
            child: Icon(Icons.adaptive.arrow_forward),
          ),
        ],
      ),
    );
  }
}