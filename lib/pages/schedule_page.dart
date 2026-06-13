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
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';

class SchedulePage extends ConsumerWidget {
  const SchedulePage({super.key});

  static final _datesWithInitialDate = FutureProvider((ref) async{
   return (
    dates: await ref.watch(datesProvider.future),
    initialDate: await ref.watch(initialDateProvider.future)
   );
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final datesWithInitialDate = ref.watch(_datesWithInitialDate);

    return Scaffold(
      appBar: PansAppBar(
        additionalActions: [PansInfoButton()],
        context: context,
      ),
      endDrawer: const PansNavigationDrawer(page: 0),
      body: SafeArea(
        child: Center(
          child: datesWithInitialDate.when(
            data: (data) => SchedulePageView(dates: data.dates, initialDate: data.initialDate),
            error: (error, stackTrace) => CircularProgressIndicator(),
            loading: () => CircularProgressIndicator(),
          )
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
              HapticFeedback.mediumImpact();
            },
            child: Text(L10n.of(context).force_schedule_redownload),
          ),
          TextButton(
            onPressed: () {
              ref.read(FreshnessProvider.instance.notifier).checkForUpdate();
              Navigator.of(context).pop();
              HapticFeedback.lightImpact();
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

class SchedulePageView extends ConsumerStatefulWidget {
  final List<DateTime> dates;
  final DateTime initialDate;

  const SchedulePageView({
    super.key,
    required this.dates,
    required this.initialDate,
  });

  @override
  ConsumerState<SchedulePageView> createState() => _SchedulePageViewState();
}

class _SchedulePageViewState extends ConsumerState<SchedulePageView> {
  late PageController _pageController;

  @override
  void initState() {
    super.initState();

    final initialIndex = widget.dates.indexOf(widget.initialDate);
    _pageController = PageController(
      initialPage: initialIndex != -1 ? initialIndex : 0,
    );
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isLecturer = ref.read(SettingsProvider.isLecturer);
    final key = ref.read(SettingsProvider.key);
    final groups = ref.read(SettingsProvider.groups);

    ref.listen(DisplayedDateProvider.instance, (previous, next) {
      if(next.value==null){
        return;
      }
      final targetIndex = widget.dates.indexOf(next.value!);

      if (targetIndex != -1) {
        final currentIndex = _pageController.page?.round();
        if(currentIndex!=null && currentIndex != targetIndex) {
          if((currentIndex-targetIndex).abs() == 1) {
            _pageController.animateToPage(
              targetIndex,
              duration: kTabScrollDuration,
              curve: Curves.easeInOut,
            );
          }else{
            _pageController.jumpToPage(targetIndex);
          }
        }
      }
    });

    return PageView.builder(
      key: Key("$isLecturer-$key-$groups"),
      itemCount: widget.dates.length,
      physics: const BouncingScrollPhysics(),
      controller: _pageController,
      onPageChanged: (index) {
        ref.read(DisplayedDateProvider.instance.notifier).change(widget.dates[index]);
      },
      itemBuilder: (context, index) {
        final date = widget.dates[index];
        final coursesP = ref.watch(coursesProvider(date));

        return coursesP.maybeWhen(
          data: (courses) => RefreshIndicator(
            onRefresh: () async {
              return SchedulePage.showUpdateDialog(context, ref);
            },
            child: PansDayView(courses),
          ),
          orElse: () => const Center(child: CircularProgressIndicator()),
        );
      },
    );
  }
}