import 'dart:convert';

import 'package:ezak/model/course.dart';
import 'package:ezak/model/group.dart';
import 'package:ezak/utils/constants.dart';
import 'package:ezak/utils/extensions.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/retry.dart';
import 'package:time/time.dart';
import 'package:http/http.dart' as http;

void main() async {

  final client = RetryClient(http.Client());
  // we will rather use client cos most of time we will download every thing
  // about lesson's plan, so no need to close connection between api queries
  try {
    final response = await client.get(
      Uri.http(Constants.restUrl, 'rest/kursy', {'wytrych': '39'})
    );
    final jsonObject = jsonDecode(utf8.decode(response.bodyBytes)); // server does not sends header specifying Codec, so we need to convert...
    var courses = jsonObject.toCoursesList();
    print(jsonObject.runtimeType);

    final Course firstCourse = courses[0];
    print("${firstCourse.id}, ${firstCourse.name}, ${firstCourse.lecturer}, ${firstCourse.startHour}, ${firstCourse.location}, ${firstCourse.roomNumber}");
    print(firstCourse.group);
    print('There are ${courses.length} courses');

  } finally {
    client.close();
  }

  // var json = {
  //   "rodzaj": "W",
  //   "skrot": "prof. W. Stanisławski",
  //   "czaskursu": 2,
  //   "godzinaod": 2,
  //   "nazwa": "Podstawy Baz Danych",
  //   "numer": 1,
  //   "symbol": "G",
  //   "nrsali": 6,
  //   "id": 1
  // };
  // var course = Course.fromJson(json);
  //
  //
  // test('Start time should be equal to 8:00', () {
  //   expect(course.startHour, 8.hours);
  // });
  //
  // test('Group should be of type W (lecture)', (){
  //   expect(course.group, Group.lecture);
  // });
  //
  // test('Location should be equal to 6G', (){
  //   expect('${course.roomNumber}${course.location}', '6G');
  // });

}