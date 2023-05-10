import 'dart:convert';
import 'package:ezak/model/course.dart';
import 'package:ezak/utils/constants.dart';
import 'package:http/retry.dart';
import 'package:http/http.dart' as http;

void main() async {

  final client = RetryClient(http.Client());

  try {
    final coursesResponse = await client.get( // should we really deserialize every course or just let them each wait for their time
        Uri.http(Constants.restUrl, 'rest/kursy', {'wytrych': '39'})
    );
    Iterable coursesJsonObject = jsonDecode(utf8.decode(coursesResponse.bodyBytes));
    List<Course> courses = List<Course>.from(coursesJsonObject.map((model) => Course.fromJson(model)));

    final response = await client.get(
        Uri.http(Constants.restUrl, 'rest/daty', {'wytrych': '39'})
    );

    Iterable datesJsonObject = jsonDecode(utf8.decode(response.bodyBytes));
    var transformed = datesJsonObject.fold(
        <String,List<int>>{}, (map, item) =>
          map..putIfAbsent(item['dzien'], () => []).add(item['pk'])
    );

    for(int courseId in transformed['2023-01-27']!){
      final Course selected = courses.firstWhere((element) => element.id == courseId);
      print("${selected.id}, ${selected.name}, ${selected.lecturer}, ${selected.startHour}, ${selected.location}, ${selected.roomNumber}");
      print(selected.group.symbol);
    }

    print('There are ${courses.length} courses');

  } finally {
    client.close();
  }

  assert(true); // ;)
}