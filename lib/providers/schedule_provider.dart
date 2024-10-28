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

  @override
  Future<Schedule> build() async{
    final db = ref.watch(CacheDb.instance);
    final isLecturer = ref.watch(SettingsProvider.instance.select((value) => value.isLecturer));
    final key = ref.watch(SettingsProvider.key);
    final groups = ref.watch(SettingsProvider.groups);

    final isCached = await db.isCached(key: key, isLecturer: isLecturer);
    final client = RetryClient(Client(), retries: 2);

    if(!isCached){
      debugPrint("Downloading Schedule...");

      final (courses, dates) = await (
        PansRestApi.fetchCourses(httpClient: client, isLecturer: isLecturer, key: key),
        PansRestApi.fetchCoursesDates(httpClient: client, isLecturer: isLecturer, key: key)
      ).wait;

      await db.addSchedule(key: key, isLecturer: isLecturer, courses: courses, coursesDates: dates);
    }else{
      //todo check if there was update for this schedule
      debugPrint("Schedule was cached before");
    }
    client.close();
    final dates = await db.getDates(key: key, isLecturer: isLecturer, groups: groups);
    final date = getInitialDate(dates);
    ref.read(displayedDate.notifier).state = date;
    SchedulePage.pageController = PageController(initialPage: dates.indexOf(date));

    final courses = await db.getCourses(key: key, isLecturer: isLecturer, groups: groups, date: date);
    final maxGroups = await db.getMaxGroups(key: key, isLecturer: isLecturer);
    return (dates: dates, courses: {date: courses}, maxGroups: maxGroups);
  }

  Future<void> loadCourses(DateTime date) async {
    if(state.value?.courses.containsKey(date) ?? false) return;
    debugPrint("Loading courses for $date");
    final db = ref.read(CacheDb.instance);
    final key = ref.read(SettingsProvider.key);
    final isLecturer = ref.read(SettingsProvider.instance.select((value) => value.isLecturer));
    final groups = ref.read(SettingsProvider.instance.select((value) => value.groups));

    final current = state.value;

    final courses = await db.getCourses(key: key, isLecturer: isLecturer, groups: groups, date: date);
    state = AsyncValue.data(
      current!..courses.putIfAbsent(date, () => courses)
    );
  }

  Future<void> removeCourses({bool? isLecturer, int? key})async {
    ref.read(CacheDb.instance).removeSchedules(ref); // todo add possibility to remove specific schedule
    ref.read(SettingsProvider.instance.notifier).resetKeys();
  }

}