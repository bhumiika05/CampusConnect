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
import 'package:serverpod/serverpod.dart' as _is;

abstract class EventBookmark
    implements _is.TableRow<int?>, _is.ProtocolSerialization {
  EventBookmark._({
    this.id,
    required this.studentId,
    required this.eventId,
    required this.createdAt,
  });

  factory EventBookmark({
    int? id,
    required int studentId,
    required int eventId,
    required DateTime createdAt,
  }) = _EventBookmarkImpl;

  factory EventBookmark.fromJson(Map<String, dynamic> jsonSerialization) {
    return EventBookmark(
      id: jsonSerialization['id'] as int?,
      studentId: jsonSerialization['studentId'] as int,
      eventId: jsonSerialization['eventId'] as int,
      createdAt: _is.DateTimeJsonExtension.fromJson(
        jsonSerialization['createdAt'],
      ),
    );
  }

  static final t = EventBookmarkTable();

  static const db = EventBookmarkRepository._();

  @override
  int? id;

  int studentId;

  int eventId;

  DateTime createdAt;

  @override
  _is.Table<int?> get table => t;

  /// Returns a shallow copy of this [EventBookmark]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  EventBookmark copyWith({
    int? id,
    int? studentId,
    int? eventId,
    DateTime? createdAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'EventBookmark',
      if (id != null) 'id': id,
      'studentId': studentId,
      'eventId': eventId,
      'createdAt': createdAt.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'EventBookmark',
      if (id != null) 'id': id,
      'studentId': studentId,
      'eventId': eventId,
      'createdAt': createdAt.toJson(),
    };
  }

  static EventBookmarkInclude include() {
    return EventBookmarkInclude._();
  }

  static EventBookmarkIncludeList includeList({
    _is.WhereExpressionBuilder<EventBookmarkTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<EventBookmarkTable>? orderBy,
    _is.OrderByListBuilder<EventBookmarkTable>? orderByList,
    EventBookmarkInclude? include,
  }) {
    return EventBookmarkIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(EventBookmark.t),
      orderByList: orderByList?.call(EventBookmark.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _is.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _EventBookmarkImpl extends EventBookmark {
  _EventBookmarkImpl({
    int? id,
    required int studentId,
    required int eventId,
    required DateTime createdAt,
  }) : super._(
         id: id,
         studentId: studentId,
         eventId: eventId,
         createdAt: createdAt,
       );

  /// Returns a shallow copy of this [EventBookmark]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  @override
  EventBookmark copyWith({
    Object? id = _Undefined,
    int? studentId,
    int? eventId,
    DateTime? createdAt,
  }) {
    return EventBookmark(
      id: id is int? ? id : this.id,
      studentId: studentId ?? this.studentId,
      eventId: eventId ?? this.eventId,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}

class EventBookmarkUpdateTable extends _is.UpdateTable<EventBookmarkTable> {
  EventBookmarkUpdateTable(super.table);

  _is.ColumnValue<int, int> studentId(int value) => _is.ColumnValue(
    table.studentId,
    value,
  );

  _is.ColumnValue<int, int> eventId(int value) => _is.ColumnValue(
    table.eventId,
    value,
  );

  _is.ColumnValue<DateTime, DateTime> createdAt(DateTime value) =>
      _is.ColumnValue(
        table.createdAt,
        value,
      );
}

class EventBookmarkTable extends _is.Table<int?> {
  EventBookmarkTable({super.tableRelation})
    : super(tableName: 'event_bookmark') {
    updateTable = EventBookmarkUpdateTable(this);
    studentId = _is.ColumnInt(
      'studentId',
      this,
    );
    eventId = _is.ColumnInt(
      'eventId',
      this,
    );
    createdAt = _is.ColumnDateTime(
      'createdAt',
      this,
    );
  }

  late final EventBookmarkUpdateTable updateTable;

  late final _is.ColumnInt studentId;

  late final _is.ColumnInt eventId;

  late final _is.ColumnDateTime createdAt;

  @override
  List<_is.Column> get columns => [
    id,
    studentId,
    eventId,
    createdAt,
  ];
}

class EventBookmarkInclude extends _is.IncludeObject {
  EventBookmarkInclude._();

  @override
  Map<String, _is.Include?> get includes => {};

  @override
  _is.Table<int?> get table => EventBookmark.t;
}

class EventBookmarkIncludeList extends _is.IncludeList {
  EventBookmarkIncludeList._({
    _is.WhereExpressionBuilder<EventBookmarkTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(EventBookmark.t);
  }

  @override
  Map<String, _is.Include?> get includes => include?.includes ?? {};

  @override
  _is.Table<int?> get table => EventBookmark.t;
}

class EventBookmarkRepository {
  const EventBookmarkRepository._();

  /// Returns a list of [EventBookmark]s matching the given query parameters.
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
  Future<List<EventBookmark>> find(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<EventBookmarkTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<EventBookmarkTable>? orderBy,
    _is.OrderByListBuilder<EventBookmarkTable>? orderByList,
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.find<EventBookmark>(
      where: where?.call(EventBookmark.t),
      orderBy: orderBy?.call(EventBookmark.t),
      orderByList: orderByList?.call(EventBookmark.t),
      limit: limit,
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Returns the first matching [EventBookmark] matching the given query parameters.
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
  Future<EventBookmark?> findFirstRow(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<EventBookmarkTable>? where,
    int? offset,
    _is.OrderByBuilder<EventBookmarkTable>? orderBy,
    _is.OrderByListBuilder<EventBookmarkTable>? orderByList,
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findFirstRow<EventBookmark>(
      where: where?.call(EventBookmark.t),
      orderBy: orderBy?.call(EventBookmark.t),
      orderByList: orderByList?.call(EventBookmark.t),
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Finds a single [EventBookmark] by its [id] or null if no such row exists.
  Future<EventBookmark?> findById(
    _is.DatabaseSession session,
    int id, {
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findById<EventBookmark>(
      id,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Inserts all [EventBookmark]s in the list and returns the inserted rows.
  ///
  /// The returned [EventBookmark]s will have their `id` fields set.
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
  Future<List<EventBookmark>> insert(
    _is.DatabaseSession session,
    List<EventBookmark> rows, {
    _is.Transaction? transaction,
    bool ignoreConflicts = false,
    bool noReturn = false,
  }) async {
    return session.db.insert<EventBookmark>(
      rows,
      transaction: transaction,
      ignoreConflicts: ignoreConflicts,
      noReturn: noReturn,
    );
  }

  /// Inserts a single [EventBookmark] and returns the inserted row.
  ///
  /// The returned [EventBookmark] will have its `id` field set.
  Future<EventBookmark> insertRow(
    _is.DatabaseSession session,
    EventBookmark row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.insertRow<EventBookmark>(
      row,
      transaction: transaction,
    );
  }

  /// Upserts all [EventBookmark]s in the list and returns the resulting rows.
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
  /// The returned [EventBookmark]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails,
  /// none of the rows will be affected.
  ///
  /// If [noReturn] is set to `true`, the resulting rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<EventBookmark>> upsert(
    _is.DatabaseSession session,
    List<EventBookmark> rows, {
    required _is.ColumnSelections<EventBookmarkTable> conflictColumns,
    _is.ColumnSelections<EventBookmarkTable>? updateColumns,
    _is.WhereExpressionBuilder<EventBookmarkTable>? updateWhere,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.upsert<EventBookmark>(
      rows,
      conflictColumns: conflictColumns(EventBookmark.t),
      updateColumns: updateColumns?.call(EventBookmark.t),
      updateWhere: updateWhere?.call(EventBookmark.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Upserts a single [EventBookmark] and returns the resulting row.
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
  /// The returned [EventBookmark] will have its `id` field set.
  Future<EventBookmark?> upsertRow(
    _is.DatabaseSession session,
    EventBookmark row, {
    required _is.ColumnSelections<EventBookmarkTable> conflictColumns,
    _is.ColumnSelections<EventBookmarkTable>? updateColumns,
    _is.WhereExpressionBuilder<EventBookmarkTable>? updateWhere,
    _is.Transaction? transaction,
  }) async {
    return session.db.upsertRow<EventBookmark>(
      row,
      conflictColumns: conflictColumns(EventBookmark.t),
      updateColumns: updateColumns?.call(EventBookmark.t),
      updateWhere: updateWhere?.call(EventBookmark.t),
      transaction: transaction,
    );
  }

  /// Updates all [EventBookmark]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<EventBookmark>> update(
    _is.DatabaseSession session,
    List<EventBookmark> rows, {
    _is.ColumnSelections<EventBookmarkTable>? columns,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.update<EventBookmark>(
      rows,
      columns: columns?.call(EventBookmark.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Updates a single [EventBookmark]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<EventBookmark> updateRow(
    _is.DatabaseSession session,
    EventBookmark row, {
    _is.ColumnSelections<EventBookmarkTable>? columns,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateRow<EventBookmark>(
      row,
      columns: columns?.call(EventBookmark.t),
      transaction: transaction,
    );
  }

  /// Updates a single [EventBookmark] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<EventBookmark?> updateById(
    _is.DatabaseSession session,
    int id, {
    required _is.ColumnValueListBuilder<EventBookmarkUpdateTable> columnValues,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateById<EventBookmark>(
      id,
      columnValues: columnValues(EventBookmark.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [EventBookmark]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<EventBookmark>> updateWhere(
    _is.DatabaseSession session, {
    required _is.ColumnValueListBuilder<EventBookmarkUpdateTable> columnValues,
    required _is.WhereExpressionBuilder<EventBookmarkTable> where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<EventBookmarkTable>? orderBy,
    _is.OrderByListBuilder<EventBookmarkTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.updateWhere<EventBookmark>(
      columnValues: columnValues(EventBookmark.t.updateTable),
      where: where(EventBookmark.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(EventBookmark.t),
      orderByList: orderByList?.call(EventBookmark.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes all [EventBookmark]s in the list and returns the deleted rows.
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
  Future<List<EventBookmark>> delete(
    _is.DatabaseSession session,
    List<EventBookmark> rows, {
    _is.OrderByBuilder<EventBookmarkTable>? orderBy,
    _is.OrderByListBuilder<EventBookmarkTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.delete<EventBookmark>(
      rows,
      orderBy: orderBy?.call(EventBookmark.t),
      orderByList: orderByList?.call(EventBookmark.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes a single [EventBookmark].
  Future<EventBookmark> deleteRow(
    _is.DatabaseSession session,
    EventBookmark row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.deleteRow<EventBookmark>(
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
  Future<List<EventBookmark>> deleteWhere(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<EventBookmarkTable> where,
    _is.OrderByBuilder<EventBookmarkTable>? orderBy,
    _is.OrderByListBuilder<EventBookmarkTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.deleteWhere<EventBookmark>(
      where: where(EventBookmark.t),
      orderBy: orderBy?.call(EventBookmark.t),
      orderByList: orderByList?.call(EventBookmark.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<EventBookmarkTable>? where,
    int? limit,
    _is.Transaction? transaction,
  }) async {
    return session.db.count<EventBookmark>(
      where: where?.call(EventBookmark.t),
      limit: limit,
      transaction: transaction,
    );
  }

  /// Acquires row-level locks on [EventBookmark] rows matching the [where] expression.
  Future<void> lockRows(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<EventBookmarkTable> where,
    required _is.LockMode lockMode,
    required _is.Transaction transaction,
    _is.LockBehavior lockBehavior = _is.LockBehavior.wait,
  }) async {
    return session.db.lockRows<EventBookmark>(
      where: where(EventBookmark.t),
      lockMode: lockMode,
      lockBehavior: lockBehavior,
      transaction: transaction,
    );
  }
}
