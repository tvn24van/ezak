import 'package:drift/drift.dart';
import 'package:ezak/db/tables/courses_dates_table.dart';
import 'package:ezak/model/group.dart';
import 'package:ezak/model/course.dart';
import 'package:ezak/db/converters/time_of_day_converter.dart';

@UseRowClass(Course)
// @TableIndex(name: "course_index_by_date", columns: {#date})
// @TableIndex(name: "course_index_by_semester", columns: {#semesterId})

// @TableIndex(name: "course_index_by_date_and_semester", columns: {#semesterId, #date})
class CourseTable extends Table{

  IntColumn get id => integer()();

  IntColumn get coursesDatesId => integer().references(CoursesDatesTable, #id)();

  TextColumn get name => text()();

  TextColumn get lecturer => text()();

  // DateTimeColumn get date => dateTime()();

  IntColumn get startTime => integer().map(TimeOfDayConverter())();

  // IntColumn get timeOfCourse => integer()(); // do we need to store time of course when we can obtain end time just after json deserialization

  IntColumn get endTime => integer().map(TimeOfDayConverter())();

  IntColumn get group => intEnum<Group>()();

  IntColumn get groupNumber => integer()();

  TextColumn get location => text()();

  IntColumn get roomNumber => integer()();

}