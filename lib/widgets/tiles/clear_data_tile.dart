import 'package:ezak/l10n/l10n.g.dart';
import 'package:flutter/material.dart';

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
              TextButton(
                onPressed: () async=> {}, // todo implement clearing
                child: Text(MaterialLocalizations.of(context).okButtonLabel)
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