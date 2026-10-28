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

abstract class ProjectListing
    implements _is.TableRow<int?>, _is.ProtocolSerialization {
  ProjectListing._({
    this.id,
    required this.title,
    required this.description,
    required this.creatorId,
    required this.creatorName,
    required this.creatorBranch,
    required this.techStack,
    required this.requiredSkills,
    required this.category,
    required this.totalPositions,
    required this.openPositions,
    required this.status,
    required this.createdAt,
  });

  factory ProjectListing({
    int? id,
    required String title,
    required String description,
    required int creatorId,
    required String creatorName,
    required String creatorBranch,
    required List<String> techStack,
    required List<String> requiredSkills,
    required String category,
    required int totalPositions,
    required int openPositions,
    required String status,
    required DateTime createdAt,
  }) = _ProjectListingImpl;

  factory ProjectListing.fromJson(Map<String, dynamic> jsonSerialization) {
    return ProjectListing(
      id: jsonSerialization['id'] as int?,
      title: jsonSerialization['title'] as String,
      description: jsonSerialization['description'] as String,
      creatorId: jsonSerialization['creatorId'] as int,
      creatorName: jsonSerialization['creatorName'] as String,
      creatorBranch: jsonSerialization['creatorBranch'] as String,
      techStack: _iusjeinx.Protocol().deserialize<List<String>>(
        jsonSerialization['techStack'],
      ),
      requiredSkills: _iusjeinx.Protocol().deserialize<List<String>>(
        jsonSerialization['requiredSkills'],
      ),
      category: jsonSerialization['category'] as String,
      totalPositions: jsonSerialization['totalPositions'] as int,
      openPositions: jsonSerialization['openPositions'] as int,
      status: jsonSerialization['status'] as String,
      createdAt: _is.DateTimeJsonExtension.fromJson(
        jsonSerialization['createdAt'],
      ),
    );
  }

  static final t = ProjectListingTable();

  static const db = ProjectListingRepository._();

  @override
  int? id;

  String title;

  String description;

  int creatorId;

  String creatorName;

  String creatorBranch;

  List<String> techStack;

  List<String> requiredSkills;

  String category;

  int totalPositions;

  int openPositions;

  String status;

  DateTime createdAt;

  @override
  _is.Table<int?> get table => t;

  /// Returns a shallow copy of this [ProjectListing]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  ProjectListing copyWith({
    int? id,
    String? title,
    String? description,
    int? creatorId,
    String? creatorName,
    String? creatorBranch,
    List<String>? techStack,
    List<String>? requiredSkills,
    String? category,
    int? totalPositions,
    int? openPositions,
    String? status,
    DateTime? createdAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'ProjectListing',
      if (id != null) 'id': id,
      'title': title,
      'description': description,
      'creatorId': creatorId,
      'creatorName': creatorName,
      'creatorBranch': creatorBranch,
      'techStack': techStack.toJson(),
      'requiredSkills': requiredSkills.toJson(),
      'category': category,
      'totalPositions': totalPositions,
      'openPositions': openPositions,
      'status': status,
      'createdAt': createdAt.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'ProjectListing',
      if (id != null) 'id': id,
      'title': title,
      'description': description,
      'creatorId': creatorId,
      'creatorName': creatorName,
      'creatorBranch': creatorBranch,
      'techStack': techStack.toJson(),
      'requiredSkills': requiredSkills.toJson(),
      'category': category,
      'totalPositions': totalPositions,
      'openPositions': openPositions,
      'status': status,
      'createdAt': createdAt.toJson(),
    };
  }

  static ProjectListingInclude include() {
    return ProjectListingInclude._();
  }

  static ProjectListingIncludeList includeList({
    _is.WhereExpressionBuilder<ProjectListingTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<ProjectListingTable>? orderBy,
    _is.OrderByListBuilder<ProjectListingTable>? orderByList,
    ProjectListingInclude? include,
  }) {
    return ProjectListingIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(ProjectListing.t),
      orderByList: orderByList?.call(ProjectListing.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _is.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _ProjectListingImpl extends ProjectListing {
  _ProjectListingImpl({
    int? id,
    required String title,
    required String description,
    required int creatorId,
    required String creatorName,
    required String creatorBranch,
    required List<String> techStack,
    required List<String> requiredSkills,
    required String category,
    required int totalPositions,
    required int openPositions,
    required String status,
    required DateTime createdAt,
  }) : super._(
         id: id,
         title: title,
         description: description,
         creatorId: creatorId,
         creatorName: creatorName,
         creatorBranch: creatorBranch,
         techStack: techStack,
         requiredSkills: requiredSkills,
         category: category,
         totalPositions: totalPositions,
         openPositions: openPositions,
         status: status,
         createdAt: createdAt,
       );

  /// Returns a shallow copy of this [ProjectListing]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  @override
  ProjectListing copyWith({
    Object? id = _Undefined,
    String? title,
    String? description,
    int? creatorId,
    String? creatorName,
    String? creatorBranch,
    List<String>? techStack,
    List<String>? requiredSkills,
    String? category,
    int? totalPositions,
    int? openPositions,
    String? status,
    DateTime? createdAt,
  }) {
    return ProjectListing(
      id: id is int? ? id : this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      creatorId: creatorId ?? this.creatorId,
      creatorName: creatorName ?? this.creatorName,
      creatorBranch: creatorBranch ?? this.creatorBranch,
      techStack: techStack ?? this.techStack.map((e0) => e0).toList(),
      requiredSkills:
          requiredSkills ?? this.requiredSkills.map((e0) => e0).toList(),
      category: category ?? this.category,
      totalPositions: totalPositions ?? this.totalPositions,
      openPositions: openPositions ?? this.openPositions,
      status: status ?? this.status,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}

class ProjectListingUpdateTable extends _is.UpdateTable<ProjectListingTable> {
  ProjectListingUpdateTable(super.table);

  _is.ColumnValue<String, String> title(String value) => _is.ColumnValue(
    table.title,
    value,
  );

  _is.ColumnValue<String, String> description(String value) => _is.ColumnValue(
    table.description,
    value,
  );

  _is.ColumnValue<int, int> creatorId(int value) => _is.ColumnValue(
    table.creatorId,
    value,
  );

  _is.ColumnValue<String, String> creatorName(String value) => _is.ColumnValue(
    table.creatorName,
    value,
  );

  _is.ColumnValue<String, String> creatorBranch(String value) =>
      _is.ColumnValue(
        table.creatorBranch,
        value,
      );

  _is.ColumnValue<List<String>, List<String>> techStack(List<String> value) =>
      _is.ColumnValue(
        table.techStack,
        value,
      );

  _is.ColumnValue<List<String>, List<String>> requiredSkills(
    List<String> value,
  ) => _is.ColumnValue(
    table.requiredSkills,
    value,
  );

  _is.ColumnValue<String, String> category(String value) => _is.ColumnValue(
    table.category,
    value,
  );

  _is.ColumnValue<int, int> totalPositions(int value) => _is.ColumnValue(
    table.totalPositions,
    value,
  );

  _is.ColumnValue<int, int> openPositions(int value) => _is.ColumnValue(
    table.openPositions,
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

class ProjectListingTable extends _is.Table<int?> {
  ProjectListingTable({super.tableRelation})
    : super(tableName: 'project_listing') {
    updateTable = ProjectListingUpdateTable(this);
    title = _is.ColumnString(
      'title',
      this,
    );
    description = _is.ColumnString(
      'description',
      this,
    );
    creatorId = _is.ColumnInt(
      'creatorId',
      this,
    );
    creatorName = _is.ColumnString(
      'creatorName',
      this,
    );
    creatorBranch = _is.ColumnString(
      'creatorBranch',
      this,
    );
    techStack = _is.ColumnSerializable<List<String>>(
      'techStack',
      this,
    );
    requiredSkills = _is.ColumnSerializable<List<String>>(
      'requiredSkills',
      this,
    );
    category = _is.ColumnString(
      'category',
      this,
    );
    totalPositions = _is.ColumnInt(
      'totalPositions',
      this,
    );
    openPositions = _is.ColumnInt(
      'openPositions',
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

  late final ProjectListingUpdateTable updateTable;

  late final _is.ColumnString title;

  late final _is.ColumnString description;

  late final _is.ColumnInt creatorId;

  late final _is.ColumnString creatorName;

  late final _is.ColumnString creatorBranch;

  late final _is.ColumnSerializable<List<String>> techStack;

  late final _is.ColumnSerializable<List<String>> requiredSkills;

  late final _is.ColumnString category;

  late final _is.ColumnInt totalPositions;

  late final _is.ColumnInt openPositions;

  late final _is.ColumnString status;

  late final _is.ColumnDateTime createdAt;

  @override
  List<_is.Column> get columns => [
    id,
    title,
    description,
    creatorId,
    creatorName,
    creatorBranch,
    techStack,
    requiredSkills,
    category,
    totalPositions,
    openPositions,
    status,
    createdAt,
  ];
}

class ProjectListingInclude extends _is.IncludeObject {
  ProjectListingInclude._();

  @override
  Map<String, _is.Include?> get includes => {};

  @override
  _is.Table<int?> get table => ProjectListing.t;
}

class ProjectListingIncludeList extends _is.IncludeList {
  ProjectListingIncludeList._({
    _is.WhereExpressionBuilder<ProjectListingTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(ProjectListing.t);
  }

  @override
  Map<String, _is.Include?> get includes => include?.includes ?? {};

  @override
  _is.Table<int?> get table => ProjectListing.t;
}

class ProjectListingRepository {
  const ProjectListingRepository._();

  /// Returns a list of [ProjectListing]s matching the given query parameters.
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
  Future<List<ProjectListing>> find(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<ProjectListingTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<ProjectListingTable>? orderBy,
    _is.OrderByListBuilder<ProjectListingTable>? orderByList,
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.find<ProjectListing>(
      where: where?.call(ProjectListing.t),
      orderBy: orderBy?.call(ProjectListing.t),
      orderByList: orderByList?.call(ProjectListing.t),
      limit: limit,
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Returns the first matching [ProjectListing] matching the given query parameters.
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
  Future<ProjectListing?> findFirstRow(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<ProjectListingTable>? where,
    int? offset,
    _is.OrderByBuilder<ProjectListingTable>? orderBy,
    _is.OrderByListBuilder<ProjectListingTable>? orderByList,
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findFirstRow<ProjectListing>(
      where: where?.call(ProjectListing.t),
      orderBy: orderBy?.call(ProjectListing.t),
      orderByList: orderByList?.call(ProjectListing.t),
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Finds a single [ProjectListing] by its [id] or null if no such row exists.
  Future<ProjectListing?> findById(
    _is.DatabaseSession session,
    int id, {
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findById<ProjectListing>(
      id,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Inserts all [ProjectListing]s in the list and returns the inserted rows.
  ///
  /// The returned [ProjectListing]s will have their `id` fields set.
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
  Future<List<ProjectListing>> insert(
    _is.DatabaseSession session,
    List<ProjectListing> rows, {
    _is.Transaction? transaction,
    bool ignoreConflicts = false,
    bool noReturn = false,
  }) async {
    return session.db.insert<ProjectListing>(
      rows,
      transaction: transaction,
      ignoreConflicts: ignoreConflicts,
      noReturn: noReturn,
    );
  }

  /// Inserts a single [ProjectListing] and returns the inserted row.
  ///
  /// The returned [ProjectListing] will have its `id` field set.
  Future<ProjectListing> insertRow(
    _is.DatabaseSession session,
    ProjectListing row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.insertRow<ProjectListing>(
      row,
      transaction: transaction,
    );
  }

  /// Upserts all [ProjectListing]s in the list and returns the resulting rows.
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
  /// The returned [ProjectListing]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails,
  /// none of the rows will be affected.
  ///
  /// If [noReturn] is set to `true`, the resulting rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<ProjectListing>> upsert(
    _is.DatabaseSession session,
    List<ProjectListing> rows, {
    required _is.ColumnSelections<ProjectListingTable> conflictColumns,
    _is.ColumnSelections<ProjectListingTable>? updateColumns,
    _is.WhereExpressionBuilder<ProjectListingTable>? updateWhere,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.upsert<ProjectListing>(
      rows,
      conflictColumns: conflictColumns(ProjectListing.t),
      updateColumns: updateColumns?.call(ProjectListing.t),
      updateWhere: updateWhere?.call(ProjectListing.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Upserts a single [ProjectListing] and returns the resulting row.
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
  /// The returned [ProjectListing] will have its `id` field set.
  Future<ProjectListing?> upsertRow(
    _is.DatabaseSession session,
    ProjectListing row, {
    required _is.ColumnSelections<ProjectListingTable> conflictColumns,
    _is.ColumnSelections<ProjectListingTable>? updateColumns,
    _is.WhereExpressionBuilder<ProjectListingTable>? updateWhere,
    _is.Transaction? transaction,
  }) async {
    return session.db.upsertRow<ProjectListing>(
      row,
      conflictColumns: conflictColumns(ProjectListing.t),
      updateColumns: updateColumns?.call(ProjectListing.t),
      updateWhere: updateWhere?.call(ProjectListing.t),
      transaction: transaction,
    );
  }

  /// Updates all [ProjectListing]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<ProjectListing>> update(
    _is.DatabaseSession session,
    List<ProjectListing> rows, {
    _is.ColumnSelections<ProjectListingTable>? columns,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.update<ProjectListing>(
      rows,
      columns: columns?.call(ProjectListing.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Updates a single [ProjectListing]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<ProjectListing> updateRow(
    _is.DatabaseSession session,
    ProjectListing row, {
    _is.ColumnSelections<ProjectListingTable>? columns,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateRow<ProjectListing>(
      row,
      columns: columns?.call(ProjectListing.t),
      transaction: transaction,
    );
  }

  /// Updates a single [ProjectListing] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<ProjectListing?> updateById(
    _is.DatabaseSession session,
    int id, {
    required _is.ColumnValueListBuilder<ProjectListingUpdateTable> columnValues,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateById<ProjectListing>(
      id,
      columnValues: columnValues(ProjectListing.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [ProjectListing]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<ProjectListing>> updateWhere(
    _is.DatabaseSession session, {
    required _is.ColumnValueListBuilder<ProjectListingUpdateTable> columnValues,
    required _is.WhereExpressionBuilder<ProjectListingTable> where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<ProjectListingTable>? orderBy,
    _is.OrderByListBuilder<ProjectListingTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.updateWhere<ProjectListing>(
      columnValues: columnValues(ProjectListing.t.updateTable),
      where: where(ProjectListing.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(ProjectListing.t),
      orderByList: orderByList?.call(ProjectListing.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes all [ProjectListing]s in the list and returns the deleted rows.
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
  Future<List<ProjectListing>> delete(
    _is.DatabaseSession session,
    List<ProjectListing> rows, {
    _is.OrderByBuilder<ProjectListingTable>? orderBy,
    _is.OrderByListBuilder<ProjectListingTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.delete<ProjectListing>(
      rows,
      orderBy: orderBy?.call(ProjectListing.t),
      orderByList: orderByList?.call(ProjectListing.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes a single [ProjectListing].
  Future<ProjectListing> deleteRow(
    _is.DatabaseSession session,
    ProjectListing row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.deleteRow<ProjectListing>(
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
  Future<List<ProjectListing>> deleteWhere(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<ProjectListingTable> where,
    _is.OrderByBuilder<ProjectListingTable>? orderBy,
    _is.OrderByListBuilder<ProjectListingTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.deleteWhere<ProjectListing>(
      where: where(ProjectListing.t),
      orderBy: orderBy?.call(ProjectListing.t),
      orderByList: orderByList?.call(ProjectListing.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<ProjectListingTable>? where,
    int? limit,
    _is.Transaction? transaction,
  }) async {
    return session.db.count<ProjectListing>(
      where: where?.call(ProjectListing.t),
      limit: limit,
      transaction: transaction,
    );
  }

  /// Acquires row-level locks on [ProjectListing] rows matching the [where] expression.
  Future<void> lockRows(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<ProjectListingTable> where,
    required _is.LockMode lockMode,
    required _is.Transaction transaction,
    _is.LockBehavior lockBehavior = _is.LockBehavior.wait,
  }) async {
    return session.db.lockRows<ProjectListing>(
      where: where(ProjectListing.t),
      lockMode: lockMode,
      lockBehavior: lockBehavior,
      transaction: transaction,
    );
  }
}
