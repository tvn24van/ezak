import 'package:ezak/db/cache_db.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:drift/drift.dart' as drift;

part 'course_date.g.dart';

@JsonSerializable()
class CourseDate implements drift.Insertable<CourseDate>{

  @JsonKey(includeFromJson: false)
  final int? coursesDatesId;

  @JsonKey(name: "pk")
  final int id;

  @JsonKey(name: "dzien")
  final DateTime date;

  CourseDate({this.coursesDatesId, required this.id, required this.date});

  factory CourseDate.fromJson(Map<String, dynamic> json) => _$CourseDateFromJson(json);

  @override
  Map<String, drift.Expression<Object>> toColumns(bool nullToAbsent) {
    return DatesTableCompanion(
      coursesDatesId: drift.Value(coursesDatesId!),
      id: drift.Value(id),
      date: drift.Value(date)
    ).toColumns(nullToAbsent);
  }

  CourseDate copyWith({
    int? coursesDatesId,
    int? id,
    DateTime? date,
  }) {
    return CourseDate(
      coursesDatesId: coursesDatesId ?? this.coursesDatesId,
      id: id ?? this.id,
      date: date ?? this.date,
    );
  }
}