import 'package:ezak/l10n/l10n.g.dart';
import 'package:ezak/providers/courses_provider.dart';
import 'package:ezak/providers/dates_provider.dart';
import 'package:ezak/providers/displayed_date_provider.dart';
import 'package:ezak/providers/freshness_provider.dart';
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
    // ref.onDispose(pageController.dispose);
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
      body: SafeArea(
        child: Center(
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
                    onPageChanged: dates.isEmpty? null : (index) {
                      ref.read(DisplayedDateProvider.instance.notifier).change(dates[index]);
                    },
                    itemBuilder: (context, index) {
                      final date = dates[index];
                      final coursesP = ref.watch(coursesProvider(date));
                      return coursesP.maybeWhen(
                        data: (courses) => RefreshIndicator(
                          onRefresh: () async {
                            return showUpdateDialog(context, ref);
                          },
                          child: PansDayView(courses),
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
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: const PansFloatingActionButtons(),
    );
  }

  static Future<dynamic> showUpdateDialog(BuildContext context, WidgetRef ref) {
    return showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(L10n.of(context).schedule_update_prompt),
        actions: [
          TextButton(
            onPressed: () {
              ref.read(FreshnessProvider.instance.notifier).checkForUpdate(forceDownload: true);
              Navigator.of(context).pop();
            },
            child: Text(L10n.of(context).force_schedule_redownload),
          ),
          if(!ref.read(SettingsProvider.isLecturer)) //todo remove isLecturer check when autoupdates is implemented
            TextButton(
              onPressed: () {
                ref.read(FreshnessProvider.instance.notifier).checkForUpdate();
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
