import 'dart:ui';

import 'package:ezak/utils/extensions.dart';

final class Constants{
  static String appName = DateTime.now().isAprilFoolsDay? 'leŻak Nysa' : 'eŻak Nysa';

  static final restUrl = Uri.https('mobile.pwsz.nysa.pl');

  static final github = Uri.https('github.com', '/tvn24van/ezak');

  static final supportMail = Uri( // todo add app version to this mail
      scheme: 'mailto',
      path: 'ezaknysa@gmail.com',
      queryParameters: {
        'subject': 'Help/Idea',
        'body': 'Please change mail subject depending on your intentions'
      },
  );

  static final pansWebsite = Uri.https('pans.nysa.pl');

  static const defaultLocale = Locale('pl');

}