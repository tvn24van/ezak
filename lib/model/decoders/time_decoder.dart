// import 'package:time/time.dart';
//
// // use TimeOfDay
//
// /// Util for decoding raw [int]s provided
// /// by rest api to more usable [Duration]
// final class HoursDecoder{
//   /// Break time between double length standard courses
//   static final Duration breakLength = 10.minutes;
//   /// Time of single course (standard course takes double this time)
//   static final Duration courseTime = 45.minutes;
//   /// Literally 7:15 (.25 in declaration is just a quarter of hour in minutes)
//   static final Duration startTime = 7.25.hours;
//
//   /// Uses start hour [code] provided by rest api
//   /// to generate time in [Duration]
//   static Duration decodeStartHour(int code){
//     final breakLengthSum = breakLength * (code ~/ 2) - (code<2? Duration.zero : breakLength);
//     return startTime + courseTime * (code-1) + breakLengthSum;
//   }
//
//   /// Uses [code] which indicates a start hour
//   /// and [lengthCode] which is length of [Course]
//   static Duration decodeEndHour(int code, int lengthCode){
//     final sum = code + lengthCode;
//     return decodeStartHour(sum) - (sum%2!=0? Duration.zero : breakLength);
//   }
// }

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

  /// Helper function to add minutes to a TimeOfDay object
  static TimeOfDay addMinutes(TimeOfDay time, int minutesToAdd) {
    final totalMinutes = time.hour * 60 + time.minute + minutesToAdd;
    final newHour = totalMinutes ~/ 60;
    final newMinute = totalMinutes % 60;
    return TimeOfDay(hour: newHour % 24, minute: newMinute);
  }

  /// Uses start hour [code] provided by rest api
  /// to generate time in [TimeOfDay]
  static TimeOfDay decodeStartTime(int code) {
    // Calculate the break time based on the code
    final breakTimeSumInMinutes = breakLengthInMinutes * (code ~/ 2) - (code < 2 ? 0 : breakLengthInMinutes);

    // Calculate the total time to add in minutes
    final totalMinutesToAdd = (courseTimeInMinutes * (code - 1)) + breakTimeSumInMinutes;

    return addMinutes(startTime, totalMinutesToAdd);
  }

  /// Uses [code] which indicates a start hour
  /// and [lengthCode] which is length of [Course]
  static TimeOfDay decodeEndTime(int code, int lengthCode) {
    final sum = code + lengthCode;
    final endTime = decodeStartTime(sum);

    // Subtract the break if necessary (if sum is even)
    if (sum % 2 == 0) {
      return addMinutes(endTime, -breakLengthInMinutes);
    }

    return endTime;
  }

  static int encodeStartTime(TimeOfDay timeofday)=> throw UnimplementedError("Encoding not implemented");
  static int encodeEndTime(TimeOfDay timeofday)=> throw UnimplementedError("Encoding not implemented");
}
