import 'package:ezak/providers/schedule_provider.dart';
import 'package:ezak/utils/l10n/l10n.g.dart';
import 'package:ezak/widgets/container.dart';
import 'package:ezak/widgets/info_button.dart';
import 'package:ezak/widgets/date_button.dart';
import 'package:ezak/widgets/app_bar.dart';
import 'package:ezak/widgets/fabs.dart';
import 'package:ezak/widgets/popup_items/about_popup_item.dart';
import 'package:ezak/widgets/popup_items/settings_popup_item.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';

class SchedulePage extends StatelessWidget {

  const SchedulePage({super.key});

  static final pageViewController = StateProvider<PageController>((ref) =>
    PageController()
  );

  static final currentDate = StateProvider<DateTime>((ref) =>
    DateTime.now()
  );

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
          builder: (context, ref, child) {
            final schedule = ref.watch(ScheduleProvider.instance);

            return schedule.when(
              data: (data)=> data.toConsumerWidget(context, ref),
              error: (err, stack)=> PansCard(
                children: [
                  const Icon(Icons.nearby_error),
                  Text(L10n.of(context).error_occurred),
                  SelectableText('$err')
                ],
              ),
              loading: ()=> const CircularProgressIndicator.adaptive(),
            );
          },
        ),
      ),

      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: const PansFloatingActionButtons(),
    );
  }
}