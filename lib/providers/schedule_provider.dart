import 'dart:async';

import 'package:ezak/model/course.dart';
import 'package:ezak/db/cache_db.dart';
import 'package:ezak/model/group.dart';
import 'package:ezak/pages/schedule_page.dart';
import 'package:ezak/providers/displayed_date_provider.dart';
import 'package:ezak/providers/settings_provider.dart';
import 'package:ezak/rest/rest_api.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart';
import 'package:http/retry.dart';

typedef Schedule = ({List<DateTime> dates, Map<DateTime, List<Course>> courses, Map<Group, int> maxGroups});

class ScheduleProvider extends AsyncNotifier<Schedule>{

  static final instance = AsyncNotifierProvider<ScheduleProvider, Schedule>(ScheduleProvider.new);

  /// [forceAutoUpdates] allows checking for updates even with them disabled
  /// [forceDownload] forces build to always download schedule
  @override
  Future<Schedule> build({forceAutoUpdates=false, forceDownload=false}) async{
    final db = ref.watch(CacheDb.instance);
    final isLecturer = ref.watch(SettingsProvider.instance.select((value) => value.isLecturer));
    final key = ref.watch(SettingsProvider.key);
    final autoUpdates = ref.watch(SettingsProvider.autoUpdates);
    final isSettingsCompleted = ref.watch(SettingsProvider.completed);
    if(!isSettingsCompleted) return (dates: <DateTime>[], courses: <DateTime, List<Course>>{}, maxGroups: <Group, int>{});
    final assignment = await db.getAssignment(key: key, isLecturer: isLecturer);
    final isCached = assignment != null;
    final client = RetryClient(Client());

    if(!isCached){
      debugPrint("Downloading Schedule...");

      final (courses, dates) = await (
        PansRestApi.fetchCourses(httpClient: client, isLecturer: isLecturer, key: key),
        PansRestApi.fetchCoursesDates(httpClient: client, isLecturer: isLecturer, key: key)
      ).wait;

      await db.addSchedule(key: key, isLecturer: isLecturer, courses: courses, coursesDates: dates);
    }else if(forceDownload){
      final (courses, dates) = await (
        PansRestApi.fetchCourses(httpClient: client, isLecturer: isLecturer, key: key),
        PansRestApi.fetchCoursesDates(httpClient: client, isLecturer: isLecturer, key: key)
      ).wait;
      await db.updateSchedule(key: key, isLecturer: isLecturer, courses: courses, coursesDates: dates);
    }else if(forceAutoUpdates? true : autoUpdates){
      debugPrint("Schedule was cached before");

      DateTime? fetchedUpdateDate;
      try {
        fetchedUpdateDate = await PansRestApi.fetchUpdateDate(httpClient: client, key: key);
      }catch(e){
        debugPrint("No internet connection");
      }
      if(fetchedUpdateDate!=null){
        if(assignment.lastUpdate.isBefore(fetchedUpdateDate)){
          debugPrint("Downloading update...");
          final (courses, dates) = await (
          PansRestApi.fetchCourses(httpClient: client, isLecturer: isLecturer, key: key),
          PansRestApi.fetchCoursesDates(httpClient: client, isLecturer: isLecturer, key: key)
          ).wait;
          await db.updateSchedule(key: key, isLecturer: isLecturer, courses: courses, coursesDates: dates);
        } else {
          debugPrint("No update detected");
        }
      }
    }
    client.close();
    final maxGroups = await db.getMaxGroups(key: key, isLecturer: isLecturer);
    final scheduleGroups = maxGroups.keys;
    final groups = {... ref.watch(SettingsProvider.groups)}..removeWhere((key, value) => !scheduleGroups.contains(key));
    final allDates = await db.getDates(key: key, isLecturer: isLecturer, groups: groups);
    final date = getInitialDate(allDates);
    final initialDates = getDatesAround(allDates, currentDate: date);

    SchedulePage.pageController = PageController(initialPage: allDates.indexOf(date));

    final courses = await db.getCourses(key: key, isLecturer: isLecturer, groups: groups, dates: initialDates);
    ref.read(displayedDate.notifier).change(date);

    debugPrint(courses.toString());
    return (dates: allDates, courses: courses, maxGroups: maxGroups);
  }

  Future<void> loadCourses(DateTime date) async {
    final db = ref.read(CacheDb.instance);
    final key = ref.read(SettingsProvider.key);
    final isLecturer = ref.read(SettingsProvider.instance.select((value) => value.isLecturer));
    // filter schedule only by groups it contains
    final groups = {... ref.watch(SettingsProvider.groups)}..removeWhere((key, value) => !state.value!.maxGroups.keys.contains(key));
    final datesToLoad = getDatesAround(state.value!.dates, currentDate: date)
      .where((d) => !state.value!.courses.keys.contains(d))
      .toList();
    if(datesToLoad.isEmpty) return;
    debugPrint("Loading courses for $datesToLoad");
    final current = state.value;

    final courses = await db.getCourses(key: key, isLecturer: isLecturer, groups: groups, dates: datesToLoad);

    state = AsyncValue.data(
      current!..courses.addAll(courses)
    );
  }

  Future<void> removeCourses({bool? isLecturer, int? key})async {
    ref.read(CacheDb.instance).removeSchedules(ref); // todo add possibility to remove specific schedule
    ref.read(SettingsProvider.instance.notifier).resetKeys();
  }

}