import 'package:ezak/providers/settings_provider.dart';
import 'package:ezak/utils/l10n/l10n.g.dart';
import 'package:ezak/utils/l10n/l10n_en.g.dart';
import 'package:ezak/utils/l10n/l10n_pl.g.dart';
import 'package:ezak/visuals/appereance.dart';
import 'package:feature_discovery/feature_discovery.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final class PansLanguageTile extends ConsumerWidget{
  const PansLanguageTile({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentLocale = ref.watch(
        SettingsProvider.instance.select((settings) => settings.locale)
    );

    final dropdown = DropdownButton<Locale>(
      value: currentLocale,
      items: L10n.supportedLocales.map((locale) =>
        DropdownMenuItem(
          value: locale,
          enabled: currentLocale != locale,
          child: Text(locale.languageCode),
        )
      ).toList(),
      onChanged: (locale){
        if(locale == null) {
          return;
        }
        ref.read(SettingsProvider.instance.notifier)
          .changeLocale(locale);
      },
    );

    return ListTile(
      title: Text(L10n.of(context).language),
      leading: const Icon(Icons.language),
      onTap: (){},
      trailing: DescribedFeatureOverlay(
        featureId: "language",
        title: Text(L10nPl().change_language_if_you_like),
        description: Text(L10nEn().change_language_if_you_like),
        backgroundColor: PansAppereance.colors.red,
        targetColor: Theme.of(context).canvasColor,
        openDuration: Duration.zero,
        contentLocation: ContentLocation.below,
        tapTarget: FittedBox(
          fit: BoxFit.scaleDown,
          child: AbsorbPointer(
            absorbing: true,
            child: dropdown,
          ),
        ),
        child: dropdown,
      ),
    );
  }

}