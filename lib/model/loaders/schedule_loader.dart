import 'dart:convert';
import 'dart:io';

import 'package:ezak/model/schedule.dart';
import 'package:ezak/utils/constants.dart';
import 'package:ezak/utils/extensions.dart';
import 'package:ezak/utils/app_dir_utils.dart';
import 'package:http/http.dart' as http;
import 'package:path/path.dart' as p;
import 'package:http/retry.dart';

//todo refactoring
class ScheduleLoader{

  // REST API

  static Future<CoursesList> downloadAndSaveCourses(bool teacherMode, int key) async{
    final client = RetryClient(http.Client());
    final response = await client.get(
      Uri.http(
        Constants.restUrl,
        'rest/kursy${teacherMode? 'prowadzacy':''}',
        {teacherMode?'jegoid':'wytrych': '$key'}
      )
    );

    //saving
    final path = p.join(
      await AppDir.getLocalPath(),
      'data',
      teacherMode?'teacher':'student',
      '$key',
      'courses.json'
    );
    final file = await File(path).create(recursive: true);
    final utf8Encoded = utf8.decode(response.bodyBytes);
    file.writeAsString(utf8Encoded);

    final Iterable json = jsonDecode(utf8Encoded);
    return json.toCoursesList();
  }

  static Future<DatesMap> downloadAndSaveDates(bool teacherMode, int key) async{
    final client = RetryClient(http.Client());
    final response = await client.get(
      Uri.http(
        Constants.restUrl,
        'rest/daty${teacherMode? 'prowadzacy':''}',
        {teacherMode?'jegoid':'wytrych': '$key'}
      )
    );

    final Iterable json = jsonDecode(utf8.decode(response.bodyBytes));
    final sorted = json.toList()..sort((a,b)=> a['dzien'].compareTo(b['dzien']));

    //saving
    final path = p.join(
      await AppDir.getLocalPath(),
      'data',
      teacherMode?'teacher':'student',
      '$key',
      'dates.json'
    );

    final file = await File(path).create(recursive: true);
    file.writeAsString(jsonEncode(sorted));

    return sorted.toDatesMap();
  }

  // LOCAL STORAGE

  static Future<CoursesList> loadCourses(bool teacherMode, int key) async{
    final rawContent = await AppDir.loadFromLocalPath(
      '/data/${teacherMode?'teacher':'student'}/$key/courses.json'
    );
    final Iterable json = jsonDecode(rawContent);

    return json.toCoursesList();
  }

  /// Loads dates for specified [key] from storage
  static Future<DatesMap> loadDates(bool teacherMode, int key) async{
    final rawContent = await AppDir.loadFromLocalPath(
      '/data/${teacherMode?'teacher':'student'}/$key/dates.json'
    );
    final Iterable json = jsonDecode(rawContent);

    return json.toDatesMap();
  }

  static Future<bool> dataExists(bool teacherMode, int key) async{
    final appPath = await AppDir.getLocalPath();
    final coursesPath = p.join(
      appPath,
      'data',
      teacherMode?'teacher':'student',
      '$key',
      'courses.json'
    );
    final datesPath = p.join(
      appPath,
      'data',
      teacherMode?'teacher':'student',
      '$key',
      'dates.json'
    );
    final courses = File(coursesPath);
    final dates = File(datesPath);
    final results = await Future.wait([
      courses.exists(),
      dates.exists()
    ]);
    return results.every((element) => element);
  }

  static Future<DateTime> getUpdateDate(bool teacherMode, int key) async{
    final client = http.Client();
    final response = await client.get(
      Uri.http(
        Constants.restUrl,
        'rest/kalendarz',
        {'wytrych': '$key'}
      )
    );
    return DateTime.parse(response.body);
  }

  static Future<DateTime> getDownloadDate(bool teacherMode, int key) async{
    final appPath = await AppDir.getLocalPath();
    final coursesPath = p.join( //we're checking only for courses because they're downloaded at once
      appPath,
      'data',
      teacherMode?'teacher':'student',
      '$key',
      'courses.json'
    );
    final file = File(coursesPath);
    return file.lastModifiedSync(); //sync is pretended to be faster
  }

}