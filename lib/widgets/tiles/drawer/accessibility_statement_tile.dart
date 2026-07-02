import 'package:ezak/l10n/l10n.g.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_widget_from_html_core/flutter_widget_from_html_core.dart';
import 'package:url_launcher/url_launcher.dart';

class PansAccessibilityTile extends StatelessWidget {
  const PansAccessibilityTile({super.key});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: const Icon(Icons.accessibility),
      title: Text(L10n.of(context).accessibility_statement),
      onTap: () async{
        final html = await rootBundle.loadString('assets/accessibility_statement.html');
        if (!context.mounted) return;

        showDialog(
          context: context,
          builder: (context) => Dialog.fullscreen(
            child: Scaffold(
              body: CustomScrollView(
                slivers: [
                  SliverAppBar(
                    pinned: true,
                    expandedHeight: 150.0,
                    leading: const CloseButton(),
                    flexibleSpace: FlexibleSpaceBar(
                      title: Text(L10n.of(context).accessibility_statement),
                      expandedTitleScale: 1,
                      centerTitle: false,
                    ),
                  ),
                  SliverToBoxAdapter(
                    child: Padding(
                      padding: const EdgeInsets.all(20),
                      child: HtmlWidget(
                        html,
                        onTapUrl: (url) => launchUrl(Uri.parse(url)),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      }
    );
  }
}
