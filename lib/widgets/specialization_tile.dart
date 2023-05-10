import 'package:drop_down_list/drop_down_list.dart';
import 'package:drop_down_list/model/selected_list_item.dart';
import 'package:ezak/model/settings.dart';
import 'package:ezak/providers/settings_provider.dart';
import 'package:ezak/providers/specializations_provider.dart';
import 'package:ezak/utils/l10n/l10n.g.dart';
import 'package:ezak/visuals/appereance.dart';
import 'package:feature_discovery/feature_discovery.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PansSpecializationTile extends ConsumerWidget{
  const PansSpecializationTile({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final specializations = ref.watch(specializationsProvider);
    final selectedSpecialization = ref.watch(
        SettingsProvider.instance.select((settings) => settings.specializationKey)
    );
    final isTeacher = ref.watch(
        SettingsProvider.instance.select((settings) => settings.isTeacher)
    );
    final titleText = isTeacher?
      L10n.of(context).lecturer:
      L10n.of(context).specialization;

    if(selectedSpecialization == Settings.defaultSpecializationKey){
      WidgetsBinding.instance.addPostFrameCallback((_) =>
          FeatureDiscovery.discoverFeatures(
              context,
              {
                "language",
                "teacher_mode",
                "specialization",
                "go_to_schedule"
              }
          )
      );
    }

    return ListTile(
      title: Text(titleText),
      leading: const Icon(Icons.accessibility),
      onTap: (){},
      trailing: specializations.when(
        data: (data){
          final isSelected = selectedSpecialization != Settings.defaultSpecializationKey;
          final button = OutlinedButton(
            onPressed: ()=>
              DropDownState(
                DropDown(
                  bottomSheetTitle: Text(titleText),
                  data: data.entries.map((entry) =>
                    SelectedListItem(
                      name: entry.key,
                      value: entry.value.toString(),
                      isSelected: entry.value==selectedSpecialization,
                    )
                  ).toList(),
                  selectedItems: (List<dynamic> selectedList){
                    ref.read(SettingsProvider.instance.notifier)
                      .changeSpecialization(int.parse(
                        selectedList.whereType<SelectedListItem>().single.value!
                    ));
                  },
                  searchHintText: MaterialLocalizations.of(context).searchFieldLabel
                ),
              ).showModal(context),
            child: Text(isSelected?
              data.entries.singleWhere((element) =>
                element.value==selectedSpecialization
              ).key:
              L10n.of(context).specialization,
            ),
          );

          return DescribedFeatureOverlay(
            featureId: "specialization",
            title: Text(L10n.of(context).choose_specialization),
            backgroundColor: PansAppereance.colors.red,
            targetColor: Theme.of(context).canvasColor,
            pulseDuration: Duration.zero,
            enablePulsingAnimation: false,
            tapTarget: AbsorbPointer(
              absorbing: true,
              child: button
            ),
            child: button,
          );
        },
        loading: ()=> const OutlinedButton(
          onPressed: null,
          child: CircularProgressIndicator.adaptive()
        ),
        error: (err, stack)=> const OutlinedButton(
          onPressed: null,
          child: CircularProgressIndicator.adaptive()
        ),
      ),
    );
  }

}