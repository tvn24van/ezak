import 'dart:io';
import 'dart:ui';

import 'package:ezak/model/course.dart';
import 'package:ezak/model/schedule.dart';
import 'package:intl/intl.dart';
import 'package:time/time.dart';

extension PlatformExtensions on Platform{
  static bool isMobile(){
    return Platform.isAndroid || Platform.isFuchsia || Platform.isIOS;
  }
}

extension DateTimeExtension on DateTime{
  String toLocaleString(Locale locale){
    return DateFormat.yMd(locale.languageCode).format(this);
  }

  int get weekOfMonth {
    int sum = firstDayOfMonth.weekday - 1 + day;
    if (sum % 7 == 0) {
      return sum ~/ 7;
    } else {
      return sum ~/ 7 + 1;
    }
  }
}

extension DurationToHour on Duration{
  String formatTime(){
    final whole = '$this'.split('.')[0].padLeft(8, '0');
    return whole.substring(0, whole.length-3);
  }
}

extension JsonToCoursesList on Iterable{
  CoursesList toCoursesList(){
    return List<Course>.from(map((model) => Course.fromJson(model)));
  }
}

extension JsonToDatesMap on Iterable{
  DatesMap toDatesMap(){
    return fold({}, (map, item) =>
      map..putIfAbsent(DateTime.parse(item['dzien']), () => []).add(item['pk'])
    );
  }
}