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
  if(teacherMode) {
    return { for (var i in json) i['skrot']: i['id']};
  }else{
    return { for (var i in json) i['pelna_nazwa']: i['id']};
  }
});