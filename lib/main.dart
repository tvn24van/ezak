import 'package:ezak/providers/shared_preferences_provider.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_web_plugins/url_strategy.dart';

import 'app.dart';

void main() async{
  final widgetsBinding = WidgetsFlutterBinding.ensureInitialized();

  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  SharedPreferences.setPrefix('');

  usePathUrlStrategy();
  runApp( ProviderScope(
    overrides: [
      sharedPreferences.overrideWithValue(
        await SharedPreferences.getInstance()
      )
    ],
    child: const PansApp()
  ));

  FlutterNativeSplash.remove();

}
