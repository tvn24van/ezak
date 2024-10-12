import 'dart:convert';

import 'package:ezak/db/cache_db.dart';
import 'package:ezak/model/course.dart';
import 'package:ezak/utils/constants.dart';
import 'package:http/http.dart' as http;

class PansRestApi{

  static Future<DateTime> fetchUpdateDate({
    required http.Client httpClient,
    required int key
  })async{
    final response = await httpClient.get(
      Constants.restUrl.replace(
        path: 'rest/kalendarz',
        queryParameters: {'wytrych': key}
      )
    );

    return DateTime.parse(response.body);
  }

  static Future<Map<int, String>> fetchKeys({
    required http.Client httpClient,
    required bool isLecturer
  })async{
    final response = await httpClient.get(
      Constants.restUrl.replace(path: 'rest/${isLecturer?'prowadzacy':'wytrych'}')
    );
    final Iterable json = jsonDecode(utf8.decode(response.bodyBytes));

    return {for (var i in json) i['id']: i[isLecturer? 'skrot' : 'pelna_nazwa']};
  }

  static Future<List<Course>> fetchCourses({
    required http.Client httpClient,
    required bool isLecturer,
    required int key
  })async{
    final response = await httpClient.get(
      Constants.restUrl.replace(
        path: 'rest/kursy${isLecturer? 'prowadzacy':''}',
        queryParameters: {isLecturer?'jegoid':'wytrych': key}
      )
    );
    final Iterable json = jsonDecode(utf8.decode(response.bodyBytes));

    return List<Course>.from(json.map((courseJson)=> Course.fromJson(courseJson)));
  }

  static Future<List<CourseDate>> fetchCoursesDates({
    required http.Client httpClient,
    required bool isLecturer,
    required int key
  })async{
    final response = await httpClient.get(
      Constants.restUrl.replace(
        path: 'rest/daty${isLecturer? 'prowadzacy':''}',
        queryParameters: {isLecturer?'jegoid':'wytrych': key}
      )
    );
    final Iterable json = jsonDecode(utf8.decode(response.bodyBytes));
    final sorted = json.toList()..sort((a,b)=> a['dzien'].compareTo(b['dzien']));

    return List<CourseDate>.from(sorted.map((courseDateJson) => CourseDate.fromJson(courseDateJson)));
  }

}