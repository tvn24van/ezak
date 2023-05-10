import 'package:ezak/utils/constants.dart';
import 'package:ezak/widgets/popup_button.dart';
import 'package:ezak/widgets/theme_button.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter/material.dart';

class PansAppBar extends AppBar{

  final BuildContext context;

  /// Leading param which fallback to PANS logo
  final Widget? pansLeading;

  /// Widgets which will be displayed before default ones
  final List<Widget> additionalActions;

  // Items displayed in popup button
  final List<PopupMenuItem> popupItems;

  PansAppBar(this.context, {
    super.key,
    this.pansLeading,
    this.additionalActions=const[],
    this.popupItems=const[]
  }):super(
    leading: pansLeading ?? SvgPicture.asset('assets/logotypes/crest.svg'),
    title: const Text(Constants.appName),
    backgroundColor: Theme.of(context).scaffoldBackgroundColor,
    titleSpacing: 0,
    actions: additionalActions + [
      const PansThemeButton(),
      PansPopupButton(
        items: popupItems,
      ),
    ],
  );

}