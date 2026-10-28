/* AUTOMATICALLY GENERATED CODE DO NOT MODIFY */
/*   To generate run: "serverpod generate"    */

// ignore_for_file: implementation_imports
// ignore_for_file: library_private_types_in_public_api
// ignore_for_file: non_constant_identifier_names
// ignore_for_file: public_member_api_docs
// ignore_for_file: type_literal_in_constant_pattern
// ignore_for_file: use_super_parameters
// ignore_for_file: invalid_use_of_internal_member

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:campusconnect_server/src/generated/protocol.dart' as _iusjeinx;
import 'package:serverpod/serverpod.dart' as _is;

abstract class StudyPreferences
    implements _is.TableRow<int?>, _is.ProtocolSerialization {
  StudyPreferences._({
    this.id,
    required this.studentId,
    required this.subjects,
    required this.technicalInterests,
    required this.preferredTimings,
    required this.studyMode,
    required this.learningGoals,
    required this.skillLevel,
    required this.updatedAt,
  });

  factory StudyPreferences({
    int? id,
    required int studentId,
    required List<String> subjects,
    required List<String> technicalInterests,
    required List<String> preferredTimings,
    required String studyMode,
    required List<String> learningGoals,
    required String skillLevel,
    required DateTime updatedAt,
  }) = _StudyPreferencesImpl;

  factory StudyPreferences.fromJson(Map<String, dynamic> jsonSerialization) {
    return StudyPreferences(
      id: jsonSerialization['id'] as int?,
      studentId: jsonSerialization['studentId'] as int,
      subjects: _iusjeinx.Protocol().deserialize<List<String>>(
        jsonSerialization['subjects'],
      ),
      technicalInterests: _iusjeinx.Protocol().deserialize<List<String>>(
        jsonSerialization['technicalInterests'],
      ),
      preferredTimings: _iusjeinx.Protocol().deserialize<List<String>>(
        jsonSerialization['preferredTimings'],
      ),
      studyMode: jsonSerialization['studyMode'] as String,
      learningGoals: _iusjeinx.Protocol().deserialize<List<String>>(
        jsonSerialization['learningGoals'],
      ),
      skillLevel: jsonSerialization['skillLevel'] as String,
      updatedAt: _is.DateTimeJsonExtension.fromJson(
        jsonSerialization['updatedAt'],
      ),
    );
  }

  static final t = StudyPreferencesTable();

  static const db = StudyPreferencesRepository._();

  @override
  int? id;

  int studentId;

  List<String> subjects;

  List<String> technicalInterests;

  List<String> preferredTimings;

  String studyMode;

  List<String> learningGoals;

  String skillLevel;

  DateTime updatedAt;

  @override
  _is.Table<int?> get table => t;

  /// Returns a shallow copy of this [StudyPreferences]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  StudyPreferences copyWith({
    int? id,
    int? studentId,
    List<String>? subjects,
    List<String>? technicalInterests,
    List<String>? preferredTimings,
    String? studyMode,
    List<String>? learningGoals,
    String? skillLevel,
    DateTime? updatedAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'StudyPreferences',
      if (id != null) 'id': id,
      'studentId': studentId,
      'subjects': subjects.toJson(),
      'technicalInterests': technicalInterests.toJson(),
      'preferredTimings': preferredTimings.toJson(),
      'studyMode': studyMode,
      'learningGoals': learningGoals.toJson(),
      'skillLevel': skillLevel,
      'updatedAt': updatedAt.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'StudyPreferences',
      if (id != null) 'id': id,
      'studentId': studentId,
      'subjects': subjects.toJson(),
      'technicalInterests': technicalInterests.toJson(),
      'preferredTimings': preferredTimings.toJson(),
      'studyMode': studyMode,
      'learningGoals': learningGoals.toJson(),
      'skillLevel': skillLevel,
      'updatedAt': updatedAt.toJson(),
    };
  }

  static StudyPreferencesInclude include() {
    return StudyPreferencesInclude._();
  }

  static StudyPreferencesIncludeList includeList({
    _is.WhereExpressionBuilder<StudyPreferencesTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<StudyPreferencesTable>? orderBy,
    _is.OrderByListBuilder<StudyPreferencesTable>? orderByList,
    StudyPreferencesInclude? include,
  }) {
    return StudyPreferencesIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(StudyPreferences.t),
      orderByList: orderByList?.call(StudyPreferences.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _is.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _StudyPreferencesImpl extends StudyPreferences {
  _StudyPreferencesImpl({
    int? id,
    required int studentId,
    required List<String> subjects,
    required List<String> technicalInterests,
    required List<String> preferredTimings,
    required String studyMode,
    required List<String> learningGoals,
    required String skillLevel,
    required DateTime updatedAt,
  }) : super._(
         id: id,
         studentId: studentId,
         subjects: subjects,
         technicalInterests: technicalInterests,
         preferredTimings: preferredTimings,
         studyMode: studyMode,
         learningGoals: learningGoals,
         skillLevel: skillLevel,
         updatedAt: updatedAt,
       );

  /// Returns a shallow copy of this [StudyPreferences]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  @override
  StudyPreferences copyWith({
    Object? id = _Undefined,
    int? studentId,
    List<String>? subjects,
    List<String>? technicalInterests,
    List<String>? preferredTimings,
    String? studyMode,
    List<String>? learningGoals,
    String? skillLevel,
    DateTime? updatedAt,
  }) {
    return StudyPreferences(
      id: id is int? ? id : this.id,
      studentId: studentId ?? this.studentId,
      subjects: subjects ?? this.subjects.map((e0) => e0).toList(),
      technicalInterests:
          technicalInterests ??
          this.technicalInterests.map((e0) => e0).toList(),
      preferredTimings:
          preferredTimings ?? this.preferredTimings.map((e0) => e0).toList(),
      studyMode: studyMode ?? this.studyMode,
      learningGoals:
          learningGoals ?? this.learningGoals.map((e0) => e0).toList(),
      skillLevel: skillLevel ?? this.skillLevel,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}

class StudyPreferencesUpdateTable
    extends _is.UpdateTable<StudyPreferencesTable> {
  StudyPreferencesUpdateTable(super.table);

  _is.ColumnValue<int, int> studentId(int value) => _is.ColumnValue(
    table.studentId,
    value,
  );

  _is.ColumnValue<List<String>, List<String>> subjects(List<String> value) =>
      _is.ColumnValue(
        table.subjects,
        value,
      );

  _is.ColumnValue<List<String>, List<String>> technicalInterests(
    List<String> value,
  ) => _is.ColumnValue(
    table.technicalInterests,
    value,
  );

  _is.ColumnValue<List<String>, List<String>> preferredTimings(
    List<String> value,
  ) => _is.ColumnValue(
    table.preferredTimings,
    value,
  );

  _is.ColumnValue<String, String> studyMode(String value) => _is.ColumnValue(
    table.studyMode,
    value,
  );

  _is.ColumnValue<List<String>, List<String>> learningGoals(
    List<String> value,
  ) => _is.ColumnValue(
    table.learningGoals,
    value,
  );

  _is.ColumnValue<String, String> skillLevel(String value) => _is.ColumnValue(
    table.skillLevel,
    value,
  );

  _is.ColumnValue<DateTime, DateTime> updatedAt(DateTime value) =>
      _is.ColumnValue(
        table.updatedAt,
        value,
      );
}

class StudyPreferencesTable extends _is.Table<int?> {
  StudyPreferencesTable({super.tableRelation})
    : super(tableName: 'study_preferences') {
    updateTable = StudyPreferencesUpdateTable(this);
    studentId = _is.ColumnInt(
      'studentId',
      this,
    );
    subjects = _is.ColumnSerializable<List<String>>(
      'subjects',
      this,
    );
    technicalInterests = _is.ColumnSerializable<List<String>>(
      'technicalInterests',
      this,
    );
    preferredTimings = _is.ColumnSerializable<List<String>>(
      'preferredTimings',
      this,
    );
    studyMode = _is.ColumnString(
      'studyMode',
      this,
    );
    learningGoals = _is.ColumnSerializable<List<String>>(
      'learningGoals',
      this,
    );
    skillLevel = _is.ColumnString(
      'skillLevel',
      this,
    );
    updatedAt = _is.ColumnDateTime(
      'updatedAt',
      this,
    );
  }

  late final StudyPreferencesUpdateTable updateTable;

  late final _is.ColumnInt studentId;

  late final _is.ColumnSerializable<List<String>> subjects;

  late final _is.ColumnSerializable<List<String>> technicalInterests;

  late final _is.ColumnSerializable<List<String>> preferredTimings;

  late final _is.ColumnString studyMode;

  late final _is.ColumnSerializable<List<String>> learningGoals;

  late final _is.ColumnString skillLevel;

  late final _is.ColumnDateTime updatedAt;

  @override
  List<_is.Column> get columns => [
    id,
    studentId,
    subjects,
    technicalInterests,
    preferredTimings,
    studyMode,
    learningGoals,
    skillLevel,
    updatedAt,
  ];
}

class StudyPreferencesInclude extends _is.IncludeObject {
  StudyPreferencesInclude._();

  @override
  Map<String, _is.Include?> get includes => {};

  @override
  _is.Table<int?> get table => StudyPreferences.t;
}

class StudyPreferencesIncludeList extends _is.IncludeList {
  StudyPreferencesIncludeList._({
    _is.WhereExpressionBuilder<StudyPreferencesTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(StudyPreferences.t);
  }

  @override
  Map<String, _is.Include?> get includes => include?.includes ?? {};

  @override
  _is.Table<int?> get table => StudyPreferences.t;
}

class StudyPreferencesRepository {
  const StudyPreferencesRepository._();

  /// Returns a list of [StudyPreferences]s matching the given query parameters.
  ///
  /// Use [where] to specify which items to include in the return value.
  /// If none is specified, all items will be returned.
  ///
  /// To specify the order of the items use [orderBy] or [orderByList]
  /// when sorting by multiple columns.
  ///
  /// The maximum number of items can be set by [limit]. If no limit is set,
  /// all items matching the query will be returned.
  ///
  /// [offset] defines how many items to skip, after which [limit] (or all)
  /// items are read from the database.
  ///
  /// ```dart
  /// var persons = await Persons.db.find(
  ///   session,
  ///   where: (t) => t.lastName.equals('Jones'),
  ///   orderBy: (t) => t.firstName,
  ///   limit: 100,
  /// );
  /// ```
  Future<List<StudyPreferences>> find(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<StudyPreferencesTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<StudyPreferencesTable>? orderBy,
    _is.OrderByListBuilder<StudyPreferencesTable>? orderByList,
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.find<StudyPreferences>(
      where: where?.call(StudyPreferences.t),
      orderBy: orderBy?.call(StudyPreferences.t),
      orderByList: orderByList?.call(StudyPreferences.t),
      limit: limit,
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Returns the first matching [StudyPreferences] matching the given query parameters.
  ///
  /// Use [where] to specify which items to include in the return value.
  /// If none is specified, all items will be returned.
  ///
  /// To specify the order use [orderBy] or [orderByList]
  /// when sorting by multiple columns.
  ///
  /// [offset] defines how many items to skip, after which the next one will be picked.
  ///
  /// ```dart
  /// var youngestPerson = await Persons.db.findFirstRow(
  ///   session,
  ///   where: (t) => t.lastName.equals('Jones'),
  ///   orderBy: (t) => t.age,
  /// );
  /// ```
  Future<StudyPreferences?> findFirstRow(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<StudyPreferencesTable>? where,
    int? offset,
    _is.OrderByBuilder<StudyPreferencesTable>? orderBy,
    _is.OrderByListBuilder<StudyPreferencesTable>? orderByList,
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findFirstRow<StudyPreferences>(
      where: where?.call(StudyPreferences.t),
      orderBy: orderBy?.call(StudyPreferences.t),
      orderByList: orderByList?.call(StudyPreferences.t),
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Finds a single [StudyPreferences] by its [id] or null if no such row exists.
  Future<StudyPreferences?> findById(
    _is.DatabaseSession session,
    int id, {
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findById<StudyPreferences>(
      id,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Inserts all [StudyPreferences]s in the list and returns the inserted rows.
  ///
  /// The returned [StudyPreferences]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// insert, none of the rows will be inserted.
  ///
  /// If [ignoreConflicts] is set to `true`, rows that conflict with existing
  /// rows are silently skipped, and only the successfully inserted rows are
  /// returned.
  ///
  /// If [noReturn] is set to `true`, the inserted rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<StudyPreferences>> insert(
    _is.DatabaseSession session,
    List<StudyPreferences> rows, {
    _is.Transaction? transaction,
    bool ignoreConflicts = false,
    bool noReturn = false,
  }) async {
    return session.db.insert<StudyPreferences>(
      rows,
      transaction: transaction,
      ignoreConflicts: ignoreConflicts,
      noReturn: noReturn,
    );
  }

  /// Inserts a single [StudyPreferences] and returns the inserted row.
  ///
  /// The returned [StudyPreferences] will have its `id` field set.
  Future<StudyPreferences> insertRow(
    _is.DatabaseSession session,
    StudyPreferences row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.insertRow<StudyPreferences>(
      row,
      transaction: transaction,
    );
  }

  /// Upserts all [StudyPreferences]s in the list and returns the resulting rows.
  ///
  /// If a row conflicts on the given [conflictColumns], the existing row is
  /// updated with the new values. Otherwise, a new row is inserted.
  ///
  /// If [updateColumns] is provided, only those columns will be updated on
  /// conflict. If null, all non-conflict, non-id columns are updated.
  ///
  /// If [updateWhere] is provided, the update only applies to rows matching the
  /// given expression. Conflicting rows that don't match are skipped and not
  /// returned, so the resulting list may be shorter than [rows].
  ///
  /// The returned [StudyPreferences]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails,
  /// none of the rows will be affected.
  ///
  /// If [noReturn] is set to `true`, the resulting rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<StudyPreferences>> upsert(
    _is.DatabaseSession session,
    List<StudyPreferences> rows, {
    required _is.ColumnSelections<StudyPreferencesTable> conflictColumns,
    _is.ColumnSelections<StudyPreferencesTable>? updateColumns,
    _is.WhereExpressionBuilder<StudyPreferencesTable>? updateWhere,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.upsert<StudyPreferences>(
      rows,
      conflictColumns: conflictColumns(StudyPreferences.t),
      updateColumns: updateColumns?.call(StudyPreferences.t),
      updateWhere: updateWhere?.call(StudyPreferences.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Upserts a single [StudyPreferences] and returns the resulting row.
  ///
  /// If the row conflicts on the given [conflictColumns], the existing row is
  /// updated. Otherwise, a new row is inserted.
  ///
  /// If [updateColumns] is provided, only those columns will be updated on
  /// conflict. If null, all non-conflict, non-id columns are updated.
  ///
  /// If [updateWhere] is provided, the update only applies when the existing
  /// row matches the expression. Returns `null` if no row was affected — for
  /// example when [updateWhere] does not match the conflicting row.
  ///
  /// The returned [StudyPreferences] will have its `id` field set.
  Future<StudyPreferences?> upsertRow(
    _is.DatabaseSession session,
    StudyPreferences row, {
    required _is.ColumnSelections<StudyPreferencesTable> conflictColumns,
    _is.ColumnSelections<StudyPreferencesTable>? updateColumns,
    _is.WhereExpressionBuilder<StudyPreferencesTable>? updateWhere,
    _is.Transaction? transaction,
  }) async {
    return session.db.upsertRow<StudyPreferences>(
      row,
      conflictColumns: conflictColumns(StudyPreferences.t),
      updateColumns: updateColumns?.call(StudyPreferences.t),
      updateWhere: updateWhere?.call(StudyPreferences.t),
      transaction: transaction,
    );
  }

  /// Updates all [StudyPreferences]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<StudyPreferences>> update(
    _is.DatabaseSession session,
    List<StudyPreferences> rows, {
    _is.ColumnSelections<StudyPreferencesTable>? columns,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.update<StudyPreferences>(
      rows,
      columns: columns?.call(StudyPreferences.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Updates a single [StudyPreferences]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<StudyPreferences> updateRow(
    _is.DatabaseSession session,
    StudyPreferences row, {
    _is.ColumnSelections<StudyPreferencesTable>? columns,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateRow<StudyPreferences>(
      row,
      columns: columns?.call(StudyPreferences.t),
      transaction: transaction,
    );
  }

  /// Updates a single [StudyPreferences] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<StudyPreferences?> updateById(
    _is.DatabaseSession session,
    int id, {
    required _is.ColumnValueListBuilder<StudyPreferencesUpdateTable>
    columnValues,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateById<StudyPreferences>(
      id,
      columnValues: columnValues(StudyPreferences.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [StudyPreferences]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<StudyPreferences>> updateWhere(
    _is.DatabaseSession session, {
    required _is.ColumnValueListBuilder<StudyPreferencesUpdateTable>
    columnValues,
    required _is.WhereExpressionBuilder<StudyPreferencesTable> where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<StudyPreferencesTable>? orderBy,
    _is.OrderByListBuilder<StudyPreferencesTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.updateWhere<StudyPreferences>(
      columnValues: columnValues(StudyPreferences.t.updateTable),
      where: where(StudyPreferences.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(StudyPreferences.t),
      orderByList: orderByList?.call(StudyPreferences.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes all [StudyPreferences]s in the list and returns the deleted rows.
  ///
  /// To specify the order of the returned rows use [orderBy] or [orderByList]
  /// when sorting by multiple columns.
  ///
  /// This is an atomic operation, meaning that if one of the rows fail to
  /// be deleted, none of the rows will be deleted.
  ///
  /// If [noReturn] is set to `true`, the deleted rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<StudyPreferences>> delete(
    _is.DatabaseSession session,
    List<StudyPreferences> rows, {
    _is.OrderByBuilder<StudyPreferencesTable>? orderBy,
    _is.OrderByListBuilder<StudyPreferencesTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.delete<StudyPreferences>(
      rows,
      orderBy: orderBy?.call(StudyPreferences.t),
      orderByList: orderByList?.call(StudyPreferences.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes a single [StudyPreferences].
  Future<StudyPreferences> deleteRow(
    _is.DatabaseSession session,
    StudyPreferences row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.deleteRow<StudyPreferences>(
      row,
      transaction: transaction,
    );
  }

  /// Deletes all rows matching the [where] expression.
  ///
  /// To specify the order of the returned rows use [orderBy] or [orderByList]
  /// when sorting by multiple columns.
  ///
  /// If [noReturn] is set to `true`, the deleted rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<StudyPreferences>> deleteWhere(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<StudyPreferencesTable> where,
    _is.OrderByBuilder<StudyPreferencesTable>? orderBy,
    _is.OrderByListBuilder<StudyPreferencesTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.deleteWhere<StudyPreferences>(
      where: where(StudyPreferences.t),
      orderBy: orderBy?.call(StudyPreferences.t),
      orderByList: orderByList?.call(StudyPreferences.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<StudyPreferencesTable>? where,
    int? limit,
    _is.Transaction? transaction,
  }) async {
    return session.db.count<StudyPreferences>(
      where: where?.call(StudyPreferences.t),
      limit: limit,
      transaction: transaction,
    );
  }

  /// Acquires row-level locks on [StudyPreferences] rows matching the [where] expression.
  Future<void> lockRows(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<StudyPreferencesTable> where,
    required _is.LockMode lockMode,
    required _is.Transaction transaction,
    _is.LockBehavior lockBehavior = _is.LockBehavior.wait,
  }) async {
    return session.db.lockRows<StudyPreferences>(
      where: where(StudyPreferences.t),
      lockMode: lockMode,
      lockBehavior: lockBehavior,
      transaction: transaction,
    );
  }
}
