import 'package:ezak/providers/settings_provider.dart';
import 'package:ezak/rest/rest_api.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import 'package:http/retry.dart';

// todo add caching mechanism if possible
final keysProvider = FutureProvider<Map<int, String>>((ref) async {
  final isLecturer = ref.watch(SettingsProvider.instance.select((setting) => setting.isLecturer));
  final client = RetryClient(http.Client(), retries: 1);
  final keys = PansRestApi.fetchKeys(httpClient: client, isLecturer: isLecturer);
  client.close();
  return keys;
});