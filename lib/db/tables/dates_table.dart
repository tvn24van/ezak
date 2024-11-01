import 'package:drift/drift.dart';
import 'package:ezak/db/tables/courses_dates_table.dart';
import 'package:ezak/model/course_date.dart';

@UseRowClass(CourseDate)
@TableIndex(name: "dates_table_courses_dates_id_and_date", columns: {#coursesDatesId, #date})
class DatesTable extends Table{

  IntColumn get coursesDatesId => integer().references(CoursesDatesTable, #id)();

  IntColumn get id => integer()();

  DateTimeColumn get date => dateTime()();

}