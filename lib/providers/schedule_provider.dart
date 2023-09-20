import 'dart:async';

import 'package:ezak/model/loaders/schedule_loader.dart';
import 'package:ezak/model/schedule.dart';
import 'package:ezak/pages/schedule_page.dart';
import 'package:ezak/providers/settings_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:time/time.dart';

class ScheduleProvider extends AsyncNotifier<Schedule>{
  static final instance = AsyncNotifierProvider<ScheduleProvider, Schedule>((){
    return ScheduleProvider();
  });

  Future<Schedule> load() async{ //todo refactor
    final key = ref.watch(SettingsProvider.instance.select((settings) => settings.specializationKey));
    final isTeacher = ref.watch(SettingsProvider.instance.select((settings)=> settings.isTeacher));

    Iterable<Future<dynamic>> futures;

    if(await ScheduleLoader.dataExists(isTeacher, key)){
      final downloadDate = await ScheduleLoader.getDownloadDate(isTeacher, key);
      final updateDate = await ScheduleLoader.getUpdateDate(isTeacher, key).catchError((e)=>
        downloadDate.subtract(1.seconds) //hack, if no internet connection
      );

      if(updateDate.isBefore(downloadDate)) {
        futures = [ // loading
          ScheduleLoader.loadDates(isTeacher, key),
          ScheduleLoader.loadCourses(isTeacher, key)
        ];
      }else {
        futures = [ // updating
          ScheduleLoader.downloadAndSaveDates(isTeacher, key),
          ScheduleLoader.downloadAndSaveCourses(isTeacher, key)
        ];
      }
    }else{
      futures = [ // downloading
        ScheduleLoader.downloadAndSaveDates(isTeacher, key),
        ScheduleLoader.downloadAndSaveCourses(isTeacher, key)
      ];
    }

    final values = await Future.wait(futures);
    return Schedule(values.first as DatesMap, values.last as CoursesList);
  }

  @override
  Future<Schedule> build() async{
    final schedule = await load()
      ..filter(ref.read(SettingsProvider.instance).groups);

    final accurateDate = schedule.getAccurateDate();

    ref.read(SchedulePage.currentDate.notifier).update((state) => accurateDate);

    ref.read(SchedulePage.pageViewController.notifier).update((state) =>
      PageController(initialPage: schedule.getIndexOfDate(accurateDate))
    );

    return schedule;
  }

  Future<void> redownload() async{
    final key = ref.read(SettingsProvider.instance.select((settings) => settings.specializationKey));
    final isTeacher = ref.read(SettingsProvider.instance.select((settings)=> settings.isTeacher));
    state = const AsyncValue.loading();

    state = await AsyncValue.guard(() async {
      final values = await Future.wait([
        ScheduleLoader.downloadAndSaveDates(isTeacher, key),
        ScheduleLoader.downloadAndSaveCourses(isTeacher, key)
      ]);
      return Schedule(values.first as DatesMap, values.last as CoursesList)
        ..filter(ref.read(SettingsProvider.instance).groups);
    });

  }

}