import 'package:ezak/l10n/l10n.g.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:intl/intl.dart';

extension PlatformExtensions on TargetPlatform{
  bool isMobile(){
    return /*kIsWeb? false:*/
      defaultTargetPlatform == TargetPlatform.android ||
      defaultTargetPlatform == TargetPlatform.fuchsia ||
      defaultTargetPlatform == TargetPlatform.iOS;
  }
}

extension DateTimeExtension on DateTime{
  String toLocaleString(Locale locale){
    return DateFormat.yMd(locale.languageCode).format(this);
  }

  bool get isAprilFoolsDay => month == 4 && day == 1;

  // int get weekOfMonth {
  //   int sum = firstDayOfMonth.weekday - 1 + day;
  //   if (sum % 7 == 0) {
  //     return sum ~/ 7;
  //   } else {
  //     return sum ~/ 7 + 1;
  //   }
  // }
}

extension ContentTypeExtension on Response{
  String? get contentType => headers['content-type'];
}

extension TimeOfDayExtension on TimeOfDay{
  int get totalMinutes => hour * TimeOfDay.minutesPerHour + minute;
  static TimeOfDay fromMinutes(int minutes)=> TimeOfDay(
    hour: minutes ~/ TimeOfDay.minutesPerHour,
    minute: minutes % TimeOfDay.minutesPerHour
  );
  operator >(TimeOfDay other) => totalMinutes > other.totalMinutes;
  TimeOfDay operator -(TimeOfDay other) => fromMinutes(totalMinutes - other.totalMinutes);
}

extension DurationToHour on Duration{
  String formatTime(BuildContext context){
    return "${inHours!=0? ('$inHours ${L10n.of(context).short_hour}'):''} ${inMinutes!=0?('${inMinutes.remainder(TimeOfDay.minutesPerHour)} ${L10n.of(context).short_minute}'):''}";
  }
}