import 'package:drift/drift.dart';
import 'package:ezak/db/tables/courses_dates_table.dart';

@DataClassName("CourseDate")
class DatesTable extends Table{

  IntColumn get coursesDatesId => integer().references(CoursesDatesTable, #id)();

  @JsonKey("pk")
  IntColumn get id => integer()();
  // IntColumn get course => integer().references(CourseTable, #id)();
  
  @JsonKey("dzien")
  DateTimeColumn get date => dateTime()();

}