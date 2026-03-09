import 'dart:convert';

import 'package:ezak/model/course.dart';
import 'package:ezak/model/course_date.dart';
import 'package:ezak/utils/constants.dart';
import 'package:ezak/utils/extensions.dart';
import 'package:http/http.dart';

class PansRestApi{

  static Future<DateTime> fetchUpdateDate({
    required Client httpClient,
    required bool isLecturer,
    required int key
  })async{
    final response = await httpClient.get(
      Constants.restUrl.replace(
        path: 'rest/kalendarz${isLecturer?'prowadzacy':''}',
        queryParameters: {isLecturer?'jegoid':'wytrych': '$key'}
      )
    );

    return DateTime.parse(response.body);
  }

  static Future<String> fetchCurrentSemester({
    required Client httpClient
  })async{
    final response = await httpClient.get(
      Constants.restUrl.replace(
        path: 'rest/baza'
      )
    );
    return response.body;
  }

  static Future<Map<int, String>> fetchKeys({
    required Client httpClient,
    required bool isLecturer
  })async{
    final response = await httpClient.get(
      Constants.restUrl.replace(path: 'rest/${isLecturer?'prowadzacy':'wytrych'}')
    );
    final Iterable json = jsonDecode(utf8.decode(response.bodyBytes));

    return {for (var i in json) i['id']: i[isLecturer? 'skrot' : 'pelna_nazwa']};
  }

  static Future<List<Course>> fetchCourses({
    required Client httpClient,
    required bool isLecturer,
    required int key
  })async{
    final response = await httpClient.get(
      Constants.restUrl.replace(
        path: 'rest/kursy${isLecturer? 'prowadzacy':''}',
        queryParameters: {isLecturer?'jegoid':'wytrych': '$key'}
      )
    );
    if(!response.contentType!.contains('application/json')) {
      return List<Course>.empty();
    }
    final Iterable json = jsonDecode(utf8.decode(response.bodyBytes));

    return List<Course>.from(json.map((courseJson)=> Course.fromJson(courseJson)));
  }

  static Future<List<CourseDate>> fetchCoursesDates({
    required Client httpClient,
    required bool isLecturer,
    required int key
  })async{
    final response = await httpClient.get(
      Constants.restUrl.replace(
        path: 'rest/daty${isLecturer? 'prowadzacy':''}',
        queryParameters: {isLecturer?'jegoid':'wytrych': '$key'}
      )
    );
    if(!response.contentType!.contains('application/json')) {
      return List<CourseDate>.empty();
    }
    final Iterable json = jsonDecode(utf8.decode(response.bodyBytes));
    final sorted = json.toList()..sort((a,b)=> a['dzien'].compareTo(b['dzien']));

    return List<CourseDate>.from(sorted.map((courseDateJson) => CourseDate.fromJson(courseDateJson)));
  }

}