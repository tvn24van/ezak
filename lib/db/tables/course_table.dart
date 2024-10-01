import 'package:drift/drift.dart';
import 'package:ezak/model/actor.dart';
import 'package:ezak/db/tables/semester_table.dart';
import 'package:ezak/model/group.dart';
import 'package:ezak/model/course.dart';
import 'package:ezak/db/converters/time_of_day_converter.dart';

@UseRowClass(Course)
// @TableIndex(name: "course_index_by_date", columns: {#date})
// @TableIndex(name: "course_index_by_semester", columns: {#semesterId})

// @TableIndex(name: "course_index_by_date_and_semester", columns: {#semesterId, #date})
class CourseTable extends Table{

  @override
  Set<Column> get primaryKey => {id, specialization, owner};

  IntColumn get id => integer()();

  IntColumn get specialization => integer()();

  IntColumn get owner => intEnum<Actor>()();

  // IntColumn get semesterId => integer().references(SemesterTable, #id)();

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