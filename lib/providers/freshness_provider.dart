import 'dart:async';

import 'package:ezak/db/cache_db.dart';
import 'package:ezak/providers/http_client_provider.dart';
import 'package:ezak/providers/settings_provider.dart';
import 'package:ezak/rest/rest_api.dart';
import 'package:ezak/utils/print.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart';

typedef Freshness = ({FreshnessState state, DateTime lastCheck});

enum FreshnessState{
  /// Theres no data, schedule may needs to be downloaded for the first time
  noData,
  /// Validating freshness in progress
  checking,
  /// There's a still valid data, or was just downloaded
  fresh,
  /// There's a need to download newest data
  old,
  /// Data is being downloaded right now
  fetching,
  /// User chooses not to check if there's newer data
  unknown;

}

/// Keeps cached schedules up to date
class FreshnessProvider extends Notifier<Freshness> {
  static final instance = NotifierProvider(FreshnessProvider.new);

  Future<void>? _syncTask;

  @override
  Freshness build() {
    ref.watch(clientProvider(null));
    final isCompleted = ref.watch(SettingsProvider.completed);
    ref.watch(SettingsProvider.key);

    if (isCompleted) {
      Future.microtask(() => checkForUpdate());
    }

    return (state: FreshnessState.unknown, lastCheck: DateTime.now());
  }
  
  Future<void> checkForUpdate({bool forceDownload = false}) {
    if (_syncTask != null) return _syncTask!;
    _syncTask = _checkForUpdate(forceDownload).whenComplete(() => _syncTask = null);
    return _syncTask!;
  }

  Future<void> _checkForUpdate(bool force) async {
    debugOnlyPrint("Started checking for updates");
    final db = ref.read(CacheDb.instance);
    final key = ref.read(SettingsProvider.key);
    final isLecturer = ref.read(SettingsProvider.isLecturer);
    
    final client = ref.read(clientProvider(null));

    try {
      final (assignment, currentSemester) = await (
        db.getAssignment(key: key, isLecturer: isLecturer),
        db.getLastSemester()
      ).wait;

      if (assignment == null) {
        state = (state: FreshnessState.checking, lastCheck: DateTime.now());
        debugOnlyPrint("Downloading schedule...");

        final (_, semesterMark) = await (
          _fetchAndSaveSchedule(client, db, key, isLecturer, isUpdate: false),
          PansRestApi.fetchCurrentSemester(httpClient: client)
        ).wait;

        if (currentSemester == null) {
          await db.addSemester(semesterMark);
        }
        state = (state: FreshnessState.fresh, lastCheck: DateTime.now());
        return;
      }

      state = (state: FreshnessState.checking, lastCheck: DateTime.now());

      final apiSemesterMark = await PansRestApi.fetchCurrentSemester(httpClient: client);
      if (currentSemester != null && currentSemester.mark != apiSemesterMark) {
        debugOnlyPrint("New semester, clearing data");
        await clearData(newSemesterMark: apiSemesterMark);
        state = (state: FreshnessState.noData, lastCheck: DateTime.now());
        return;
      }

      final lastUpdate = await PansRestApi.fetchUpdateDate(httpClient: client, key: key);
      if (assignment.lastUpdate.isBefore(lastUpdate) || force) {
        debugOnlyPrint("Downloading update${force?' (by force)':''}");
        state = (state: FreshnessState.fetching, lastCheck: DateTime.now());
        await _fetchAndSaveSchedule(client, db, key, isLecturer, isUpdate: true);
      }

      state = (state: FreshnessState.fresh, lastCheck: DateTime.now());
    } catch (e) {
      debugOnlyPrint("Error occured while checking for update: $e");
      state = (state: FreshnessState.unknown, lastCheck: DateTime.now());
    }
  }


  Future<void> _fetchAndSaveSchedule(
    Client client, CacheDb db, int key, bool isLecturer, {required bool isUpdate}
  ) async {
    final (courses, dates) = await (
      PansRestApi.fetchCourses(httpClient: client, isLecturer: isLecturer, key: key),
      PansRestApi.fetchCoursesDates(httpClient: client, isLecturer: isLecturer, key: key)
    ).wait;

    if (isUpdate) {
      await db.updateSchedule(key: key, isLecturer: isLecturer, courses: courses, coursesDates: dates);
    } else {
      await db.addSchedule(key: key, isLecturer: isLecturer, courses: courses, coursesDates: dates);
    }
  }

  Future<void> clearData({String? newSemesterMark}) async {
    final db = ref.read(CacheDb.instance);
    await db.removeSemester();
    await db.removeSchedules(ref);
    ref.read(SettingsProvider.instance.notifier).resetKeys();
    if (newSemesterMark != null) {
      await db.addSemester(newSemesterMark);
    }
  }
}