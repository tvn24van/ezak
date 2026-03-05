import 'package:ezak/db/cache_db.dart';
import 'package:ezak/model/course.dart';
import 'package:ezak/providers/settings_provider.dart';
import 'package:ezak/utils/extensions.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final coursesProvider = StreamProvider.autoDispose.family<List<Course>, DateTime>((ref, date) async* {
  final db = ref.watch(CacheDb.instance);
  final key = ref.watch(SettingsProvider.key);
  final isLecturer = ref.watch(SettingsProvider.isLecturer);
  final groups = await ref.watch(SettingsProvider.groupsInfluencingCurrentSchedule.future);
  ref.cacheFor(const Duration(minutes: 1));

  yield* db.getCoursesStream(key: key, isLecturer: isLecturer, groups: groups, date: date);
});
