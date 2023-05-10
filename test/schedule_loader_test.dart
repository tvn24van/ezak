import 'dart:ui';

import 'package:ezak/model/loaders/schedule_loader.dart';

void main() async{
  // final updateDate = await ScheduleLoader.getUpdateDate(false, 36);
  // print(updateDate);

  final locale = Locale.fromSubtags(languageCode: 'sram');
  print(locale == null);
}