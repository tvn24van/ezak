import 'package:drift/drift.dart' as drift;
import 'package:ezak/model/db/cache_db.dart';
import 'package:ezak/model/group.dart';
import 'package:ezak/widgets/mixins/course_widget.dart';
import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';

import 'decoders/time_decoder.dart';

part 'course.g.dart';

/// General representation of "Course"
// abstract class CourseModel{
//   final int id;
//   final String name;
//   final String lecturer;
//   final Duration startHour;
//   final int timeOfCourse;
//   final Duration endHour;
//   final Group group;
//   final int groupNumber;
//   final String location;
//   final int roomNumber;
//
//   bool isOnline();
//   Course getCourse();
//
//   CourseModel(
//     this.id,
//     this.name,
//     this.lecturer,
//     this.startHour,
//     this.timeOfCourse,
//     this.endHour,
//     this.group,
//     this.groupNumber,
//     this.location,
//     this.roomNumber
//   );
//
// }

abstract class CourseModel{
  final int id;
  final String name;
  final String lecturer;
  final DateTime date;
  final TimeOfDay startTime;
  // final int timeOfCourse;
  final TimeOfDay endTime;
  final Group group;
  final int groupNumber;
  final String location;
  final int roomNumber;

  bool isOnline();
  String? getLocationAddress();
  CourseModel getCourse() => this;

  CourseModel(
    this.id,
    this.name,
    this.lecturer,
    this.date,
    this.startTime,
    // this.timeOfCourse,
    this.endTime,
    this.group,
    this.groupNumber,
    this.location,
    this.roomNumber
    );
}

/// Serializable representation of single course
/// WARNING: does not contain any data about days
/// at which course will take place!
@immutable
@JsonSerializable()
// class Course extends CourseModel with CourseWidget{
//
//   /// Name of this Course
//   @override
//   @JsonKey(name: 'nazwa')
//   get name;
//
//   /// Personalias of lecturer leading
//   /// this course
//   @override
//   @JsonKey(name: 'skrot')
//   get lecturer;
//
//   /// Course start hour
//   @override
//   @JsonKey(name: 'godzinaod', fromJson: HoursDecoder.decodeStartHour)
//   get startHour;
//
//   /// Amount of course's hours
//   /// (each represents 45 minutes)
//   @override
//   @JsonKey(name: 'czaskursu')
//   get timeOfCourse;
//
//   /// Course end hour
//   @override
//   @JsonKey(readValue: _readEndTime)
//   get endHour;
//
//   /// Specifies whether this course is a
//   /// laboratory (L), exercises (C) etc.
//   @override
//   @JsonKey(name: 'rodzaj', fromJson: Group.ofSymbol)
//   get group;
//
//   /// Number of group for which this
//   /// course occurs
//   @override
//   @JsonKey(name: 'numer')
//   get groupNumber;
//
//   /// Identity of collage's building
//   /// like G, C ...
//   /// or literally " Online"
//   /// see [onlineLocation]
//   @override
//   @JsonKey(name: 'symbol')
//   get location;
//
//   /// Room number
//   @override
//   @JsonKey(name: 'nrsali')
//   get roomNumber;
//
//   Course({
//     required id,
//     required name,
//     required startHour,
//     required timeOfCourse,
//     required endHour,
//     required group,
//     required groupNumber,
//     required lecturer,
//     required location,
//     required roomNumber,
//   }):super(id, name, lecturer, startHour, timeOfCourse, endHour, group, groupNumber, location, roomNumber);
//
//   @override
//   Course getCourse() => this;
//
//   /// Returns whether this course
//   /// will take place online or not
//   @override
//   bool isOnline(){
//     return location == onlineLocation;
//   }
//
//   /// One of possible Course's "location"
//   static const String onlineLocation = ' Online';
//
//   static Duration _readEndTime(Map map, String key){
//     return HoursDecoder.decodeEndHour(map['godzinaod'], map['czaskursu']);
//   }
//
//   /// addresses according to this
//   /// <a href="https://pans.nysa.pl/kontakt">page</a>
//   static const addresses = {
//     "R": "Armii Krajowej 7 48-300 Nysa",
//     "A": "Chodowieckiego 4 48-300 Nysa",
//     "D": "Ujejskiego 12 48-300 Nysa",
//     "E": "Armii Krajowej 19 48-300 Nysa",
//     "F": "Armii Krajowej 21 48-300 Nysa",
//     "G": "Obrońców Tobruku 5, 48-300 Nysa",
//     "C": "Obrońców Tobruku 5, 48-300 Nysa",
//     "H": "Marcinkowskiego 6-8 48-300 Nysa",
//     "Z": "Obrońców Tobruku 5a 48-300 Nysa",
//     "X": "Głuchołaska 12 48-303 Nysa",
//     "O": "Otmuchowska 74 48-300 Nysa"
//   };
//
//   //todo replace this with data grabbed from internet somehow
//   String? getLocationAddress(){
//     return addresses.entries.where((element) =>
//       location.contains(element.key)
//     ).firstOrNull?.value;
//   }
//
//   @override
//   int get hashCode => id.hashCode ^ group.hashCode;
//
//   @override
//   bool operator==(Object other) =>
//       identical(this, other) || other is Course && hashCode == other.hashCode;
//
//   factory Course.fromJson(Map<String, dynamic> json) => _$CourseFromJson(json);
//
//   Map<String, dynamic> toJson() => _$CourseToJson(this);
//
// }

