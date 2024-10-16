import 'package:drift/drift.dart';
import 'package:ezak/db/tables/courses_dates_table.dart';
import 'package:ezak/model/course_date.dart';

@UseRowClass(CourseDate)
class DatesTable extends Table{

  IntColumn get coursesDatesId => integer().references(CoursesDatesTable, #id)();

  IntColumn get id => integer()();

  DateTimeColumn get date => dateTime()();

}