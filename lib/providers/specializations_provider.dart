import 'dart:convert';

import 'package:ezak/providers/settings_provider.dart';
import 'package:ezak/utils/constants.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import 'package:http/retry.dart';

final specializationsProvider = FutureProvider<Map<String, int>>((ref) async {
  final teacherMode = ref.watch(SettingsProvider.instance.select((setting) => setting.isTeacher));
  final client = RetryClient(http.Client(), retries: 1);
  final response = await client.get(
      Uri.http(Constants.restUrl, 'rest/${teacherMode?'prowadzacy':'wytrych'}')
  );
  final Iterable json = jsonDecode(utf8.decode(response.bodyBytes));

  final Map<String, int> specializations = {
    for (var i in json) i[teacherMode? 'skrot' : 'pelna_nazwa']: i['id']
  };

  return specializations;
});