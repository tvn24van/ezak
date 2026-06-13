import 'package:ezak/l10n/l10n.g.dart';
import 'package:ezak/providers/dates_provider.dart';
import 'package:ezak/providers/displayed_date_provider.dart';
import 'package:ezak/providers/settings_provider.dart';
import 'package:ezak/utils/extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

final class PansFloatingActionButtons extends ConsumerWidget{
  const PansFloatingActionButtons({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final dates = ref.watch(datesProvider);
    final disabled = !dates.hasValue;

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
              ref.read(DisplayedDateProvider.instance.notifier).previous();
            },
            heroTag: null,
            tooltip: MaterialLocalizations.of(context).previousPageTooltip,
            child: Icon(Icons.arrow_back),
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
                    if(selectedDate==null || selectedDate==currentDate.value) return;
                    ref.read(DisplayedDateProvider.instance.notifier).change(selectedDate);
                    HapticFeedback.successNotification();
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
              ref.read(DisplayedDateProvider.instance.notifier).next();
            },
            heroTag: null,
            tooltip: MaterialLocalizations.of(context).nextPageTooltip,
            child: Icon(Icons.arrow_forward),
          ),
        ],
      ),
    );
  }
}