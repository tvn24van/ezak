// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cache_db.dart';

// ignore_for_file: type=lint
class $SemesterTableTable extends SemesterTable
    with TableInfo<$SemesterTableTable, Semester> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $SemesterTableTable(this.attachedDatabase, [this._alias]);
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  @override
  late final GeneratedColumn<String> mark = GeneratedColumn<String>(
      'mark', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: true,
      defaultConstraints: GeneratedColumn.constraintIsAlways('UNIQUE'));
  @override
  List<GeneratedColumn> get $columns => [id, mark];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'semester_table';
  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Semester map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Semester(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      mark: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}mark'])!,
    );
  }

  @override
  $SemesterTableTable createAlias(String alias) {
    return $SemesterTableTable(attachedDatabase, alias);
  }
}

class Semester extends DataClass implements Insertable<Semester> {
  final int id;
  final String mark;
  const Semester({required this.id, required this.mark});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['mark'] = Variable<String>(mark);
    return map;
  }

  factory Semester.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Semester(
      id: serializer.fromJson<int>(json['id']),
      mark: serializer.fromJson<String>(json['mark']),
    );
  }
  factory Semester.fromJsonString(String encodedJson,
          {ValueSerializer? serializer}) =>
      Semester.fromJson(
          DataClass.parseJson(encodedJson) as Map<String, dynamic>,
          serializer: serializer);
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'mark': serializer.toJson<String>(mark),
    };
  }

  Semester copyWith({int? id, String? mark}) => Semester(
        id: id ?? this.id,
        mark: mark ?? this.mark,
      );
  Semester copyWithCompanion(SemesterTableCompanion data) {
    return Semester(
      id: data.id.present ? data.id.value : this.id,
      mark: data.mark.present ? data.mark.value : this.mark,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Semester(')
          ..write('id: $id, ')
          ..write('mark: $mark')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, mark);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Semester && other.id == this.id && other.mark == this.mark);
}

class SemesterTableCompanion extends UpdateCompanion<Semester> {
  final Value<int> id;
  final Value<String> mark;
  const SemesterTableCompanion({
    this.id = const Value.absent(),
    this.mark = const Value.absent(),
  });
  SemesterTableCompanion.insert({
    this.id = const Value.absent(),
    required String mark,
  }) : mark = Value(mark);
  static Insertable<Semester> custom({
    Expression<int>? id,
    Expression<String>? mark,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (mark != null) 'mark': mark,
    });
  }

  SemesterTableCompanion copyWith({Value<int>? id, Value<String>? mark}) {
    return SemesterTableCompanion(
      id: id ?? this.id,
      mark: mark ?? this.mark,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (mark.present) {
      map['mark'] = Variable<String>(mark.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('SemesterTableCompanion(')
          ..write('id: $id, ')
          ..write('mark: $mark')
          ..write(')'))
        .toString();
  }
}

class $CourseTableTable extends CourseTable
    with TableInfo<$CourseTableTable, Course> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $CourseTableTable(this.attachedDatabase, [this._alias]);
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: false);
  @override
  late final GeneratedColumn<int> semesterId = GeneratedColumn<int>(
      'semester_id', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: true,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('REFERENCES semester_table (id)'));
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
      'name', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  @override
  late final GeneratedColumn<String> lecturer = GeneratedColumn<String>(
      'lecturer', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  @override
  late final GeneratedColumn<DateTime> date = GeneratedColumn<DateTime>(
      'date', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  @override
  late final GeneratedColumnWithTypeConverter<TimeOfDay, int> startTime =
      GeneratedColumn<int>('start_time', aliasedName, false,
              type: DriftSqlType.int, requiredDuringInsert: true)
          .withConverter<TimeOfDay>($CourseTableTable.$converterstartTime);
  @override
  late final GeneratedColumnWithTypeConverter<TimeOfDay, int> endTime =
      GeneratedColumn<int>('end_time', aliasedName, false,
              type: DriftSqlType.int, requiredDuringInsert: true)
          .withConverter<TimeOfDay>($CourseTableTable.$converterendTime);
  @override
  late final GeneratedColumnWithTypeConverter<Group, int> group =
      GeneratedColumn<int>('group', aliasedName, false,
              type: DriftSqlType.int, requiredDuringInsert: true)
          .withConverter<Group>($CourseTableTable.$convertergroup);
  @override
  late final GeneratedColumn<int> groupNumber = GeneratedColumn<int>(
      'group_number', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  @override
  late final GeneratedColumn<String> location = GeneratedColumn<String>(
      'location', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  @override
  late final GeneratedColumn<int> roomNumber = GeneratedColumn<int>(
      'room_number', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns => [
        id,
        semesterId,
        name,
        lecturer,
        date,
        startTime,
        endTime,
        group,
        groupNumber,
        location,
        roomNumber
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'course_table';
  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Course map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Course(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      semesterId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}semester_id'])!,
      name: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}name'])!,
      date: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}date'])!,
      startTime: $CourseTableTable.$converterstartTime.fromSql(attachedDatabase
          .typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}start_time'])!),
      endTime: $CourseTableTable.$converterendTime.fromSql(attachedDatabase
          .typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}end_time'])!),
      group: $CourseTableTable.$convertergroup.fromSql(attachedDatabase
          .typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}group'])!),
      groupNumber: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}group_number'])!,
      lecturer: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}lecturer'])!,
      location: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}location'])!,
      roomNumber: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}room_number'])!,
    );
  }

  @override
  $CourseTableTable createAlias(String alias) {
    return $CourseTableTable(attachedDatabase, alias);
  }

  static TypeConverter<TimeOfDay, int> $converterstartTime =
      TimeOfDayConverter();
  static TypeConverter<TimeOfDay, int> $converterendTime = TimeOfDayConverter();
  static JsonTypeConverter2<Group, int, int> $convertergroup =
      const EnumIndexConverter<Group>(Group.values);
}

