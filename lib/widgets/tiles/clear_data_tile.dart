import 'package:ezak/l10n/l10n.g.dart';
import 'package:ezak/providers/schedule_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final class PansClearDataTile extends StatelessWidget{
  const PansClearDataTile({super.key});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: const Icon(Icons.restore_from_trash),
      title: Text(L10n.of(context).clearing_data),
      subtitle: Text(L10n.of(context).clear_data_description),
      trailing: FilledButton(
        onPressed: ()async=> showAdaptiveDialog(
          context: context,
          builder: (context) => AlertDialog.adaptive(
            title: Text(L10n.of(context).clear_data_confirmation),
            actions: [
              TextButton(
                onPressed: ()=> Navigator.of(context).pop(),
                child: Text(MaterialLocalizations.of(context).cancelButtonLabel)
              ),
              Consumer(builder: (context, ref, child) =>
                TextButton(
                  onPressed: () {
                    ref.read(ScheduleProvider.instance.notifier).removeCourses();
                    Navigator.of(context).pop();
                  },
                  child: Text(MaterialLocalizations.of(context).okButtonLabel)
                )
              )
            ],
          ),
        ),
        child: Text(L10n.of(context).clear_data)
      ),
      onTap: (){},
    );
  }

}