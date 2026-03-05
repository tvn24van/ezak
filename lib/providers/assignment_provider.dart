import 'package:ezak/db/cache_db.dart';
import 'package:ezak/providers/settings_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final assignmentProvider = StreamProvider((ref) {
  final db = ref.watch(CacheDb.instance);
  final key = ref.watch(SettingsProvider.key);
  final isLecturer = ref.watch(SettingsProvider.isLecturer);
  return db.getAssignmentStream(key: key, isLecturer: isLecturer);
});

final lastScheduleUpdateDate = FutureProvider((ref) => ref.watch(assignmentProvider.selectAsync((a) => a?.lastUpdate)));