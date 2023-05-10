import 'dart:ui';

import 'package:ezak/model/course.dart';
import 'package:ezak/model/schedule.dart';
import 'package:intl/intl.dart';

extension DateTimeSerializer on DateTime{
  String toLocaleString(Locale locale){
    return DateFormat.yMd(locale.languageCode).format(this);
  }
}

extension DurationToHour on Duration{
  String toPansString(){
    final whole = '$this'.split('.')[0].padLeft(8, '0');
    return whole.substring(0, whole.length-3);
    // return DateFormat.
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

// extension JsonToDatesMap on List<dynamic>{
//   DatesMap toDatesMap(){
//     return fold(
//       <DateTime, List<int>>{}, (map, item) =>
//         map..putIfAbsent(DateTime.parse(item['dzien']), () => []).add(item['pk'])
//     );
//   }
// }