class CourseTableCompanion extends UpdateCompanion<Course> {
  final Value<int> id;
  final Value<int> semesterId;
  final Value<String> name;
  final Value<String> lecturer;
  final Value<DateTime> date;
  final Value<TimeOfDay> startTime;
  final Value<TimeOfDay> endTime;
  final Value<Group> group;
  final Value<int> groupNumber;
  final Value<String> location;
  final Value<int> roomNumber;
  const CourseTableCompanion({
    this.id = const Value.absent(),
    this.semesterId = const Value.absent(),
    this.name = const Value.absent(),
    this.lecturer = const Value.absent(),
    this.date = const Value.absent(),
    this.startTime = const Value.absent(),
    this.endTime = const Value.absent(),
    this.group = const Value.absent(),
    this.groupNumber = const Value.absent(),
    this.location = const Value.absent(),
    this.roomNumber = const Value.absent(),
  });
  CourseTableCompanion.insert({
    this.id = const Value.absent(),
    required int semesterId,
    required String name,
    required String lecturer,
    required DateTime date,
    required TimeOfDay startTime,
    required TimeOfDay endTime,
    required Group group,
    required int groupNumber,
    required String location,
    required int roomNumber,
  })  : semesterId = Value(semesterId),
        name = Value(name),
        lecturer = Value(lecturer),
        date = Value(date),
        startTime = Value(startTime),
        endTime = Value(endTime),
        group = Value(group),
        groupNumber = Value(groupNumber),
        location = Value(location),
        roomNumber = Value(roomNumber);
  static Insertable<Course> custom({
    Expression<int>? id,
    Expression<int>? semesterId,
    Expression<String>? name,
    Expression<String>? lecturer,
    Expression<DateTime>? date,
    Expression<int>? startTime,
    Expression<int>? endTime,
    Expression<int>? group,
    Expression<int>? groupNumber,
    Expression<String>? location,
    Expression<int>? roomNumber,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (semesterId != null) 'semester_id': semesterId,
      if (name != null) 'name': name,
      if (lecturer != null) 'lecturer': lecturer,
      if (date != null) 'date': date,
      if (startTime != null) 'start_time': startTime,
      if (endTime != null) 'end_time': endTime,
      if (group != null) 'group': group,
      if (groupNumber != null) 'group_number': groupNumber,
      if (location != null) 'location': location,
      if (roomNumber != null) 'room_number': roomNumber,
    });
  }

  CourseTableCompanion copyWith(
      {Value<int>? id,
      Value<int>? semesterId,
      Value<String>? name,
      Value<String>? lecturer,
      Value<DateTime>? date,
      Value<TimeOfDay>? startTime,
      Value<TimeOfDay>? endTime,
      Value<Group>? group,
      Value<int>? groupNumber,
      Value<String>? location,
      Value<int>? roomNumber}) {
    return CourseTableCompanion(
      id: id ?? this.id,
      semesterId: semesterId ?? this.semesterId,
      name: name ?? this.name,
      lecturer: lecturer ?? this.lecturer,
      date: date ?? this.date,
      startTime: startTime ?? this.startTime,
      endTime: endTime ?? this.endTime,
      group: group ?? this.group,
      groupNumber: groupNumber ?? this.groupNumber,
      location: location ?? this.location,
      roomNumber: roomNumber ?? this.roomNumber,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (semesterId.present) {
      map['semester_id'] = Variable<int>(semesterId.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (lecturer.present) {
      map['lecturer'] = Variable<String>(lecturer.value);
    }
    if (date.present) {
      map['date'] = Variable<DateTime>(date.value);
    }
    if (startTime.present) {
      map['start_time'] = Variable<int>(
          $CourseTableTable.$converterstartTime.toSql(startTime.value));
    }
    if (endTime.present) {
      map['end_time'] = Variable<int>(
          $CourseTableTable.$converterendTime.toSql(endTime.value));
    }
    if (group.present) {
      map['group'] =
          Variable<int>($CourseTableTable.$convertergroup.toSql(group.value));
    }
    if (groupNumber.present) {
      map['group_number'] = Variable<int>(groupNumber.value);
    }
    if (location.present) {
      map['location'] = Variable<String>(location.value);
    }
    if (roomNumber.present) {
      map['room_number'] = Variable<int>(roomNumber.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('CourseTableCompanion(')
          ..write('id: $id, ')
          ..write('semesterId: $semesterId, ')
          ..write('name: $name, ')
          ..write('lecturer: $lecturer, ')
          ..write('date: $date, ')
          ..write('startTime: $startTime, ')
          ..write('endTime: $endTime, ')
          ..write('group: $group, ')
          ..write('groupNumber: $groupNumber, ')
          ..write('location: $location, ')
          ..write('roomNumber: $roomNumber')
          ..write(')'))
        .toString();
  }
}

abstract class _$CacheDb extends GeneratedDatabase {
  _$CacheDb(QueryExecutor e) : super(e);
  $CacheDbManager get managers => $CacheDbManager(this);
  late final $SemesterTableTable semesterTable = $SemesterTableTable(this);
  late final $CourseTableTable courseTable = $CourseTableTable(this);
  late final Index courseIndexByDateAndSemester = Index(
      'course_index_by_date_and_semester',
      'CREATE INDEX course_index_by_date_and_semester ON course_table (semester_id, date)');
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities =>
      [semesterTable, courseTable, courseIndexByDateAndSemester];
}

typedef $$SemesterTableTableCreateCompanionBuilder = SemesterTableCompanion
    Function({
  Value<int> id,
  required String mark,
});
typedef $$SemesterTableTableUpdateCompanionBuilder = SemesterTableCompanion
    Function({
  Value<int> id,
  Value<String> mark,
});

final class $$SemesterTableTableReferences
    extends BaseReferences<_$CacheDb, $SemesterTableTable, Semester> {
  $$SemesterTableTableReferences(
      super.$_db, super.$_table, super.$_typedResult);

  static MultiTypedResultKey<$CourseTableTable, List<Course>>
      _courseTableRefsTable(_$CacheDb db) =>
          MultiTypedResultKey.fromTable(db.courseTable,
              aliasName: $_aliasNameGenerator(
                  db.semesterTable.id, db.courseTable.semesterId));

  $$CourseTableTableProcessedTableManager get courseTableRefs {
    final manager = $$CourseTableTableTableManager($_db, $_db.courseTable)
        .filter((f) => f.semesterId.id($_item.id));

    final cache = $_typedResult.readTableOrNull(_courseTableRefsTable($_db));
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: cache));
  }
}

class $$SemesterTableTableFilterComposer
    extends FilterComposer<_$CacheDb, $SemesterTableTable> {
  $$SemesterTableTableFilterComposer(super.$state);
  ColumnFilters<int> get id => $state.composableBuilder(
      column: $state.table.id,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get mark => $state.composableBuilder(
      column: $state.table.mark,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ComposableFilter courseTableRefs(
      ComposableFilter Function($$CourseTableTableFilterComposer f) f) {
    final $$CourseTableTableFilterComposer composer = $state.composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $state.db.courseTable,
        getReferencedColumn: (t) => t.semesterId,
        builder: (joinBuilder, parentComposers) =>
            $$CourseTableTableFilterComposer(ComposerState($state.db,
                $state.db.courseTable, joinBuilder, parentComposers)));
    return f(composer);
  }
}

class $$SemesterTableTableOrderingComposer
    extends OrderingComposer<_$CacheDb, $SemesterTableTable> {
  $$SemesterTableTableOrderingComposer(super.$state);
  ColumnOrderings<int> get id => $state.composableBuilder(
      column: $state.table.id,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get mark => $state.composableBuilder(
      column: $state.table.mark,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));
}

class $$SemesterTableTableTableManager extends RootTableManager<
    _$CacheDb,
    $SemesterTableTable,
    Semester,
    $$SemesterTableTableFilterComposer,
    $$SemesterTableTableOrderingComposer,
    $$SemesterTableTableCreateCompanionBuilder,
    $$SemesterTableTableUpdateCompanionBuilder,
    (Semester, $$SemesterTableTableReferences),
    Semester,
    PrefetchHooks Function({bool courseTableRefs})> {
  $$SemesterTableTableTableManager(_$CacheDb db, $SemesterTableTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          filteringComposer:
              $$SemesterTableTableFilterComposer(ComposerState(db, table)),
          orderingComposer:
              $$SemesterTableTableOrderingComposer(ComposerState(db, table)),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<String> mark = const Value.absent(),
          }) =>
              SemesterTableCompanion(
            id: id,
            mark: mark,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required String mark,
          }) =>
              SemesterTableCompanion.insert(
            id: id,
            mark: mark,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (
                    e.readTable(table),
                    $$SemesterTableTableReferences(db, table, e)
                  ))
              .toList(),
          prefetchHooksCallback: ({courseTableRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [if (courseTableRefs) db.courseTable],
              addJoins: null,
              getPrefetchedDataCallback: (items) async {
                return [
                  if (courseTableRefs)
                    await $_getPrefetchedData(
                        currentTable: table,
                        referencedTable: $$SemesterTableTableReferences
                            ._courseTableRefsTable(db),
                        managerFromTypedResult: (p0) =>
                            $$SemesterTableTableReferences(db, table, p0)
                                .courseTableRefs,
                        referencedItemsForCurrentItem:
                            (item, referencedItems) => referencedItems
                                .where((e) => e.semesterId == item.id),
                        typedResults: items)
                ];
              },
            );
          },
        ));
}

