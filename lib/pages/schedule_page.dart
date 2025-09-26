import 'package:ezak/l10n/l10n.g.dart';
import 'package:ezak/providers/displayed_date_provider.dart';
import 'package:ezak/providers/schedule_provider.dart';
import 'package:ezak/providers/settings_provider.dart';
import 'package:ezak/widgets/day_view.dart';
import 'package:ezak/widgets/drawer.dart';
import 'package:ezak/widgets/info_button.dart';
import 'package:ezak/widgets/app_bar.dart';
import 'package:ezak/widgets/fabs.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';

final class SchedulePage extends StatelessWidget {
  const SchedulePage({super.key});
  static PageController? pageController;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PansAppBar(
        additionalActions: [
          PansInfoButton(),
        ],
        context: context,
      ),
      endDrawer: PansNavigationDrawer(page: 0),
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
                    ref.read(displayedDate.notifier).change(newDate);
                    ref.read(ScheduleProvider.instance.notifier).loadCourses(newDate);
                  },
                  itemBuilder: (context, index) {
                    final date = data.dates[index];

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
              ref.read(ScheduleProvider.instance.notifier).build(forceDownload: true);
              Navigator.of(context).pop();
            },
            child: Text(L10n.of(context).force_schedule_redownload),
          ),
          if(!ref.read(SettingsProvider.instance.select((value) => value.isLecturer)))
            TextButton(
              onPressed: () {
                ref.read(ScheduleProvider.instance.notifier).build(forceAutoUpdates: true);
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
