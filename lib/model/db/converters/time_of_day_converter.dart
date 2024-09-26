import 'package:drift/drift.dart';
import 'package:flutter/material.dart';

class TimeOfDayConverter extends TypeConverter<TimeOfDay, int> {
  @override
  TimeOfDay fromSql(int fromDb) {
    return TimeOfDay(hour: fromDb ~/ TimeOfDay.minutesPerHour, minute: fromDb % TimeOfDay.minutesPerHour);
  }

  @override
  int toSql(TimeOfDay value) {
    return value.hour * TimeOfDay.minutesPerHour + value.minute;
  }

}