import 'package:ezak/model/settings.dart';
import 'package:ezak/providers/settings_provider.dart';
import 'package:ezak/providers/keys_provider.dart';
import 'package:ezak/utils/extensions.dart';
import 'package:ezak/l10n/l10n.g.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final class PansSpecializationTile extends ConsumerWidget{
  const PansSpecializationTile({super.key});

  static final _searchController = SearchController();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final specializations = ref.watch(keysProvider);
    final selectedSpecialization = ref.watch(
        SettingsProvider.instance.select((settings) => settings.specializationKey)
    );
    final isTeacher = ref.watch(
        SettingsProvider.instance.select((settings) => settings.isLecturer)
    );
    final titleText = isTeacher?
      L10n.of(context).lecturer:
      L10n.of(context).specialization;

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

            return SearchAnchor(
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
                        ref.read(SettingsProvider.instance.notifier).changeSpecializationKey(
                            data.entries.firstWhere((element) => element.value==e.value).key
                        );
                        controller.closeView('');
                      },
                    )
                );
              },
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