class Course extends CourseModel with CourseWidget implements drift.Insertable<Course>{

  /// Name of this Course
  @override
  @JsonKey(name: 'nazwa')
  get name;

  /// Personalias of lecturer leading
  /// this course
  @override
  @JsonKey(name: 'skrot')
  get lecturer;

  /// needs to be fetched from another path
  @override
  get date;

  /// Course start hour
  @override
  @JsonKey(name: 'godzinaod', fromJson: TimeDecoder.decodeStartTime, toJson: TimeDecoder.encodeStartTime)
  get startTime;

  // /// Amount of course's hours
  // /// (each represents 45 minutes)
  // @override
  // @JsonKey(name: 'czaskursu')
  // get timeOfCourse;

  /// Course end hour
  @override
  @JsonKey(readValue: _readEndTime, toJson: TimeDecoder.encodeEndTime)
  get endTime;

  /// Specifies whether this course is a
  /// laboratory (L), exercises (C) etc.
  @override
  @JsonKey(name: 'rodzaj', fromJson: Group.ofSymbol)
  get group;

  /// Number of group for which this
  /// course occurs
  @override
  @JsonKey(name: 'numer')
  get groupNumber;

  /// Identity of collage's building
  /// like G, C ...
  /// or literally " Online"
  /// see [onlineLocation]
  @override
  @JsonKey(name: 'symbol')
  get location;

  /// Room number
  @override
  @JsonKey(name: 'nrsali')
  get roomNumber;

  Course({
    required id,
    required name,
    required date,
    required startTime,
    // required timeOfCourse,
    required endTime,
    required group,
    required groupNumber,
    required lecturer,
    required location,
    required roomNumber,
  }):super(id, name, lecturer, date, startTime, /*timeOfCourse,*/ endTime, group, groupNumber, location, roomNumber);

  /// Returns whether this course
  /// will take place online or not
  @override
  bool isOnline(){
    return location == onlineLocation;
  }

  /// One of possible Course's "location"
  static const String onlineLocation = ' Online';

  static TimeOfDay _readEndTime(Map map, String key){
    return TimeDecoder.decodeEndTime(map['godzinaod'], map['czaskursu']);
  }

  /// addresses according to this
  /// <a href="https://pans.nysa.pl/kontakt">page</a>
  static const addresses = {
    "R": "Armii Krajowej 7 48-300 Nysa",
    "A": "Chodowieckiego 4 48-300 Nysa",
    "D": "Ujejskiego 12 48-300 Nysa",
    "E": "Armii Krajowej 19 48-300 Nysa",
    "F": "Armii Krajowej 21 48-300 Nysa",
    "G": "Obrońców Tobruku 5, 48-300 Nysa",
    "C": "Obrońców Tobruku 5, 48-300 Nysa",
    "H": "Marcinkowskiego 6-8 48-300 Nysa",
    "Z": "Obrońców Tobruku 5a 48-300 Nysa",
    "X": "Głuchołaska 12 48-303 Nysa",
    "O": "Otmuchowska 74 48-300 Nysa"
  };

  //maybe replace this with data grabbed from internet somehow
  @override
  String? getLocationAddress(){
    return addresses.entries.where((element) =>
        location.contains(element.key)
    ).firstOrNull?.value;
  }

  @override
  int get hashCode => id.hashCode ^ group.hashCode;

  @override
  bool operator==(Object other) =>
      identical(this, other) || other is Course && hashCode == other.hashCode;

  factory Course.fromJson(Map<String, dynamic> json) => _$CourseFromJson(json);

  // Map<String, dynamic> toJson() => _$CourseToJson(this);

  @override
  Map<String, drift.Expression<Object>> toColumns(bool nullToAbsent) {
    return CourseTableCompanion(
      id: drift.Value(id),
      name: drift.Value(name),
      date: drift.Value(date),
      endTime: drift.Value(endTime),
      group: drift.Value(group),
      groupNumber: drift.Value(groupNumber),
      lecturer: drift.Value(lecturer),
      location: drift.Value(location),
      roomNumber: drift.Value(roomNumber),
      startTime: drift.Value(startTime)
    ).toColumns(nullToAbsent);
  }

}