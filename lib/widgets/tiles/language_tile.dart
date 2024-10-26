import 'package:ezak/providers/settings_provider.dart';
import 'package:ezak/l10n/l10n.g.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final class PansLanguageTile extends ConsumerWidget{
  const PansLanguageTile({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentLocale = ref.watch(
        SettingsProvider.instance.select((settings) => settings.locale)
    );

    return ListTile(
      title: Text.rich(TextSpan(
        children: [
          TextSpan(text: L10n.of(context).language),
          TextSpan(text: " "),
          TextSpan(text: "(Language)", style: TextStyle(fontStyle: FontStyle.italic))
        ]
      )),
      leading: const Icon(Icons.language),
      onTap: (){},
      trailing: DropdownButton<Locale>(
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
        underline: const SizedBox.shrink(),
      ),
    );
  }

}