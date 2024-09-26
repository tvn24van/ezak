import 'package:drift/drift.dart';

@DataClassName("Semester")
class SemesterTable extends Table{
  IntColumn get id => integer().autoIncrement()();
  TextColumn get mark => text().unique()();
}