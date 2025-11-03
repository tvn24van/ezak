import 'package:ezak/l10n/l10n.g.dart';
import 'package:ezak/providers/courses_provider.dart';
import 'package:ezak/providers/dates_provider.dart';
import 'package:ezak/providers/displayed_date_provider.dart';
import 'package:ezak/providers/initial_date_provider.dart';
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

  static final pageControllerProvider = FutureProvider<PageController>((ref) async{
    final dates = await ref.watch(datesProvider.future);
    final initialDate = await ref.watch(initialDateProvider.future);
    final pageController = PageController(initialPage: dates.indexOf(initialDate));
    ref.onDispose(pageController.dispose);
    return pageController;
  });

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
            final isLecturer = ref.read(SettingsProvider.isLecturer);
            final key = ref.read(SettingsProvider.key);
            final groups = ref.read(SettingsProvider.groups);
            final datesP = ref.watch(datesProvider);
            final pageController = ref.watch(pageControllerProvider);
            return datesP.maybeWhen(
              data: (dates) {
                return PageView.builder(
                  key: Key("$isLecturer-$key-$groups"),
                  itemCount: dates.length,
                  physics: const BouncingScrollPhysics(),
                  controller: pageController.value,
                  onPageChanged: (index) {
                    final newDate = dates[index];
                    ref.read(DisplayedDateProvider.instance.notifier).change(newDate);
                    ref.read(CoursesProvider.instance.notifier).loadCourses(newDate);
                  },
                  itemBuilder: (context, index) {
                    final date = dates[index];
                    final coursesP = ref.watch(CoursesProvider.instance..selectAsync((data) => data[date]));

                    return coursesP.maybeWhen(
                      data: (courses) => RefreshIndicator(
                        onRefresh: () async {
                          return showUpdateDialog(context, ref);
                        },
                        child: PansDayView(courses[date] ?? []),
                      ),
                      orElse: () => CircularProgressIndicator()
                    );
                  },
                );
              },
              orElse: () => CircularProgressIndicator()
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
              // ref.read(ScheduleProvider.instance.notifier).build(forceDownload: true); // todo add back schedule actions
              Navigator.of(context).pop();
            },
            child: Text(L10n.of(context).force_schedule_redownload),
          ),
          if(!ref.read(SettingsProvider.instance.select((value) => value.isLecturer)))
            TextButton(
              onPressed: () {
                // ref.read(ScheduleProvider.instance.notifier).build(forceAutoUpdates: true);
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