typedef $$SemesterTableTableProcessedTableManager = ProcessedTableManager<
    _$CacheDb,
    $SemesterTableTable,
    Semester,
    $$SemesterTableTableFilterComposer,
    $$SemesterTableTableOrderingComposer,
    $$SemesterTableTableCreateCompanionBuilder,
    $$SemesterTableTableUpdateCompanionBuilder,
    (Semester, $$SemesterTableTableReferences),
    Semester,
    PrefetchHooks Function({bool courseTableRefs})>;
typedef $$CourseTableTableCreateCompanionBuilder = CourseTableCompanion
    Function({
  Value<int> id,
  required int semesterId,
  required String name,
  required String lecturer,
  required DateTime date,
  required TimeOfDay startTime,
  required TimeOfDay endTime,
  required Group group,
  required int groupNumber,
  required String location,
  required int roomNumber,
});
typedef $$CourseTableTableUpdateCompanionBuilder = CourseTableCompanion
    Function({
  Value<int> id,
  Value<int> semesterId,
  Value<String> name,
  Value<String> lecturer,
  Value<DateTime> date,
  Value<TimeOfDay> startTime,
  Value<TimeOfDay> endTime,
  Value<Group> group,
  Value<int> groupNumber,
  Value<String> location,
  Value<int> roomNumber,
});

