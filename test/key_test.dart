import 'dart:convert';
import 'package:ezak/utils/constants.dart';
import 'package:http/retry.dart';
import 'package:http/http.dart' as http;

void main() async {

  final client = RetryClient(http.Client());
  // we will rather use client cos most of time we will download every thing
  // about lesson's plan, so no need to close connection between api queries
  try {
    final response = await client.get(
        Uri.http(Constants.restUrl, 'rest/wytrych')
    );
    Iterable jsonObject = jsonDecode(utf8.decode(response.bodyBytes));

    // jsonObject.fold(
    //   <S>
    // );

    print(jsonObject);

  } finally {
    client.close();
  }

  assert(true);
}