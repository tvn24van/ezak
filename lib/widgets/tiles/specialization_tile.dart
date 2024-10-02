import 'package:ezak/model/settings.dart';
import 'package:ezak/providers/settings_provider.dart';
import 'package:ezak/providers/specializations_provider.dart';
import 'package:ezak/utils/extensions.dart';
import 'package:ezak/l10n/l10n.g.dart';
import 'package:ezak/visuals/appereance.dart';
import 'package:flutter/foundation.dart';
// import 'package:feature_discovery_fork/feature_discovery.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final class PansSpecializationTile extends ConsumerWidget{
  const PansSpecializationTile({super.key});

  static final _searchController = SearchController();

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

    // if(selectedSpecialization == Settings.defaultSpecializationKey){ // todo we must handle this better
    //   WidgetsBinding.instance.addPostFrameCallback((_) =>
    //     FeatureDiscovery.discoverFeatures(
    //       context,
    //       {
    //         "language",
    //         "teacher_mode",
    //         "specialization",
    //         "go_to_schedule"
    //       }
    //     )
    //   );
    // }

    return ListTile(
      title: Text(titleText),
      leading: const Icon(Icons.accessibility),
      onTap: (){},
      trailing: SizedBox(
        width: MediaQuery.of(context).size.width*.6,
        child: specializations.when(
          data: (data){

            final isSelected = selectedSpecialization != Settings.defaultSpecializationKey;

            final button = OutlinedButton(
              onPressed: () => _searchController.openView(),
              child: Text(
                isSelected?
                  data.entries.singleWhere((element) =>
                    element.key==selectedSpecialization
                ).value:
                titleText,
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
              child: SearchAnchor(
                searchController: _searchController,
                isFullScreen: defaultTargetPlatform.isMobile(), // todo make it react to screen size on web
                viewHintText: titleText,
                builder: (context, controller) => button,
                suggestionsBuilder: (context, controller){
                  final text = controller.text;
                  final filtered = data.entries.where((element) =>
                    element.value.toLowerCase().contains(text.toLowerCase())
                  );
                  if(filtered.isEmpty) {
                    return List.filled(1,
                      Text(L10n.of(context).no_matches_found, textAlign: TextAlign.center)
                    );
                  }
                  return (text.isNotEmpty? filtered : data.entries).map((e) =>
                    ListTile(
                      title: Text(e.value),
                      onTap: (){
                        ref.read(SettingsProvider.instance.notifier).changeSpecialization(
                          data.entries.firstWhere((element) => element.value==e.value).key
                        );
                        controller.closeView('');
                      },
                    )
                  );
                },
              ),
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
      ),
    );
  }

}