import 'package:ezak/l10n/l10n.g.dart';
import 'package:ezak/providers/settings_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HighContrastTile extends ConsumerWidget {
  const HighContrastTile({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final highContrast = ref.watch(SettingsProvider.instance.select((s) => s.highContrast));
    
    return ListTile(
      leading: Icon(Icons.contrast),
      title: Text(L10n.of(context).high_contrast),
      trailing: Switch(
        value: highContrast,
        onChanged: (_) => ref.read(SettingsProvider.instance.notifier).toggleHighContrast(),
      ),
      onTap: (){},
    );
  }
}