import 'dart:ui';

import 'package:ezak/utils/extensions.dart';

final class Constants{
  static final appName = DateTime.now().isAprilFoolsDay? 'leŻak Nysa' : 'eŻak Nysa';

  static final restUrl = Uri.https('mobile.pwsz.nysa.pl');

  static final githubUrl = Uri.https('github.com', '/tvn24van/ezak');

  static final webAppUrl = Uri.https('ezak.pages.dev');

  static final googlePlayUrl = Uri.https('play.google.com', '/store/apps/details', {'id': 'pl.tvn24van.ezak'});

  static final videoClip = Uri.https('youtube.com', '/watch', {'v': 'zYQOpCfCOxI'});

  static final supportMail = Uri( // todo add app version mail subject
      scheme: 'mailto',
      path: 'ezaknysa@gmail.com',
  );

  static final pansWebsiteUrl = Uri.https('pans.nysa.pl');
  static final pansElearningUrl = Uri.https('elearning.pans.nysa.pl');

  static const defaultLocale = Locale('pl');
  static const englishLocale = Locale('en');

}