// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'course.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Course _$CourseFromJson(Map<String, dynamic> json) => Course(
      id: json['id'],
      name: json['nazwa'],
      startHour: HoursDecoder.decodeStartHour(json['godzinaod'] as int),
      timeOfCourse: json['czaskursu'],
      endHour: Course._readEndTime(json, 'endHour'),
      group: Group.ofSymbol(json['rodzaj'] as String),
      groupNumber: json['numer'],
      lecturer: json['skrot'],
      location: json['symbol'],
      roomNumber: json['nrsali'],
    );

Map<String, dynamic> _$CourseToJson(Course instance) => <String, dynamic>{
      'id': instance.id,
      'nazwa': instance.name,
      'skrot': instance.lecturer,
      'godzinaod': instance.startHour.inMicroseconds,
      'czaskursu': instance.timeOfCourse,
      'endHour': instance.endHour.inMicroseconds,
      'rodzaj': _$GroupEnumMap[instance.group]!,
      'numer': instance.groupNumber,
      'symbol': instance.location,
      'nrsali': instance.roomNumber,
    };

const _$GroupEnumMap = {
  Group.lecture: 'W',
  Group.exercises: 'C',
  Group.laboratories: 'L',
  Group.project: 'P',
  Group.seminar: 'S',
};
