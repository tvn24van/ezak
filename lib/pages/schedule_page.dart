import 'package:ezak/l10n/l10n.g.dart';
import 'package:ezak/providers/displayed_date_provider.dart';
import 'package:ezak/providers/schedule_provider.dart';
import 'package:ezak/widgets/day_view.dart';
import 'package:ezak/widgets/info_button.dart';
import 'package:ezak/widgets/date_button.dart';
import 'package:ezak/widgets/app_bar.dart';
import 'package:ezak/widgets/fabs.dart';
import 'package:ezak/widgets/popup_items/about_popup_item.dart';
import 'package:ezak/widgets/popup_items/settings_popup_item.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';

final class SchedulePage extends StatelessWidget {
  const SchedulePage({super.key});
  static PageController? pageController;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PansAppBar(
        additionalActions: const [
          PansDateButton(),
          PansInfoButton(),
        ],
        popupItems: [
          PansSettingsPopupItem(context),
          PansAboutAppPopupItem(context)
        ],
        context: context,
      ),
      body: Center(
        child: Consumer(
          builder: (BuildContext context, WidgetRef ref, Widget? child) {
            final schedule = ref.watch(ScheduleProvider.instance);

            return schedule.when(
              skipLoadingOnRefresh: true,
              data: (data) {

                return PageView.builder(
                  itemCount: data.dates.length,
                  physics: const BouncingScrollPhysics(),
                  controller: pageController,
                  onPageChanged: (index) {
                    final newDate = data.dates[index];
                    ref.read(displayedDate.notifier).state = newDate;
                    ref.read(ScheduleProvider.instance.notifier).loadCourses(newDate);
                  },
                  itemBuilder: (context, index) {
                    final date = data.dates[index];
                    // final coursesForDate = ;

                    return RefreshIndicator(
                      onRefresh: () async {
                        return showUpdateDialog(context, ref);
                      },
                      child: PansDayView(data.courses[date] ?? []),
                    );
                  },
                );
              },
              error: (error, stackTrace) => Text(error.toString()),
              loading: () => CircularProgressIndicator.adaptive(),
            );
          },
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: const PansFloatingActionButtons(),
    );
  }

  static Future<dynamic> showUpdateDialog(BuildContext context, WidgetRef ref) {
    return showAdaptiveDialog(
      context: context,
      builder: (context) => AlertDialog.adaptive(
        title: Text(L10n.of(context).schedule_update_prompt),
        actions: [
          TextButton(
            onPressed: () {
              // todo add back or abandon these functionalities
              Navigator.of(context).pop();
            },
            child: Text(L10n.of(context).force_schedule_redownload),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Text(L10n.of(context).check_for_schedule_update),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Text(MaterialLocalizations.of(context).cancelButtonLabel),
          ),
        ],
      ),
    );
  }
}
