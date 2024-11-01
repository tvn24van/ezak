import 'package:drift/drift.dart';
import 'package:ezak/db/tables/courses_dates_table.dart';
import 'package:ezak/model/group.dart';
import 'package:ezak/model/course.dart';
import 'package:ezak/db/converters/time_of_day_converter.dart';

@UseRowClass(Course)
@TableIndex(name: "course_table_courses_dates_id_and_group", columns: {#coursesDatesId, #group})
class CourseTable extends Table{

  IntColumn get id => integer()();

  IntColumn get coursesDatesId => integer().references(CoursesDatesTable, #id)();

  TextColumn get name => text()();

  TextColumn get lecturer => text()();

  IntColumn get startTime => integer().map(TimeOfDayConverter())();

  IntColumn get endTime => integer().map(TimeOfDayConverter())();

  IntColumn get group => intEnum<Group>()();

  IntColumn get groupNumber => integer()();

  TextColumn get location => text()();

  IntColumn get roomNumber => integer()();

}