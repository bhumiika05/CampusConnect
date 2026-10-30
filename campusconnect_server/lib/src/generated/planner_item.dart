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

abstract class PlannerItem
    implements _is.TableRow<int?>, _is.ProtocolSerialization {
  PlannerItem._({
    this.id,
    required this.studentId,
    required this.title,
    required this.category,
    required this.dayOfWeek,
    required this.timeSlot,
    this.location,
    this.description,
    this.referenceId,
    required this.isCompleted,
    required this.createdAt,
  });

  factory PlannerItem({
    int? id,
    required int studentId,
    required String title,
    required String category,
    required String dayOfWeek,
    required String timeSlot,
    String? location,
    String? description,
    int? referenceId,
    required bool isCompleted,
    required DateTime createdAt,
  }) = _PlannerItemImpl;

  factory PlannerItem.fromJson(Map<String, dynamic> jsonSerialization) {
    return PlannerItem(
      id: jsonSerialization['id'] as int?,
      studentId: jsonSerialization['studentId'] as int,
      title: jsonSerialization['title'] as String,
      category: jsonSerialization['category'] as String,
      dayOfWeek: jsonSerialization['dayOfWeek'] as String,
      timeSlot: jsonSerialization['timeSlot'] as String,
      location: jsonSerialization['location'] as String?,
      description: jsonSerialization['description'] as String?,
      referenceId: jsonSerialization['referenceId'] as int?,
      isCompleted: _is.BoolJsonExtension.fromJson(
        jsonSerialization['isCompleted'],
      ),
      createdAt: _is.DateTimeJsonExtension.fromJson(
        jsonSerialization['createdAt'],
      ),
    );
  }

  static final t = PlannerItemTable();

  static const db = PlannerItemRepository._();

  @override
  int? id;

  int studentId;

  String title;

  String category;

  String dayOfWeek;

  String timeSlot;

  String? location;

  String? description;

  int? referenceId;

  bool isCompleted;

  DateTime createdAt;

  @override
  _is.Table<int?> get table => t;

  /// Returns a shallow copy of this [PlannerItem]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  PlannerItem copyWith({
    int? id,
    int? studentId,
    String? title,
    String? category,
    String? dayOfWeek,
    String? timeSlot,
    String? location,
    String? description,
    int? referenceId,
    bool? isCompleted,
    DateTime? createdAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'PlannerItem',
      if (id != null) 'id': id,
      'studentId': studentId,
      'title': title,
      'category': category,
      'dayOfWeek': dayOfWeek,
      'timeSlot': timeSlot,
      if (location != null) 'location': location,
      if (description != null) 'description': description,
      if (referenceId != null) 'referenceId': referenceId,
      'isCompleted': isCompleted,
      'createdAt': createdAt.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'PlannerItem',
      if (id != null) 'id': id,
      'studentId': studentId,
      'title': title,
      'category': category,
      'dayOfWeek': dayOfWeek,
      'timeSlot': timeSlot,
      if (location != null) 'location': location,
      if (description != null) 'description': description,
      if (referenceId != null) 'referenceId': referenceId,
      'isCompleted': isCompleted,
      'createdAt': createdAt.toJson(),
    };
  }

  static PlannerItemInclude include() {
    return PlannerItemInclude._();
  }

  static PlannerItemIncludeList includeList({
    _is.WhereExpressionBuilder<PlannerItemTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<PlannerItemTable>? orderBy,
    _is.OrderByListBuilder<PlannerItemTable>? orderByList,
    PlannerItemInclude? include,
  }) {
    return PlannerItemIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(PlannerItem.t),
      orderByList: orderByList?.call(PlannerItem.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _is.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _PlannerItemImpl extends PlannerItem {
  _PlannerItemImpl({
    int? id,
    required int studentId,
    required String title,
    required String category,
    required String dayOfWeek,
    required String timeSlot,
    String? location,
    String? description,
    int? referenceId,
    required bool isCompleted,
    required DateTime createdAt,
  }) : super._(
         id: id,
         studentId: studentId,
         title: title,
         category: category,
         dayOfWeek: dayOfWeek,
         timeSlot: timeSlot,
         location: location,
         description: description,
         referenceId: referenceId,
         isCompleted: isCompleted,
         createdAt: createdAt,
       );

  /// Returns a shallow copy of this [PlannerItem]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  @override
  PlannerItem copyWith({
    Object? id = _Undefined,
    int? studentId,
    String? title,
    String? category,
    String? dayOfWeek,
    String? timeSlot,
    Object? location = _Undefined,
    Object? description = _Undefined,
    Object? referenceId = _Undefined,
    bool? isCompleted,
    DateTime? createdAt,
  }) {
    return PlannerItem(
      id: id is int? ? id : this.id,
      studentId: studentId ?? this.studentId,
      title: title ?? this.title,
      category: category ?? this.category,
      dayOfWeek: dayOfWeek ?? this.dayOfWeek,
      timeSlot: timeSlot ?? this.timeSlot,
      location: location is String? ? location : this.location,
      description: description is String? ? description : this.description,
      referenceId: referenceId is int? ? referenceId : this.referenceId,
      isCompleted: isCompleted ?? this.isCompleted,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}

class PlannerItemUpdateTable extends _is.UpdateTable<PlannerItemTable> {
  PlannerItemUpdateTable(super.table);

  _is.ColumnValue<int, int> studentId(int value) => _is.ColumnValue(
    table.studentId,
    value,
  );

  _is.ColumnValue<String, String> title(String value) => _is.ColumnValue(
    table.title,
    value,
  );

  _is.ColumnValue<String, String> category(String value) => _is.ColumnValue(
    table.category,
    value,
  );

  _is.ColumnValue<String, String> dayOfWeek(String value) => _is.ColumnValue(
    table.dayOfWeek,
    value,
  );

  _is.ColumnValue<String, String> timeSlot(String value) => _is.ColumnValue(
    table.timeSlot,
    value,
  );

  _is.ColumnValue<String, String> location(String? value) => _is.ColumnValue(
    table.location,
    value,
  );

  _is.ColumnValue<String, String> description(String? value) => _is.ColumnValue(
    table.description,
    value,
  );

  _is.ColumnValue<int, int> referenceId(int? value) => _is.ColumnValue(
    table.referenceId,
    value,
  );

  _is.ColumnValue<bool, bool> isCompleted(bool value) => _is.ColumnValue(
    table.isCompleted,
    value,
  );

  _is.ColumnValue<DateTime, DateTime> createdAt(DateTime value) =>
      _is.ColumnValue(
        table.createdAt,
        value,
      );
}

class PlannerItemTable extends _is.Table<int?> {
  PlannerItemTable({super.tableRelation}) : super(tableName: 'planner_item') {
    updateTable = PlannerItemUpdateTable(this);
    studentId = _is.ColumnInt(
      'studentId',
      this,
    );
    title = _is.ColumnString(
      'title',
      this,
    );
    category = _is.ColumnString(
      'category',
      this,
    );
    dayOfWeek = _is.ColumnString(
      'dayOfWeek',
      this,
    );
    timeSlot = _is.ColumnString(
      'timeSlot',
      this,
    );
    location = _is.ColumnString(
      'location',
      this,
    );
    description = _is.ColumnString(
      'description',
      this,
    );
    referenceId = _is.ColumnInt(
      'referenceId',
      this,
    );
    isCompleted = _is.ColumnBool(
      'isCompleted',
      this,
    );
    createdAt = _is.ColumnDateTime(
      'createdAt',
      this,
    );
  }

  late final PlannerItemUpdateTable updateTable;

  late final _is.ColumnInt studentId;

  late final _is.ColumnString title;

  late final _is.ColumnString category;

  late final _is.ColumnString dayOfWeek;

  late final _is.ColumnString timeSlot;

  late final _is.ColumnString location;

  late final _is.ColumnString description;

  late final _is.ColumnInt referenceId;

  late final _is.ColumnBool isCompleted;

  late final _is.ColumnDateTime createdAt;

  @override
  List<_is.Column> get columns => [
    id,
    studentId,
    title,
    category,
    dayOfWeek,
    timeSlot,
    location,
    description,
    referenceId,
    isCompleted,
    createdAt,
  ];
}

class PlannerItemInclude extends _is.IncludeObject {
  PlannerItemInclude._();

  @override
  Map<String, _is.Include?> get includes => {};

  @override
  _is.Table<int?> get table => PlannerItem.t;
}

class PlannerItemIncludeList extends _is.IncludeList {
  PlannerItemIncludeList._({
    _is.WhereExpressionBuilder<PlannerItemTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(PlannerItem.t);
  }

  @override
  Map<String, _is.Include?> get includes => include?.includes ?? {};

  @override
  _is.Table<int?> get table => PlannerItem.t;
}

class PlannerItemRepository {
  const PlannerItemRepository._();

  /// Returns a list of [PlannerItem]s matching the given query parameters.
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
  Future<List<PlannerItem>> find(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<PlannerItemTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<PlannerItemTable>? orderBy,
    _is.OrderByListBuilder<PlannerItemTable>? orderByList,
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.find<PlannerItem>(
      where: where?.call(PlannerItem.t),
      orderBy: orderBy?.call(PlannerItem.t),
      orderByList: orderByList?.call(PlannerItem.t),
      limit: limit,
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Returns the first matching [PlannerItem] matching the given query parameters.
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
  Future<PlannerItem?> findFirstRow(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<PlannerItemTable>? where,
    int? offset,
    _is.OrderByBuilder<PlannerItemTable>? orderBy,
    _is.OrderByListBuilder<PlannerItemTable>? orderByList,
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findFirstRow<PlannerItem>(
      where: where?.call(PlannerItem.t),
      orderBy: orderBy?.call(PlannerItem.t),
      orderByList: orderByList?.call(PlannerItem.t),
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Finds a single [PlannerItem] by its [id] or null if no such row exists.
  Future<PlannerItem?> findById(
    _is.DatabaseSession session,
    int id, {
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findById<PlannerItem>(
      id,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Inserts all [PlannerItem]s in the list and returns the inserted rows.
  ///
  /// The returned [PlannerItem]s will have their `id` fields set.
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
  Future<List<PlannerItem>> insert(
    _is.DatabaseSession session,
    List<PlannerItem> rows, {
    _is.Transaction? transaction,
    bool ignoreConflicts = false,
    bool noReturn = false,
  }) async {
    return session.db.insert<PlannerItem>(
      rows,
      transaction: transaction,
      ignoreConflicts: ignoreConflicts,
      noReturn: noReturn,
    );
  }

  /// Inserts a single [PlannerItem] and returns the inserted row.
  ///
  /// The returned [PlannerItem] will have its `id` field set.
  Future<PlannerItem> insertRow(
    _is.DatabaseSession session,
    PlannerItem row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.insertRow<PlannerItem>(
      row,
      transaction: transaction,
    );
  }

  /// Upserts all [PlannerItem]s in the list and returns the resulting rows.
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
  /// The returned [PlannerItem]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails,
  /// none of the rows will be affected.
  ///
  /// If [noReturn] is set to `true`, the resulting rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<PlannerItem>> upsert(
    _is.DatabaseSession session,
    List<PlannerItem> rows, {
    required _is.ColumnSelections<PlannerItemTable> conflictColumns,
    _is.ColumnSelections<PlannerItemTable>? updateColumns,
    _is.WhereExpressionBuilder<PlannerItemTable>? updateWhere,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.upsert<PlannerItem>(
      rows,
      conflictColumns: conflictColumns(PlannerItem.t),
      updateColumns: updateColumns?.call(PlannerItem.t),
      updateWhere: updateWhere?.call(PlannerItem.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Upserts a single [PlannerItem] and returns the resulting row.
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
  /// The returned [PlannerItem] will have its `id` field set.
  Future<PlannerItem?> upsertRow(
    _is.DatabaseSession session,
    PlannerItem row, {
    required _is.ColumnSelections<PlannerItemTable> conflictColumns,
    _is.ColumnSelections<PlannerItemTable>? updateColumns,
    _is.WhereExpressionBuilder<PlannerItemTable>? updateWhere,
    _is.Transaction? transaction,
  }) async {
    return session.db.upsertRow<PlannerItem>(
      row,
      conflictColumns: conflictColumns(PlannerItem.t),
      updateColumns: updateColumns?.call(PlannerItem.t),
      updateWhere: updateWhere?.call(PlannerItem.t),
      transaction: transaction,
    );
  }

  /// Updates all [PlannerItem]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<PlannerItem>> update(
    _is.DatabaseSession session,
    List<PlannerItem> rows, {
    _is.ColumnSelections<PlannerItemTable>? columns,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.update<PlannerItem>(
      rows,
      columns: columns?.call(PlannerItem.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Updates a single [PlannerItem]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<PlannerItem> updateRow(
    _is.DatabaseSession session,
    PlannerItem row, {
    _is.ColumnSelections<PlannerItemTable>? columns,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateRow<PlannerItem>(
      row,
      columns: columns?.call(PlannerItem.t),
      transaction: transaction,
    );
  }

  /// Updates a single [PlannerItem] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<PlannerItem?> updateById(
    _is.DatabaseSession session,
    int id, {
    required _is.ColumnValueListBuilder<PlannerItemUpdateTable> columnValues,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateById<PlannerItem>(
      id,
      columnValues: columnValues(PlannerItem.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [PlannerItem]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<PlannerItem>> updateWhere(
    _is.DatabaseSession session, {
    required _is.ColumnValueListBuilder<PlannerItemUpdateTable> columnValues,
    required _is.WhereExpressionBuilder<PlannerItemTable> where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<PlannerItemTable>? orderBy,
    _is.OrderByListBuilder<PlannerItemTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.updateWhere<PlannerItem>(
      columnValues: columnValues(PlannerItem.t.updateTable),
      where: where(PlannerItem.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(PlannerItem.t),
      orderByList: orderByList?.call(PlannerItem.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes all [PlannerItem]s in the list and returns the deleted rows.
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
  Future<List<PlannerItem>> delete(
    _is.DatabaseSession session,
    List<PlannerItem> rows, {
    _is.OrderByBuilder<PlannerItemTable>? orderBy,
    _is.OrderByListBuilder<PlannerItemTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.delete<PlannerItem>(
      rows,
      orderBy: orderBy?.call(PlannerItem.t),
      orderByList: orderByList?.call(PlannerItem.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes a single [PlannerItem].
  Future<PlannerItem> deleteRow(
    _is.DatabaseSession session,
    PlannerItem row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.deleteRow<PlannerItem>(
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
  Future<List<PlannerItem>> deleteWhere(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<PlannerItemTable> where,
    _is.OrderByBuilder<PlannerItemTable>? orderBy,
    _is.OrderByListBuilder<PlannerItemTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.deleteWhere<PlannerItem>(
      where: where(PlannerItem.t),
      orderBy: orderBy?.call(PlannerItem.t),
      orderByList: orderByList?.call(PlannerItem.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<PlannerItemTable>? where,
    int? limit,
    _is.Transaction? transaction,
  }) async {
    return session.db.count<PlannerItem>(
      where: where?.call(PlannerItem.t),
      limit: limit,
      transaction: transaction,
    );
  }

  /// Acquires row-level locks on [PlannerItem] rows matching the [where] expression.
  Future<void> lockRows(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<PlannerItemTable> where,
    required _is.LockMode lockMode,
    required _is.Transaction transaction,
    _is.LockBehavior lockBehavior = _is.LockBehavior.wait,
  }) async {
    return session.db.lockRows<PlannerItem>(
      where: where(PlannerItem.t),
      lockMode: lockMode,
      lockBehavior: lockBehavior,
      transaction: transaction,
    );
  }
}
