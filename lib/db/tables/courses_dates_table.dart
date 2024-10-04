import 'package:drift/drift.dart';

@DataClassName("Assignment")
class CoursesDatesTable extends Table{
  IntColumn get id => integer().autoIncrement()();

  BoolColumn get isLecturer => boolean()();

  IntColumn get key => integer()();
}