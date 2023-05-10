import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:ezak/utils/constants.dart';
import 'package:http/retry.dart';

void main() async{

  final client = RetryClient(http.Client());
  // we will rather use client cos most of time we will download every thing
  // about lesson's plan, so no need to close connection between api queries
  try {
    final response = await client.get(
        Uri.http(Constants.restUrl, 'rest/daty', {'wytrych': '36'})
    );

    Iterable jsonObject = jsonDecode(utf8.decode(response.bodyBytes)); // server does not sends header specifying Codec, so we need to convert...

    //TODO simplify this using #map on jsonObject
    // Map<String, dynamic> transformed = {};
    // for (var element in jsonObject) {
    //   if(transformed[element['dzien']] == null) {
    //     transformed[element['dzien']] = {'courses': [element['pk']]};
    //   }else{
    //     transformed[element['dzien']]['courses'].add(element['pk']);
    //   }
    // }
    // DONE:
    // var transformed = jsonObject.fold( //string as key
    //     <String,List<int>>{}, (map, item) =>
    //       map..putIfAbsent(item['dzien'], () => []).add(item['pk'])
    // );

    // var transformed = jsonObject.fold( //DateTime as key
    //     <DateTime,List<int>>{}, (map, item) =>
    // map..putIfAbsent(DateTime.parse(item['dzien']), () => []).add(item['pk'])
    // );
    //
    // transformed = Map.fromEntries( //sorting but maybe we should serialize all to dateTime and then sort for better perf.
    //     transformed.entries.toList()..sort((a,b)=> a.key.compareTo(b.key))
    // );

    // jsonObject = jsonObject.toList()..sort((a,b)=> a['dzien'].compareTo(b['dzien']));

    // final transformed = Map.fromEntries(
    //   jsonObject.fold(
    //     new , (map, item) =>
    //     map..putIfAbsent(DateTime.parse(item['dzien']), () => []).add(item['pk'])
    //   ).entries//.toList()
    //       //..sort((a,b)=> a.key.compareTo(b.key))
    // );
    //
    // transformed.forEach((key, value) {
    //   print('$key: $value');
    // });

    // print('Ilosc dni: ${transformed.length}');

  } finally {
    client.close();
  }

  assert(true);
}