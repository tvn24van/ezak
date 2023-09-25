import 'package:time/time.dart';

/// Util for decoding raw [int]s provided
/// by rest api to more usable [Duration]
final class HoursDecoder{
  /// Break time between double length standard courses
  static final Duration breakLength = 10.minutes;
  /// Time of single course (standard course takes double this time)
  static final Duration courseTime = 45.minutes;
  /// Literally 7:15 (.25 in declaration is just a quarter of hour in minutes)
  static final Duration startTime = 7.25.hours;

  /// Uses start hour [code] provided by rest api
  /// to generate time in [Duration]
  static Duration decodeStartHour(int code){
    final breakLengthSum = breakLength * (code ~/ 2) - (code<2? Duration.zero : breakLength);
    return startTime + courseTime * (code-1) + breakLengthSum;
  }

  /// Uses [code] which indicates a start hour
  /// and [lengthCode] which is length of [Course]
  static Duration decodeEndHour(int code, int lengthCode){
    final sum = code + lengthCode;
    return decodeStartHour(sum) - (sum%2!=0? Duration.zero : breakLength);
  }
}