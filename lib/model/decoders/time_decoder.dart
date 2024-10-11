import 'package:ezak/utils/extensions.dart';
import 'package:flutter/material.dart';

/// Util for decoding raw [int]s provided
/// by rest api to more usable [TimeOfDay]
final class TimeDecoder {

  /// Break time between double length standard courses (in minutes)
  static const int breakLengthInMinutes = 10;

  /// Time of single course (standard course takes double this time)
  static const int courseTimeInMinutes = 45;

  /// Start time represented as TimeOfDay (7:15 AM)
  static const TimeOfDay startTime = TimeOfDay(hour: 7, minute: 15);

  /// Uses start hour [code] provided by rest api
  /// to generate time in [TimeOfDay]
  static TimeOfDay decodeStartTime(int code) {
    final breakTimeSumInMinutes = breakLengthInMinutes * (code ~/ 2) - (code < 2 ? 0 : breakLengthInMinutes);
    final totalMinutesToAdd = (courseTimeInMinutes * (code - 1)) + breakTimeSumInMinutes;
    final totalMinutes = startTime.totalMinutes + totalMinutesToAdd;
    return TimeOfDay(hour: totalMinutes ~/ 60 % 24, minute: totalMinutes % 60);
  }

  /// Uses [code] which indicates a start hour
  /// and [lengthCode] which is length of [Course]
  static TimeOfDay decodeEndTime(int code, int lengthCode) {
    final sum = code + lengthCode;
    final endTime = decodeStartTime(sum);
    final totalMinutes = endTime.totalMinutes - (sum % 2 == 0 ? breakLengthInMinutes : 0);
    return TimeOfDay(hour: totalMinutes ~/ 60 % 24, minute: totalMinutes % 60);
  }


  static int encodeStartTime(TimeOfDay timeofday)=> throw UnimplementedError("Encoding not implemented");
  static int encodeEndTime(TimeOfDay timeofday)=> throw UnimplementedError("Encoding not implemented");
}
