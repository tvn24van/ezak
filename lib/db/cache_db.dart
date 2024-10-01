import 'package:drift/drift.dart';
import 'package:drift_flutter/drift_flutter.dart';
import 'package:ezak/model/course.dart';
import 'package:ezak/db/converters/time_of_day_converter.dart';
import 'package:ezak/db/tables/course_table.dart';
import 'package:ezak/db/tables/semester_table.dart';
import 'package:ezak/model/group.dart';
import 'package:flutter/material.dart' hide Table; // generated file panicked when saw Table
import 'package:flutter_riverpod/flutter_riverpod.dart';

part 'cache_db.g.dart';

@DriftDatabase(tables: [CourseTable, SemesterTable])
class CacheDb extends _$CacheDb{
  static final instance = Provider((ref) => CacheDb());

  CacheDb() : super(
    driftDatabase(
      name: "cache",
      web: DriftWebOptions(
        sqlite3Wasm: Uri.parse('sqlite3.wasm'),
        driftWorker: Uri.parse('drift_worker.js'),
        onResult: (result) {
          if (result.missingFeatures.isNotEmpty) {
            debugPrint(
              'Using ${result.chosenImplementation} due to unsupported browser features: ${result.missingFeatures}'
            );
          }
        }
      ),
    ),
  );

  @override
  MigrationStrategy get migration => MigrationStrategy(
    beforeOpen: (details) async {
      await customStatement('PRAGMA foreign_keys = ON');
    },
  );

  @override
  int get schemaVersion => 1;

  Future<List<Semester>> getSemesters(){
    return semesterTable.all().get();
  }

  Future<Semester?> getLastSemester(){
    return (select(semesterTable)..orderBy([(t)=>OrderingTerm.desc(t.id)])..limit(1)).getSingleOrNull();
  }

  Future<List<Course>> getCourses(){
    return courseTable.all().get();
  }

  Future<Course?> getCourse(int semesterId, Expression<bool> Function(GeneratedColumn<DateTime>) lambda){
    return (courseTable.select()..where((tbl) => tbl.semesterId.equals(semesterId) & lambda(tbl.date))).getSingleOrNull();
  }

  // Future addCourse(Course course){
  //   return courseTable.insertOne(course);
  // }

  Future<void> addCourses(List<Course> courses) async {
    await batch((batch) {
      batch.insertAll(courseTable, courses);
    });
  }

}