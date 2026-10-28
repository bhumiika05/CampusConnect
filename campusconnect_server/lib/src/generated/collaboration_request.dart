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

abstract class CollaborationRequest
    implements _is.TableRow<int?>, _is.ProtocolSerialization {
  CollaborationRequest._({
    this.id,
    required this.projectId,
    required this.projectTitle,
    required this.projectCreatorId,
    required this.studentId,
    required this.studentName,
    required this.studentBranch,
    required this.studentSkills,
    required this.message,
    required this.status,
    required this.createdAt,
  });

  factory CollaborationRequest({
    int? id,
    required int projectId,
    required String projectTitle,
    required int projectCreatorId,
    required int studentId,
    required String studentName,
    required String studentBranch,
    required List<String> studentSkills,
    required String message,
    required String status,
    required DateTime createdAt,
  }) = _CollaborationRequestImpl;

  factory CollaborationRequest.fromJson(
    Map<String, dynamic> jsonSerialization,
  ) {
    return CollaborationRequest(
      id: jsonSerialization['id'] as int?,
      projectId: jsonSerialization['projectId'] as int,
      projectTitle: jsonSerialization['projectTitle'] as String,
      projectCreatorId: jsonSerialization['projectCreatorId'] as int,
      studentId: jsonSerialization['studentId'] as int,
      studentName: jsonSerialization['studentName'] as String,
      studentBranch: jsonSerialization['studentBranch'] as String,
      studentSkills: _iusjeinx.Protocol().deserialize<List<String>>(
        jsonSerialization['studentSkills'],
      ),
      message: jsonSerialization['message'] as String,
      status: jsonSerialization['status'] as String,
      createdAt: _is.DateTimeJsonExtension.fromJson(
        jsonSerialization['createdAt'],
      ),
    );
  }

  static final t = CollaborationRequestTable();

  static const db = CollaborationRequestRepository._();

  @override
  int? id;

  int projectId;

  String projectTitle;

  int projectCreatorId;

  int studentId;

  String studentName;

  String studentBranch;

  List<String> studentSkills;

  String message;

  String status;

  DateTime createdAt;

  @override
  _is.Table<int?> get table => t;

  /// Returns a shallow copy of this [CollaborationRequest]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  CollaborationRequest copyWith({
    int? id,
    int? projectId,
    String? projectTitle,
    int? projectCreatorId,
    int? studentId,
    String? studentName,
    String? studentBranch,
    List<String>? studentSkills,
    String? message,
    String? status,
    DateTime? createdAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'CollaborationRequest',
      if (id != null) 'id': id,
      'projectId': projectId,
      'projectTitle': projectTitle,
      'projectCreatorId': projectCreatorId,
      'studentId': studentId,
      'studentName': studentName,
      'studentBranch': studentBranch,
      'studentSkills': studentSkills.toJson(),
      'message': message,
      'status': status,
      'createdAt': createdAt.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'CollaborationRequest',
      if (id != null) 'id': id,
      'projectId': projectId,
      'projectTitle': projectTitle,
      'projectCreatorId': projectCreatorId,
      'studentId': studentId,
      'studentName': studentName,
      'studentBranch': studentBranch,
      'studentSkills': studentSkills.toJson(),
      'message': message,
      'status': status,
      'createdAt': createdAt.toJson(),
    };
  }

  static CollaborationRequestInclude include() {
    return CollaborationRequestInclude._();
  }

  static CollaborationRequestIncludeList includeList({
    _is.WhereExpressionBuilder<CollaborationRequestTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<CollaborationRequestTable>? orderBy,
    _is.OrderByListBuilder<CollaborationRequestTable>? orderByList,
    CollaborationRequestInclude? include,
  }) {
    return CollaborationRequestIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(CollaborationRequest.t),
      orderByList: orderByList?.call(CollaborationRequest.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _is.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _CollaborationRequestImpl extends CollaborationRequest {
  _CollaborationRequestImpl({
    int? id,
    required int projectId,
    required String projectTitle,
    required int projectCreatorId,
    required int studentId,
    required String studentName,
    required String studentBranch,
    required List<String> studentSkills,
    required String message,
    required String status,
    required DateTime createdAt,
  }) : super._(
         id: id,
         projectId: projectId,
         projectTitle: projectTitle,
         projectCreatorId: projectCreatorId,
         studentId: studentId,
         studentName: studentName,
         studentBranch: studentBranch,
         studentSkills: studentSkills,
         message: message,
         status: status,
         createdAt: createdAt,
       );

  /// Returns a shallow copy of this [CollaborationRequest]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  @override
  CollaborationRequest copyWith({
    Object? id = _Undefined,
    int? projectId,
    String? projectTitle,
    int? projectCreatorId,
    int? studentId,
    String? studentName,
    String? studentBranch,
    List<String>? studentSkills,
    String? message,
    String? status,
    DateTime? createdAt,
  }) {
    return CollaborationRequest(
      id: id is int? ? id : this.id,
      projectId: projectId ?? this.projectId,
      projectTitle: projectTitle ?? this.projectTitle,
      projectCreatorId: projectCreatorId ?? this.projectCreatorId,
      studentId: studentId ?? this.studentId,
      studentName: studentName ?? this.studentName,
      studentBranch: studentBranch ?? this.studentBranch,
      studentSkills:
          studentSkills ?? this.studentSkills.map((e0) => e0).toList(),
      message: message ?? this.message,
      status: status ?? this.status,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}

class CollaborationRequestUpdateTable
    extends _is.UpdateTable<CollaborationRequestTable> {
  CollaborationRequestUpdateTable(super.table);

  _is.ColumnValue<int, int> projectId(int value) => _is.ColumnValue(
    table.projectId,
    value,
  );

  _is.ColumnValue<String, String> projectTitle(String value) => _is.ColumnValue(
    table.projectTitle,
    value,
  );

  _is.ColumnValue<int, int> projectCreatorId(int value) => _is.ColumnValue(
    table.projectCreatorId,
    value,
  );

  _is.ColumnValue<int, int> studentId(int value) => _is.ColumnValue(
    table.studentId,
    value,
  );

  _is.ColumnValue<String, String> studentName(String value) => _is.ColumnValue(
    table.studentName,
    value,
  );

  _is.ColumnValue<String, String> studentBranch(String value) =>
      _is.ColumnValue(
        table.studentBranch,
        value,
      );

  _is.ColumnValue<List<String>, List<String>> studentSkills(
    List<String> value,
  ) => _is.ColumnValue(
    table.studentSkills,
    value,
  );

  _is.ColumnValue<String, String> message(String value) => _is.ColumnValue(
    table.message,
    value,
  );

  _is.ColumnValue<String, String> status(String value) => _is.ColumnValue(
    table.status,
    value,
  );

  _is.ColumnValue<DateTime, DateTime> createdAt(DateTime value) =>
      _is.ColumnValue(
        table.createdAt,
        value,
      );
}

class CollaborationRequestTable extends _is.Table<int?> {
  CollaborationRequestTable({super.tableRelation})
    : super(tableName: 'collaboration_request') {
    updateTable = CollaborationRequestUpdateTable(this);
    projectId = _is.ColumnInt(
      'projectId',
      this,
    );
    projectTitle = _is.ColumnString(
      'projectTitle',
      this,
    );
    projectCreatorId = _is.ColumnInt(
      'projectCreatorId',
      this,
    );
    studentId = _is.ColumnInt(
      'studentId',
      this,
    );
    studentName = _is.ColumnString(
      'studentName',
      this,
    );
    studentBranch = _is.ColumnString(
      'studentBranch',
      this,
    );
    studentSkills = _is.ColumnSerializable<List<String>>(
      'studentSkills',
      this,
    );
    message = _is.ColumnString(
      'message',
      this,
    );
    status = _is.ColumnString(
      'status',
      this,
    );
    createdAt = _is.ColumnDateTime(
      'createdAt',
      this,
    );
  }

  late final CollaborationRequestUpdateTable updateTable;

  late final _is.ColumnInt projectId;

  late final _is.ColumnString projectTitle;

  late final _is.ColumnInt projectCreatorId;

  late final _is.ColumnInt studentId;

  late final _is.ColumnString studentName;

  late final _is.ColumnString studentBranch;

  late final _is.ColumnSerializable<List<String>> studentSkills;

  late final _is.ColumnString message;

  late final _is.ColumnString status;

  late final _is.ColumnDateTime createdAt;

  @override
  List<_is.Column> get columns => [
    id,
    projectId,
    projectTitle,
    projectCreatorId,
    studentId,
    studentName,
    studentBranch,
    studentSkills,
    message,
    status,
    createdAt,
  ];
}

class CollaborationRequestInclude extends _is.IncludeObject {
  CollaborationRequestInclude._();

  @override
  Map<String, _is.Include?> get includes => {};

  @override
  _is.Table<int?> get table => CollaborationRequest.t;
}

class CollaborationRequestIncludeList extends _is.IncludeList {
  CollaborationRequestIncludeList._({
    _is.WhereExpressionBuilder<CollaborationRequestTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(CollaborationRequest.t);
  }

  @override
  Map<String, _is.Include?> get includes => include?.includes ?? {};

  @override
  _is.Table<int?> get table => CollaborationRequest.t;
}

class CollaborationRequestRepository {
  const CollaborationRequestRepository._();

  /// Returns a list of [CollaborationRequest]s matching the given query parameters.
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
  Future<List<CollaborationRequest>> find(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<CollaborationRequestTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<CollaborationRequestTable>? orderBy,
    _is.OrderByListBuilder<CollaborationRequestTable>? orderByList,
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.find<CollaborationRequest>(
      where: where?.call(CollaborationRequest.t),
      orderBy: orderBy?.call(CollaborationRequest.t),
      orderByList: orderByList?.call(CollaborationRequest.t),
      limit: limit,
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Returns the first matching [CollaborationRequest] matching the given query parameters.
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
  Future<CollaborationRequest?> findFirstRow(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<CollaborationRequestTable>? where,
    int? offset,
    _is.OrderByBuilder<CollaborationRequestTable>? orderBy,
    _is.OrderByListBuilder<CollaborationRequestTable>? orderByList,
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findFirstRow<CollaborationRequest>(
      where: where?.call(CollaborationRequest.t),
      orderBy: orderBy?.call(CollaborationRequest.t),
      orderByList: orderByList?.call(CollaborationRequest.t),
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Finds a single [CollaborationRequest] by its [id] or null if no such row exists.
  Future<CollaborationRequest?> findById(
    _is.DatabaseSession session,
    int id, {
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findById<CollaborationRequest>(
      id,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Inserts all [CollaborationRequest]s in the list and returns the inserted rows.
  ///
  /// The returned [CollaborationRequest]s will have their `id` fields set.
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
  Future<List<CollaborationRequest>> insert(
    _is.DatabaseSession session,
    List<CollaborationRequest> rows, {
    _is.Transaction? transaction,
    bool ignoreConflicts = false,
    bool noReturn = false,
  }) async {
    return session.db.insert<CollaborationRequest>(
      rows,
      transaction: transaction,
      ignoreConflicts: ignoreConflicts,
      noReturn: noReturn,
    );
  }

  /// Inserts a single [CollaborationRequest] and returns the inserted row.
  ///
  /// The returned [CollaborationRequest] will have its `id` field set.
  Future<CollaborationRequest> insertRow(
    _is.DatabaseSession session,
    CollaborationRequest row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.insertRow<CollaborationRequest>(
      row,
      transaction: transaction,
    );
  }

  /// Upserts all [CollaborationRequest]s in the list and returns the resulting rows.
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
  /// The returned [CollaborationRequest]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails,
  /// none of the rows will be affected.
  ///
  /// If [noReturn] is set to `true`, the resulting rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<CollaborationRequest>> upsert(
    _is.DatabaseSession session,
    List<CollaborationRequest> rows, {
    required _is.ColumnSelections<CollaborationRequestTable> conflictColumns,
    _is.ColumnSelections<CollaborationRequestTable>? updateColumns,
    _is.WhereExpressionBuilder<CollaborationRequestTable>? updateWhere,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.upsert<CollaborationRequest>(
      rows,
      conflictColumns: conflictColumns(CollaborationRequest.t),
      updateColumns: updateColumns?.call(CollaborationRequest.t),
      updateWhere: updateWhere?.call(CollaborationRequest.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Upserts a single [CollaborationRequest] and returns the resulting row.
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
  /// The returned [CollaborationRequest] will have its `id` field set.
  Future<CollaborationRequest?> upsertRow(
    _is.DatabaseSession session,
    CollaborationRequest row, {
    required _is.ColumnSelections<CollaborationRequestTable> conflictColumns,
    _is.ColumnSelections<CollaborationRequestTable>? updateColumns,
    _is.WhereExpressionBuilder<CollaborationRequestTable>? updateWhere,
    _is.Transaction? transaction,
  }) async {
    return session.db.upsertRow<CollaborationRequest>(
      row,
      conflictColumns: conflictColumns(CollaborationRequest.t),
      updateColumns: updateColumns?.call(CollaborationRequest.t),
      updateWhere: updateWhere?.call(CollaborationRequest.t),
      transaction: transaction,
    );
  }

  /// Updates all [CollaborationRequest]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<CollaborationRequest>> update(
    _is.DatabaseSession session,
    List<CollaborationRequest> rows, {
    _is.ColumnSelections<CollaborationRequestTable>? columns,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.update<CollaborationRequest>(
      rows,
      columns: columns?.call(CollaborationRequest.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Updates a single [CollaborationRequest]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<CollaborationRequest> updateRow(
    _is.DatabaseSession session,
    CollaborationRequest row, {
    _is.ColumnSelections<CollaborationRequestTable>? columns,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateRow<CollaborationRequest>(
      row,
      columns: columns?.call(CollaborationRequest.t),
      transaction: transaction,
    );
  }

  /// Updates a single [CollaborationRequest] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<CollaborationRequest?> updateById(
    _is.DatabaseSession session,
    int id, {
    required _is.ColumnValueListBuilder<CollaborationRequestUpdateTable>
    columnValues,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateById<CollaborationRequest>(
      id,
      columnValues: columnValues(CollaborationRequest.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [CollaborationRequest]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<CollaborationRequest>> updateWhere(
    _is.DatabaseSession session, {
    required _is.ColumnValueListBuilder<CollaborationRequestUpdateTable>
    columnValues,
    required _is.WhereExpressionBuilder<CollaborationRequestTable> where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<CollaborationRequestTable>? orderBy,
    _is.OrderByListBuilder<CollaborationRequestTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.updateWhere<CollaborationRequest>(
      columnValues: columnValues(CollaborationRequest.t.updateTable),
      where: where(CollaborationRequest.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(CollaborationRequest.t),
      orderByList: orderByList?.call(CollaborationRequest.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes all [CollaborationRequest]s in the list and returns the deleted rows.
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
  Future<List<CollaborationRequest>> delete(
    _is.DatabaseSession session,
    List<CollaborationRequest> rows, {
    _is.OrderByBuilder<CollaborationRequestTable>? orderBy,
    _is.OrderByListBuilder<CollaborationRequestTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.delete<CollaborationRequest>(
      rows,
      orderBy: orderBy?.call(CollaborationRequest.t),
      orderByList: orderByList?.call(CollaborationRequest.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes a single [CollaborationRequest].
  Future<CollaborationRequest> deleteRow(
    _is.DatabaseSession session,
    CollaborationRequest row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.deleteRow<CollaborationRequest>(
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
  Future<List<CollaborationRequest>> deleteWhere(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<CollaborationRequestTable> where,
    _is.OrderByBuilder<CollaborationRequestTable>? orderBy,
    _is.OrderByListBuilder<CollaborationRequestTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.deleteWhere<CollaborationRequest>(
      where: where(CollaborationRequest.t),
      orderBy: orderBy?.call(CollaborationRequest.t),
      orderByList: orderByList?.call(CollaborationRequest.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<CollaborationRequestTable>? where,
    int? limit,
    _is.Transaction? transaction,
  }) async {
    return session.db.count<CollaborationRequest>(
      where: where?.call(CollaborationRequest.t),
      limit: limit,
      transaction: transaction,
    );
  }

  /// Acquires row-level locks on [CollaborationRequest] rows matching the [where] expression.
  Future<void> lockRows(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<CollaborationRequestTable> where,
    required _is.LockMode lockMode,
    required _is.Transaction transaction,
    _is.LockBehavior lockBehavior = _is.LockBehavior.wait,
  }) async {
    return session.db.lockRows<CollaborationRequest>(
      where: where(CollaborationRequest.t),
      lockMode: lockMode,
      lockBehavior: lockBehavior,
      transaction: transaction,
    );
  }
}
