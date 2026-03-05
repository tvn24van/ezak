import 'package:ezak/db/cache_db.dart';
import 'package:ezak/providers/settings_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final maxGroupsProvider = StreamProvider((ref){
  final db = ref.watch(CacheDb.instance);
  final isLecturer = ref.watch(SettingsProvider.isLecturer);
  final key = ref.watch(SettingsProvider.key);

  return db.getMaxGroupsStream(key: key, isLecturer: isLecturer);
});