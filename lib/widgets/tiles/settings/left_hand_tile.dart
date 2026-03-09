import 'package:ezak/l10n/l10n.g.dart';
import 'package:ezak/providers/settings_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class LeftHandModeTile extends ConsumerWidget {
  const LeftHandModeTile({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final leftHandMode = ref.watch(SettingsProvider.instance.select((s) => s.leftHandMode));
    return ListTile(
      leading: Icon(Icons.waving_hand),
      title: Text(L10n.of(context).layout_for_lefthanded),
      trailing: Switch(
        value: leftHandMode,
        onChanged: (_) => ref.read(SettingsProvider.instance.notifier).toggleLeftHandMode(),
      ),
      onTap: (){},
    );
  }
}
