import 'dart:ui';

import 'package:ezak/utils/extensions.dart';

final class Constants{
  static final appName = DateTime.now().isAprilFoolsDay? 'leŻak Nysa' : 'eŻak Nysa';

  static final restUrl = Uri.https('mobile.pwsz.nysa.pl');

  static final githubUrl = Uri.https('github.com', '/tvn24van/ezak');

  static final webAppUrl = Uri.https("ezak.pages.dev");

  static final supportMail = Uri( // todo add app version mail subject
      scheme: 'mailto',
      path: 'ezaknysa@gmail.com',
      queryParameters: {
        'subject': 'Help/Idea',
        'body': 'Please change mail subject depending on your intentions'
      },
  );

  static final pansWebsiteUrl = Uri.https('pans.nysa.pl');

  static const defaultLocale = Locale('pl');
  static const englishLocale = Locale('en');

}