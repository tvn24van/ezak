import 'dart:async';

import 'package:ezak/db/cache_db.dart';
import 'package:ezak/model/course.dart';
import 'package:ezak/providers/dates_provider.dart';
import 'package:ezak/providers/initial_date_provider.dart';
import 'package:ezak/providers/max_groups_provider.dart';
import 'package:ezak/providers/settings_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

typedef LoadedCourses = Map<DateTime, List<Course>>;

class CoursesProvider extends AsyncNotifier<LoadedCourses>{
  static final instance = AsyncNotifierProvider<CoursesProvider, LoadedCourses>(CoursesProvider.new);

  @override
  Future<Map<DateTime, List<Course>>> build() async {
    final db = ref.watch(CacheDb.instance);
    final key = ref.watch(SettingsProvider.key);
    final isLecturer = ref.watch(SettingsProvider.isLecturer);

    final maxGroups = await ref.watch(maxGroupsProvider.future);
    final groups = {... ref.watch(SettingsProvider.groups)}..removeWhere((key, value) => !maxGroups.keys.contains(key));
    final initialDate = await ref.watch(initialDateProvider.future);
    final datesToLoad = await getDatesAround(initialDate);

    return db.getCourses(key: key, isLecturer: isLecturer, groups: groups, dates: datesToLoad);
  }

  Future<void> loadCourses(DateTime date) async {
    final db = ref.read(CacheDb.instance);
    final key = ref.read(SettingsProvider.key);
    final isLecturer = ref.read(SettingsProvider.instance.select((value) => value.isLecturer));

    final maxGroups = await ref.read(maxGroupsProvider.future);
    // filter schedule only by groups it contains
    final groups = {... ref.read(SettingsProvider.groups)}..removeWhere((key, value) => !maxGroups.keys.contains(key));
    final datesToLoad = (await getDatesAround(date))
        .where((d) => !state.value!.keys.contains(d))
        .toList();

    if(datesToLoad.isEmpty) return;

    final courses = await db.getCourses(key: key, isLecturer: isLecturer, groups: groups, dates: datesToLoad);
    debugPrint("Loading courses for $datesToLoad");

    state = AsyncValue.data(
        {...state.value!}..addAll(courses)
    );
  }

  Future<List<DateTime>> getDatesAround(DateTime date) async{ //it doesn't fit here
    final allDates = await ref.read(datesProvider.future);
    final dateIndex = allDates.indexOf(date);
    final indexes = [dateIndex-1, dateIndex, dateIndex+1].where((e) => e>=0 && e<allDates.length);
    return allDates.asMap().entries
        .where((e) => indexes.contains(e.key))
        .map((e) => e.value)
        .toList();
  }

}