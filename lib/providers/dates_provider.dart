import 'package:ezak/db/cache_db.dart';
import 'package:ezak/providers/settings_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final datesProvider = FutureProvider<List<DateTime>>((ref) async {
  final db = ref.watch(CacheDb.instance);
  final isLecturer = ref.watch(SettingsProvider.isLecturer);
  final key = ref.watch(SettingsProvider.key);
  final groups = ref.watch(SettingsProvider.groups);

  return db.getDates(key: key, isLecturer: isLecturer, groups: groups);
});