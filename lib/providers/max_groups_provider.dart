import 'package:ezak/db/cache_db.dart';
import 'package:ezak/providers/settings_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final maxGroupsProvider = FutureProvider((ref){
  final db = ref.watch(CacheDb.instance);
  final isLecturer = ref.watch(SettingsProvider.instance.select((value) => value.isLecturer));
  final key = ref.watch(SettingsProvider.key);

  return db.getMaxGroups(key: key, isLecturer: isLecturer);
});