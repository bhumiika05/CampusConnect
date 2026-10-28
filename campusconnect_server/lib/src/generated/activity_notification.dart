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

abstract class ActivityNotification
    implements _is.TableRow<int?>, _is.ProtocolSerialization {
  ActivityNotification._({
    this.id,
    required this.recipientId,
    required this.activityType,
    required this.title,
    required this.message,
    required this.isRead,
    required this.createdAt,
  });

  factory ActivityNotification({
    int? id,
    required int recipientId,
    required String activityType,
    required String title,
    required String message,
    required bool isRead,
    required DateTime createdAt,
  }) = _ActivityNotificationImpl;

  factory ActivityNotification.fromJson(
    Map<String, dynamic> jsonSerialization,
  ) {
    return ActivityNotification(
      id: jsonSerialization['id'] as int?,
      recipientId: jsonSerialization['recipientId'] as int,
      activityType: jsonSerialization['activityType'] as String,
      title: jsonSerialization['title'] as String,
      message: jsonSerialization['message'] as String,
      isRead: _is.BoolJsonExtension.fromJson(jsonSerialization['isRead']),
      createdAt: _is.DateTimeJsonExtension.fromJson(
        jsonSerialization['createdAt'],
      ),
    );
  }

  static final t = ActivityNotificationTable();

  static const db = ActivityNotificationRepository._();

  @override
  int? id;

  int recipientId;

  String activityType;

  String title;

  String message;

  bool isRead;

  DateTime createdAt;

  @override
  _is.Table<int?> get table => t;

  /// Returns a shallow copy of this [ActivityNotification]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  ActivityNotification copyWith({
    int? id,
    int? recipientId,
    String? activityType,
    String? title,
    String? message,
    bool? isRead,
    DateTime? createdAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'ActivityNotification',
      if (id != null) 'id': id,
      'recipientId': recipientId,
      'activityType': activityType,
      'title': title,
      'message': message,
      'isRead': isRead,
      'createdAt': createdAt.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'ActivityNotification',
      if (id != null) 'id': id,
      'recipientId': recipientId,
      'activityType': activityType,
      'title': title,
      'message': message,
      'isRead': isRead,
      'createdAt': createdAt.toJson(),
    };
  }

  static ActivityNotificationInclude include() {
    return ActivityNotificationInclude._();
  }

  static ActivityNotificationIncludeList includeList({
    _is.WhereExpressionBuilder<ActivityNotificationTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<ActivityNotificationTable>? orderBy,
    _is.OrderByListBuilder<ActivityNotificationTable>? orderByList,
    ActivityNotificationInclude? include,
  }) {
    return ActivityNotificationIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(ActivityNotification.t),
      orderByList: orderByList?.call(ActivityNotification.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _is.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _ActivityNotificationImpl extends ActivityNotification {
  _ActivityNotificationImpl({
    int? id,
    required int recipientId,
    required String activityType,
    required String title,
    required String message,
    required bool isRead,
    required DateTime createdAt,
  }) : super._(
         id: id,
         recipientId: recipientId,
         activityType: activityType,
         title: title,
         message: message,
         isRead: isRead,
         createdAt: createdAt,
       );

  /// Returns a shallow copy of this [ActivityNotification]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  @override
  ActivityNotification copyWith({
    Object? id = _Undefined,
    int? recipientId,
    String? activityType,
    String? title,
    String? message,
    bool? isRead,
    DateTime? createdAt,
  }) {
    return ActivityNotification(
      id: id is int? ? id : this.id,
      recipientId: recipientId ?? this.recipientId,
      activityType: activityType ?? this.activityType,
      title: title ?? this.title,
      message: message ?? this.message,
      isRead: isRead ?? this.isRead,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}

class ActivityNotificationUpdateTable
    extends _is.UpdateTable<ActivityNotificationTable> {
  ActivityNotificationUpdateTable(super.table);

  _is.ColumnValue<int, int> recipientId(int value) => _is.ColumnValue(
    table.recipientId,
    value,
  );

  _is.ColumnValue<String, String> activityType(String value) => _is.ColumnValue(
    table.activityType,
    value,
  );

  _is.ColumnValue<String, String> title(String value) => _is.ColumnValue(
    table.title,
    value,
  );

  _is.ColumnValue<String, String> message(String value) => _is.ColumnValue(
    table.message,
    value,
  );

  _is.ColumnValue<bool, bool> isRead(bool value) => _is.ColumnValue(
    table.isRead,
    value,
  );

  _is.ColumnValue<DateTime, DateTime> createdAt(DateTime value) =>
      _is.ColumnValue(
        table.createdAt,
        value,
      );
}

class ActivityNotificationTable extends _is.Table<int?> {
  ActivityNotificationTable({super.tableRelation})
    : super(tableName: 'activity_notification') {
    updateTable = ActivityNotificationUpdateTable(this);
    recipientId = _is.ColumnInt(
      'recipientId',
      this,
    );
    activityType = _is.ColumnString(
      'activityType',
      this,
    );
    title = _is.ColumnString(
      'title',
      this,
    );
    message = _is.ColumnString(
      'message',
      this,
    );
    isRead = _is.ColumnBool(
      'isRead',
      this,
    );
    createdAt = _is.ColumnDateTime(
      'createdAt',
      this,
    );
  }

  late final ActivityNotificationUpdateTable updateTable;

  late final _is.ColumnInt recipientId;

  late final _is.ColumnString activityType;

  late final _is.ColumnString title;

  late final _is.ColumnString message;

  late final _is.ColumnBool isRead;

  late final _is.ColumnDateTime createdAt;

  @override
  List<_is.Column> get columns => [
    id,
    recipientId,
    activityType,
    title,
    message,
    isRead,
    createdAt,
  ];
}

class ActivityNotificationInclude extends _is.IncludeObject {
  ActivityNotificationInclude._();

  @override
  Map<String, _is.Include?> get includes => {};

  @override
  _is.Table<int?> get table => ActivityNotification.t;
}

class ActivityNotificationIncludeList extends _is.IncludeList {
  ActivityNotificationIncludeList._({
    _is.WhereExpressionBuilder<ActivityNotificationTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(ActivityNotification.t);
  }

  @override
  Map<String, _is.Include?> get includes => include?.includes ?? {};

  @override
  _is.Table<int?> get table => ActivityNotification.t;
}

class ActivityNotificationRepository {
  const ActivityNotificationRepository._();

  /// Returns a list of [ActivityNotification]s matching the given query parameters.
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
  Future<List<ActivityNotification>> find(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<ActivityNotificationTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<ActivityNotificationTable>? orderBy,
    _is.OrderByListBuilder<ActivityNotificationTable>? orderByList,
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.find<ActivityNotification>(
      where: where?.call(ActivityNotification.t),
      orderBy: orderBy?.call(ActivityNotification.t),
      orderByList: orderByList?.call(ActivityNotification.t),
      limit: limit,
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Returns the first matching [ActivityNotification] matching the given query parameters.
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
  Future<ActivityNotification?> findFirstRow(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<ActivityNotificationTable>? where,
    int? offset,
    _is.OrderByBuilder<ActivityNotificationTable>? orderBy,
    _is.OrderByListBuilder<ActivityNotificationTable>? orderByList,
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findFirstRow<ActivityNotification>(
      where: where?.call(ActivityNotification.t),
      orderBy: orderBy?.call(ActivityNotification.t),
      orderByList: orderByList?.call(ActivityNotification.t),
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Finds a single [ActivityNotification] by its [id] or null if no such row exists.
  Future<ActivityNotification?> findById(
    _is.DatabaseSession session,
    int id, {
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findById<ActivityNotification>(
      id,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Inserts all [ActivityNotification]s in the list and returns the inserted rows.
  ///
  /// The returned [ActivityNotification]s will have their `id` fields set.
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
  Future<List<ActivityNotification>> insert(
    _is.DatabaseSession session,
    List<ActivityNotification> rows, {
    _is.Transaction? transaction,
    bool ignoreConflicts = false,
    bool noReturn = false,
  }) async {
    return session.db.insert<ActivityNotification>(
      rows,
      transaction: transaction,
      ignoreConflicts: ignoreConflicts,
      noReturn: noReturn,
    );
  }

  /// Inserts a single [ActivityNotification] and returns the inserted row.
  ///
  /// The returned [ActivityNotification] will have its `id` field set.
  Future<ActivityNotification> insertRow(
    _is.DatabaseSession session,
    ActivityNotification row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.insertRow<ActivityNotification>(
      row,
      transaction: transaction,
    );
  }

  /// Upserts all [ActivityNotification]s in the list and returns the resulting rows.
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
  /// The returned [ActivityNotification]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails,
  /// none of the rows will be affected.
  ///
  /// If [noReturn] is set to `true`, the resulting rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<ActivityNotification>> upsert(
    _is.DatabaseSession session,
    List<ActivityNotification> rows, {
    required _is.ColumnSelections<ActivityNotificationTable> conflictColumns,
    _is.ColumnSelections<ActivityNotificationTable>? updateColumns,
    _is.WhereExpressionBuilder<ActivityNotificationTable>? updateWhere,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.upsert<ActivityNotification>(
      rows,
      conflictColumns: conflictColumns(ActivityNotification.t),
      updateColumns: updateColumns?.call(ActivityNotification.t),
      updateWhere: updateWhere?.call(ActivityNotification.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Upserts a single [ActivityNotification] and returns the resulting row.
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
  /// The returned [ActivityNotification] will have its `id` field set.
  Future<ActivityNotification?> upsertRow(
    _is.DatabaseSession session,
    ActivityNotification row, {
    required _is.ColumnSelections<ActivityNotificationTable> conflictColumns,
    _is.ColumnSelections<ActivityNotificationTable>? updateColumns,
    _is.WhereExpressionBuilder<ActivityNotificationTable>? updateWhere,
    _is.Transaction? transaction,
  }) async {
    return session.db.upsertRow<ActivityNotification>(
      row,
      conflictColumns: conflictColumns(ActivityNotification.t),
      updateColumns: updateColumns?.call(ActivityNotification.t),
      updateWhere: updateWhere?.call(ActivityNotification.t),
      transaction: transaction,
    );
  }

  /// Updates all [ActivityNotification]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<ActivityNotification>> update(
    _is.DatabaseSession session,
    List<ActivityNotification> rows, {
    _is.ColumnSelections<ActivityNotificationTable>? columns,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.update<ActivityNotification>(
      rows,
      columns: columns?.call(ActivityNotification.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Updates a single [ActivityNotification]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<ActivityNotification> updateRow(
    _is.DatabaseSession session,
    ActivityNotification row, {
    _is.ColumnSelections<ActivityNotificationTable>? columns,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateRow<ActivityNotification>(
      row,
      columns: columns?.call(ActivityNotification.t),
      transaction: transaction,
    );
  }

  /// Updates a single [ActivityNotification] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<ActivityNotification?> updateById(
    _is.DatabaseSession session,
    int id, {
    required _is.ColumnValueListBuilder<ActivityNotificationUpdateTable>
    columnValues,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateById<ActivityNotification>(
      id,
      columnValues: columnValues(ActivityNotification.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [ActivityNotification]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<ActivityNotification>> updateWhere(
    _is.DatabaseSession session, {
    required _is.ColumnValueListBuilder<ActivityNotificationUpdateTable>
    columnValues,
    required _is.WhereExpressionBuilder<ActivityNotificationTable> where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<ActivityNotificationTable>? orderBy,
    _is.OrderByListBuilder<ActivityNotificationTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.updateWhere<ActivityNotification>(
      columnValues: columnValues(ActivityNotification.t.updateTable),
      where: where(ActivityNotification.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(ActivityNotification.t),
      orderByList: orderByList?.call(ActivityNotification.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes all [ActivityNotification]s in the list and returns the deleted rows.
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
  Future<List<ActivityNotification>> delete(
    _is.DatabaseSession session,
    List<ActivityNotification> rows, {
    _is.OrderByBuilder<ActivityNotificationTable>? orderBy,
    _is.OrderByListBuilder<ActivityNotificationTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.delete<ActivityNotification>(
      rows,
      orderBy: orderBy?.call(ActivityNotification.t),
      orderByList: orderByList?.call(ActivityNotification.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes a single [ActivityNotification].
  Future<ActivityNotification> deleteRow(
    _is.DatabaseSession session,
    ActivityNotification row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.deleteRow<ActivityNotification>(
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
  Future<List<ActivityNotification>> deleteWhere(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<ActivityNotificationTable> where,
    _is.OrderByBuilder<ActivityNotificationTable>? orderBy,
    _is.OrderByListBuilder<ActivityNotificationTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.deleteWhere<ActivityNotification>(
      where: where(ActivityNotification.t),
      orderBy: orderBy?.call(ActivityNotification.t),
      orderByList: orderByList?.call(ActivityNotification.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<ActivityNotificationTable>? where,
    int? limit,
    _is.Transaction? transaction,
  }) async {
    return session.db.count<ActivityNotification>(
      where: where?.call(ActivityNotification.t),
      limit: limit,
      transaction: transaction,
    );
  }

  /// Acquires row-level locks on [ActivityNotification] rows matching the [where] expression.
  Future<void> lockRows(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<ActivityNotificationTable> where,
    required _is.LockMode lockMode,
    required _is.Transaction transaction,
    _is.LockBehavior lockBehavior = _is.LockBehavior.wait,
  }) async {
    return session.db.lockRows<ActivityNotification>(
      where: where(ActivityNotification.t),
      lockMode: lockMode,
      lockBehavior: lockBehavior,
      transaction: transaction,
    );
  }
}
