import 'package:ezak/providers/http_client_provider.dart';
import 'package:ezak/rest/rest_api.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final keysProvider = FutureProvider.family<Map<int, String>, bool>((ref, isLecturer) async {
  final client = ref.watch(clientProvider(null));
  final keys = await PansRestApi.fetchKeys(httpClient: client, isLecturer: isLecturer);
  return keys;
});