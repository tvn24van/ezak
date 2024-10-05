import 'dart:convert';

import 'package:ezak/providers/settings_provider.dart';
import 'package:ezak/utils/constants.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import 'package:http/retry.dart';

// todo add caching mechanism if possible
final keysProvider = FutureProvider<Map<int, String>>((ref) async {
  final teacherMode = ref.watch(SettingsProvider.instance.select((setting) => setting.isLecturer));
  final client = RetryClient(http.Client(), retries: 1);
  final response = await client.get(
    Uri.http(Constants.restUrl, 'rest/${teacherMode?'prowadzacy':'wytrych'}')
  );
  final Iterable json = jsonDecode(utf8.decode(response.bodyBytes));

  final Map<int, String> specializations = {
    for (var i in json) i['id']: i[teacherMode? 'skrot' : 'pelna_nazwa']
  };

  return specializations;
});