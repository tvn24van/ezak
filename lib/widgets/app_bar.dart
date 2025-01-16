import 'package:ezak/utils/constants.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter/material.dart';

final class PansAppBar extends AppBar{

  PansAppBar({
    super.key,
    required BuildContext context,

    /// Leading param which fallback to PANS logo
    Widget? pansLeading,
    /// Leading text showed right to Logo
    String? leadingText,
    /// Widgets which will be displayed before default ones
    List<Widget> additionalActions=const[],
    /// Items displayed in popup button
    List<PopupMenuItem> popupItems=const[],
  }):super(
    leading: pansLeading ?? Container(
      padding: EdgeInsets.only(top: 1, bottom: 1),
      child: SvgPicture.asset('assets/logotypes/crest.svg')
    ),
    title: Text(leadingText ?? Constants.appName),
    backgroundColor: Theme.of(context).scaffoldBackgroundColor,
    titleSpacing: 0,
    actions: additionalActions+[
      Builder(builder: (context) => IconButton(
        icon: Icon(Icons.adaptive.more),
        onPressed: () => Scaffold.of(context).openEndDrawer(),
      ))
    ],
  );

}