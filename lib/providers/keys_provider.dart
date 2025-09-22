import 'package:ezak/rest/rest_api.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import 'package:http/retry.dart';

final keysProvider = FutureProvider.family<Map<int, String>, bool>((ref, isLecturer) async {
  final client = RetryClient(http.Client(), retries: 1);
  final keys = PansRestApi.fetchKeys(httpClient: client, isLecturer: isLecturer);
  client.close();
  return keys;
});