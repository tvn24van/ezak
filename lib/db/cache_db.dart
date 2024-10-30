import 'package:drift/drift.dart';
import 'package:drift_flutter/drift_flutter.dart';
import 'package:ezak/db/log/debug_logging_query_executor.dart';
import 'package:ezak/db/tables/courses_dates_table.dart';
import 'package:ezak/db/tables/dates_table.dart';
import 'package:ezak/model/course.dart';
import 'package:ezak/db/converters/time_of_day_converter.dart';
import 'package:ezak/db/tables/course_table.dart';
import 'package:ezak/db/tables/semester_table.dart';
import 'package:ezak/model/course_date.dart';
import 'package:ezak/model/group.dart';
import 'package:ezak/model/settings.dart';
import 'package:flutter/material.dart' hide Table; // generated file panicked when saw Table
import 'package:flutter_riverpod/flutter_riverpod.dart';

part 'cache_db.g.dart';

/// In-disk cache mainly for schedules
@DriftDatabase(tables: [CourseTable, DatesTable, CoursesDatesTable, SemesterTable])
class CacheDb extends _$CacheDb{
  static final instance = Provider((ref){
    final db = CacheDb();
    ref.onDispose(() => db.close());
    return db;
  });

  CacheDb() : super(
    DebugLoggingQueryExecutor.wrap(driftDatabase(
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
  ));

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
    return (select(semesterTable)
      ..orderBy([(t)=>OrderingTerm.asc(t.id)])
      ..limit(1)
    ).getSingleOrNull();
  }

  Future<Assignment?> getAssignment({required int key, required bool isLecturer}) async{
    return (select(coursesDatesTable)
      ..where((tbl) => tbl.isLecturer.equals(isLecturer) & tbl.key.equals(key))
      ..limit(1)
    ).getSingleOrNull();
  }

  Future<Map<Group, int>> getMaxGroups({
    required int key,
    required bool isLecturer,
  })async{
    final maxGroupNumber = courseTable.groupNumber.max();

    final query = select(courseTable).join([
      innerJoin(
        coursesDatesTable,
        coursesDatesTable.id.equalsExp(courseTable.coursesDatesId),
        useColumns: false
      ),
    ])
    ..where(
      coursesDatesTable.isLecturer.equals(isLecturer) &
      coursesDatesTable.key.equals(key)
    )
    ..addColumns([courseTable.group, maxGroupNumber])
    ..groupBy([courseTable.group]);

    return query.map((row) =>
      MapEntry(Group.values[row.read(courseTable.group)!], row.read(maxGroupNumber)!)
    ).get().then((value) => Map.fromEntries(value));
  }

  Future<List<DateTime>> getDates({
    required int key,
    required bool isLecturer,
    required GroupsMap groups,
  })async{
    final query = selectOnly(datesTable).join([
      innerJoin(coursesDatesTable, coursesDatesTable.id.equalsExp(datesTable.coursesDatesId), useColumns: false),
      innerJoin(courseTable, courseTable.coursesDatesId.equalsExp(coursesDatesTable.id) & courseTable.id.equalsExp(datesTable.id), useColumns: false)
    ])
    ..addColumns([datesTable.date])
    ..where(
      coursesDatesTable.isLecturer.equals(isLecturer) &
      coursesDatesTable.key.equals(key)
    )
    ..groupBy([datesTable.date])
    ..orderBy([OrderingTerm.asc(datesTable.date)]);
    if(!groups.areGroupsEmpty()){
      query.where(courseTable.group.caseMatch(when: {
        for(final e in groups.entries.where((element) => element.value.isNotEmpty))
          Constant(e.key.index): courseTable.groupNumber.isIn(e.value)
      }));
    }
    return query.map((row)=> row.read(datesTable.date)!).get();
  }

  Future<Map<DateTime, List<Course>>> getCourses({
    required int key,
    required bool isLecturer,
    required GroupsMap groups,
    required List<DateTime> dates
  }){
    final query = select(courseTable).join([
      innerJoin(coursesDatesTable, coursesDatesTable.id.equalsExp(courseTable.coursesDatesId), useColumns: false),
      innerJoin(datesTable, datesTable.coursesDatesId.equalsExp(coursesDatesTable.id) & courseTable.id.equalsExp(datesTable.id), useColumns: false)
    ])
      ..addColumns([datesTable.date])
      ..where(
        coursesDatesTable.isLecturer.equals(isLecturer) &
        coursesDatesTable.key.equals(key) &
        datesTable.date.isIn(dates)
      )
      ..orderBy([OrderingTerm.asc(courseTable.startTime)]);
    if(!groups.areGroupsEmpty()){
      query.where(courseTable.group.caseMatch(when: {
        for(final e in groups.entries.where((element) => element.value.isNotEmpty))
          Constant(e.key.index): courseTable.groupNumber.isIn(e.value)
      }));
    }
    return query.map((row) =>
      MapEntry(row.read(datesTable.date)!, [row.readTable(courseTable)])
    ).get()
      .then((entries){
        final map = entries.fold(<DateTime, List<Course>>{}, (acc, entry) {
          acc.update(
            entry.key,
            (list) => list..addAll(entry.value),
            ifAbsent: () => List.of(entry.value)
          );
          return acc;
        });
        return map;
      });
  }

  Future<void> addSchedule({
    required int key,
    required bool isLecturer,
    required List<Course> courses,
    required List<CourseDate> coursesDates
  })async{
    await transaction(() async {
      final assignment = await into(coursesDatesTable).insertReturning(
        CoursesDatesTableCompanion.insert(isLecturer: isLecturer, key: key)
      );
      await batch((batch) {
        batch.insertAll(
          courseTable,
          courses.map((c) => c.copyWith(coursesDatesId: assignment.id))
        );
        batch.insertAll(
          datesTable,
          coursesDates.map((d)=> d.copyWith(coursesDatesId: assignment.id))
        );
      });
    });
  }

  Future<void> updateSchedule({
    required int key,
    required bool isLecturer,
    required List<Course> courses,
    required List<CourseDate> coursesDates
  })async {
    await transaction(() async {
      final assignment = (await (update(coursesDatesTable)
        ..where((tbl) =>
          tbl.key.equals(key) &
          tbl.isLecturer.equals(isLecturer)
        ))
        .writeReturning(
          CoursesDatesTableCompanion(lastUpdate: Value(DateTime.now())))
        ).first;

      await batch((batch) {
        batch.deleteWhere(courseTable, (tbl) => tbl.coursesDatesId.equals(assignment.id));
        batch.deleteWhere(datesTable, (tbl) => tbl.coursesDatesId.equals(assignment.id));
        batch.insertAll(
          courseTable,
          courses.map((c) => c.copyWith(coursesDatesId: assignment.id))
        );
        batch.insertAll(
          datesTable,
          coursesDates.map((d) => d.copyWith(coursesDatesId: assignment.id))
        );
      });
    });
  }

  Future<void> removeSchedules(Ref ref) async {
    await batch((batch) { // starts transaction implicitly
      batch.deleteAll(courseTable);
      batch.deleteAll(datesTable);
      batch.deleteAll(coursesDatesTable);
    });
  }

}