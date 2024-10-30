import 'package:drift/drift.dart';
import 'package:ezak/utils/extensions.dart';
import 'package:flutter/material.dart';

class TimeOfDayConverter extends TypeConverter<TimeOfDay, int> {
  @override
  TimeOfDay fromSql(int fromDb) {
    return TimeOfDayExtension.fromMinutes(fromDb);
  }

  @override
  int toSql(TimeOfDay value) {
    return value.totalMinutes;
  }

}