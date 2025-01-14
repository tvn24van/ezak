import 'package:ezak/model/settings.dart';
import 'package:ezak/providers/settings_provider.dart';
import 'package:ezak/providers/keys_provider.dart';
import 'package:ezak/utils/extensions.dart';
import 'package:ezak/l10n/l10n.g.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final class PansKeysTile extends ConsumerWidget{
  const PansKeysTile({super.key});

  static final _searchController = SearchController();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final key = ref.watch(SettingsProvider.key);
    final isLecturer = ref.watch(
        SettingsProvider.instance.select((settings) => settings.isLecturer)
    );
    final specializations = ref.watch(keysProvider(isLecturer));
    final titleText = isLecturer?
      L10n.of(context).lecturer:
      L10n.of(context).specialization;
    final buttonText = isLecturer?
      L10n.of(context).select_lecturer:
      L10n.of(context).choose_specialization;

    return ListTile(
      title: Text(titleText),
      leading: const Icon(Icons.person_search),
      onTap: (){},
      trailing: SizedBox(
        width: MediaQuery.of(context).size.width*.6,
        child: specializations.when(
          data: (data){

            final isSelected = key != Settings.defaultKey;

            final button = OutlinedButton(
              onPressed: () => _searchController.openView(),
              child: Text(
                isSelected?
                  data.entries.singleWhere((element) =>
                    element.key==key
                ).value:
                buttonText,
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
                      ref.read(SettingsProvider.instance.notifier).changeKey(
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