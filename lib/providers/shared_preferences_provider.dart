import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

final sharedPreferences = Provider<SharedPreferences>((_)=>
  throw UnimplementedError('Shared Preferences wasn\'t initialized.')
);