final class $$CourseTableTableReferences
    extends BaseReferences<_$CacheDb, $CourseTableTable, Course> {
  $$CourseTableTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $SemesterTableTable _semesterIdTable(_$CacheDb db) =>
      db.semesterTable.createAlias(
          $_aliasNameGenerator(db.courseTable.semesterId, db.semesterTable.id));

  $$SemesterTableTableProcessedTableManager? get semesterId {
    if ($_item.semesterId == null) return null;
    final manager = $$SemesterTableTableTableManager($_db, $_db.semesterTable)
        .filter((f) => f.id($_item.semesterId!));
    final item = $_typedResult.readTableOrNull(_semesterIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: [item]));
  }
}

class $$CourseTableTableFilterComposer
    extends FilterComposer<_$CacheDb, $CourseTableTable> {
  $$CourseTableTableFilterComposer(super.$state);
  ColumnFilters<int> get id => $state.composableBuilder(
      column: $state.table.id,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get name => $state.composableBuilder(
      column: $state.table.name,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get lecturer => $state.composableBuilder(
      column: $state.table.lecturer,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<DateTime> get date => $state.composableBuilder(
      column: $state.table.date,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnWithTypeConverterFilters<TimeOfDay, TimeOfDay, int> get startTime =>
      $state.composableBuilder(
          column: $state.table.startTime,
          builder: (column, joinBuilders) => ColumnWithTypeConverterFilters(
              column,
              joinBuilders: joinBuilders));

  ColumnWithTypeConverterFilters<TimeOfDay, TimeOfDay, int> get endTime =>
      $state.composableBuilder(
          column: $state.table.endTime,
          builder: (column, joinBuilders) => ColumnWithTypeConverterFilters(
              column,
              joinBuilders: joinBuilders));

  ColumnWithTypeConverterFilters<Group, Group, int> get group =>
      $state.composableBuilder(
          column: $state.table.group,
          builder: (column, joinBuilders) => ColumnWithTypeConverterFilters(
              column,
              joinBuilders: joinBuilders));

  ColumnFilters<int> get groupNumber => $state.composableBuilder(
      column: $state.table.groupNumber,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get location => $state.composableBuilder(
      column: $state.table.location,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<int> get roomNumber => $state.composableBuilder(
      column: $state.table.roomNumber,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  $$SemesterTableTableFilterComposer get semesterId {
    final $$SemesterTableTableFilterComposer composer = $state.composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.semesterId,
        referencedTable: $state.db.semesterTable,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder, parentComposers) =>
            $$SemesterTableTableFilterComposer(ComposerState($state.db,
                $state.db.semesterTable, joinBuilder, parentComposers)));
    return composer;
  }
}

class $$CourseTableTableOrderingComposer
    extends OrderingComposer<_$CacheDb, $CourseTableTable> {
  $$CourseTableTableOrderingComposer(super.$state);
  ColumnOrderings<int> get id => $state.composableBuilder(
      column: $state.table.id,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get name => $state.composableBuilder(
      column: $state.table.name,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get lecturer => $state.composableBuilder(
      column: $state.table.lecturer,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<DateTime> get date => $state.composableBuilder(
      column: $state.table.date,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<int> get startTime => $state.composableBuilder(
      column: $state.table.startTime,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<int> get endTime => $state.composableBuilder(
      column: $state.table.endTime,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<int> get group => $state.composableBuilder(
      column: $state.table.group,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<int> get groupNumber => $state.composableBuilder(
      column: $state.table.groupNumber,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get location => $state.composableBuilder(
      column: $state.table.location,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<int> get roomNumber => $state.composableBuilder(
      column: $state.table.roomNumber,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  $$SemesterTableTableOrderingComposer get semesterId {
    final $$SemesterTableTableOrderingComposer composer =
        $state.composerBuilder(
            composer: this,
            getCurrentColumn: (t) => t.semesterId,
            referencedTable: $state.db.semesterTable,
            getReferencedColumn: (t) => t.id,
            builder: (joinBuilder, parentComposers) =>
                $$SemesterTableTableOrderingComposer(ComposerState($state.db,
                    $state.db.semesterTable, joinBuilder, parentComposers)));
    return composer;
  }
}

class $$CourseTableTableTableManager extends RootTableManager<
    _$CacheDb,
    $CourseTableTable,
    Course,
    $$CourseTableTableFilterComposer,
    $$CourseTableTableOrderingComposer,
    $$CourseTableTableCreateCompanionBuilder,
    $$CourseTableTableUpdateCompanionBuilder,
    (Course, $$CourseTableTableReferences),
    Course,
    PrefetchHooks Function({bool semesterId})> {
  $$CourseTableTableTableManager(_$CacheDb db, $CourseTableTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          filteringComposer:
              $$CourseTableTableFilterComposer(ComposerState(db, table)),
          orderingComposer:
              $$CourseTableTableOrderingComposer(ComposerState(db, table)),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<int> semesterId = const Value.absent(),
            Value<String> name = const Value.absent(),
            Value<String> lecturer = const Value.absent(),
            Value<DateTime> date = const Value.absent(),
            Value<TimeOfDay> startTime = const Value.absent(),
            Value<TimeOfDay> endTime = const Value.absent(),
            Value<Group> group = const Value.absent(),
            Value<int> groupNumber = const Value.absent(),
            Value<String> location = const Value.absent(),
            Value<int> roomNumber = const Value.absent(),
          }) =>
              CourseTableCompanion(
            id: id,
            semesterId: semesterId,
            name: name,
            lecturer: lecturer,
            date: date,
            startTime: startTime,
            endTime: endTime,
            group: group,
            groupNumber: groupNumber,
            location: location,
            roomNumber: roomNumber,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required int semesterId,
            required String name,
            required String lecturer,
            required DateTime date,
            required TimeOfDay startTime,
            required TimeOfDay endTime,
            required Group group,
            required int groupNumber,
            required String location,
            required int roomNumber,
          }) =>
              CourseTableCompanion.insert(
            id: id,
            semesterId: semesterId,
            name: name,
            lecturer: lecturer,
            date: date,
            startTime: startTime,
            endTime: endTime,
            group: group,
            groupNumber: groupNumber,
            location: location,
            roomNumber: roomNumber,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (
                    e.readTable(table),
                    $$CourseTableTableReferences(db, table, e)
                  ))
              .toList(),
          prefetchHooksCallback: ({semesterId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins: <
                  T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic>>(state) {
                if (semesterId) {
                  state = state.withJoin(
                    currentTable: table,
                    currentColumn: table.semesterId,
                    referencedTable:
                        $$CourseTableTableReferences._semesterIdTable(db),
                    referencedColumn:
                        $$CourseTableTableReferences._semesterIdTable(db).id,
                  ) as T;
                }

                return state;
              },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ));
}

typedef $$CourseTableTableProcessedTableManager = ProcessedTableManager<
    _$CacheDb,
    $CourseTableTable,
    Course,
    $$CourseTableTableFilterComposer,
    $$CourseTableTableOrderingComposer,
    $$CourseTableTableCreateCompanionBuilder,
    $$CourseTableTableUpdateCompanionBuilder,
    (Course, $$CourseTableTableReferences),
    Course,
    PrefetchHooks Function({bool semesterId})>;

class $CacheDbManager {
  final _$CacheDb _db;
  $CacheDbManager(this._db);
  $$SemesterTableTableTableManager get semesterTable =>
      $$SemesterTableTableTableManager(_db, _db.semesterTable);
  $$CourseTableTableTableManager get courseTable =>
      $$CourseTableTableTableManager(_db, _db.courseTable);
}
