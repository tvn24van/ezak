import 'package:ezak/providers/shared_preferences_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_web_plugins/url_strategy.dart';

import 'app.dart';

void main() async{
  SharedPreferences.setPrefix('');
  WidgetsFlutterBinding.ensureInitialized();
  usePathUrlStrategy();
  runApp( ProviderScope(
    overrides: [
      sharedPreferences.overrideWithValue(
        await SharedPreferences.getInstance()
      )
    ],
    child: const PansApp()
  ));

}
