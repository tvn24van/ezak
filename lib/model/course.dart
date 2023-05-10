import 'package:ezak/model/group.dart';
import 'package:ezak/model/decoders/hours_decoder.dart';
import 'package:ezak/widgets/mixins/course_widget.dart';
import 'package:flutter/foundation.dart';
import 'package:json_annotation/json_annotation.dart';

part 'course.g.dart';

/// General representation of "Course"
abstract class CourseModel{
  final int id;
  final String name;
  final String lecturer;
  final Duration startHour;
  final int timeOfCourse;
  final Duration endHour;
  final Group group;
  final int groupNumber;
  final String location;
  final int roomNumber;

  bool isOnline();

  CourseModel(
    this.id,
    this.name,
    this.lecturer,
    this.startHour,
    this.timeOfCourse,
    this.endHour,
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
class Course extends CourseModel with CourseWidget{

  /// Name of this Course
  @override
  @JsonKey(name: 'nazwa')
  get name;

  /// Personalias of lecturer leading
  /// this course
  @override
  @JsonKey(name: 'skrot')
  get lecturer;

  /// Course start hour
  @override
  @JsonKey(name: 'godzinaod', fromJson: HoursDecoder.decodeStartHour)
  get startHour;

  /// Amount of course's hours
  /// (each represents 45 minutes)
  @override
  @JsonKey(name: 'czaskursu')
  get timeOfCourse;

  /// Course end hour
  @override
  @JsonKey(readValue: _readEndTime)
  get endHour;

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
    required startHour,
    required timeOfCourse,
    required endHour,
    required group,
    required groupNumber,
    required lecturer,
    required location,
    required roomNumber,
  }):super(id, name, lecturer, startHour, timeOfCourse, endHour, group, groupNumber, location, roomNumber);


  /// Returns whether this course
  /// will take place online or not
  @override
  bool isOnline(){
    return location == onlineLocation;
  }

  /// One of possible Course's "location"
  static String get onlineLocation => ' Online';

  static Duration _readEndTime(Map map, String key){
    return HoursDecoder.decodeEndHour(map['godzinaod'], map['czaskursu']);
  }

  @override
  int get hashCode => id.hashCode ^ group.hashCode;

  @override
  bool operator==(Object other) =>
      identical(this, other) || other is Course && hashCode == other.hashCode;

  /*
  After every change run following:
  flutter pub run build_runner build
  to generate json encoding
   */

  factory Course.fromJson(Map<String, dynamic> json) => _$CourseFromJson(json);

  // Map<String, dynamic> toJson() => _$CourseToJson(this);

}