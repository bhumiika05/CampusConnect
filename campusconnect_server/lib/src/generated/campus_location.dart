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

abstract class CampusLocation
    implements _is.TableRow<int?>, _is.ProtocolSerialization {
  CampusLocation._({
    this.id,
    required this.name,
    required this.category,
    required this.shortDescription,
    required this.latitude,
    required this.longitude,
    this.buildingBlock,
    this.openingHours,
    this.contactInfo,
    this.website,
    this.accessibilityInfo,
    required this.isVerified,
    this.tags,
  });

  factory CampusLocation({
    int? id,
    required String name,
    required String category,
    required String shortDescription,
    required double latitude,
    required double longitude,
    String? buildingBlock,
    String? openingHours,
    String? contactInfo,
    String? website,
    String? accessibilityInfo,
    required bool isVerified,
    List<String>? tags,
  }) = _CampusLocationImpl;

  factory CampusLocation.fromJson(Map<String, dynamic> jsonSerialization) {
    return CampusLocation(
      id: jsonSerialization['id'] as int?,
      name: jsonSerialization['name'] as String,
      category: jsonSerialization['category'] as String,
      shortDescription: jsonSerialization['shortDescription'] as String,
      latitude: (jsonSerialization['latitude'] as num).toDouble(),
      longitude: (jsonSerialization['longitude'] as num).toDouble(),
      buildingBlock: jsonSerialization['buildingBlock'] as String?,
      openingHours: jsonSerialization['openingHours'] as String?,
      contactInfo: jsonSerialization['contactInfo'] as String?,
      website: jsonSerialization['website'] as String?,
      accessibilityInfo: jsonSerialization['accessibilityInfo'] as String?,
      isVerified: _is.BoolJsonExtension.fromJson(
        jsonSerialization['isVerified'],
      ),
      tags: jsonSerialization['tags'] == null
          ? null
          : _iusjeinx.Protocol().deserialize<List<String>>(
              jsonSerialization['tags'],
            ),
    );
  }

  static final t = CampusLocationTable();

  static const db = CampusLocationRepository._();

  @override
  int? id;

  String name;

  String category;

  String shortDescription;

  double latitude;

  double longitude;

  String? buildingBlock;

  String? openingHours;

  String? contactInfo;

  String? website;

  String? accessibilityInfo;

  bool isVerified;

  List<String>? tags;

  @override
  _is.Table<int?> get table => t;

  /// Returns a shallow copy of this [CampusLocation]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  CampusLocation copyWith({
    int? id,
    String? name,
    String? category,
    String? shortDescription,
    double? latitude,
    double? longitude,
    String? buildingBlock,
    String? openingHours,
    String? contactInfo,
    String? website,
    String? accessibilityInfo,
    bool? isVerified,
    List<String>? tags,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'CampusLocation',
      if (id != null) 'id': id,
      'name': name,
      'category': category,
      'shortDescription': shortDescription,
      'latitude': latitude,
      'longitude': longitude,
      if (buildingBlock != null) 'buildingBlock': buildingBlock,
      if (openingHours != null) 'openingHours': openingHours,
      if (contactInfo != null) 'contactInfo': contactInfo,
      if (website != null) 'website': website,
      if (accessibilityInfo != null) 'accessibilityInfo': accessibilityInfo,
      'isVerified': isVerified,
      if (tags != null) 'tags': tags?.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'CampusLocation',
      if (id != null) 'id': id,
      'name': name,
      'category': category,
      'shortDescription': shortDescription,
      'latitude': latitude,
      'longitude': longitude,
      if (buildingBlock != null) 'buildingBlock': buildingBlock,
      if (openingHours != null) 'openingHours': openingHours,
      if (contactInfo != null) 'contactInfo': contactInfo,
      if (website != null) 'website': website,
      if (accessibilityInfo != null) 'accessibilityInfo': accessibilityInfo,
      'isVerified': isVerified,
      if (tags != null) 'tags': tags?.toJson(),
    };
  }

  static CampusLocationInclude include() {
    return CampusLocationInclude._();
  }

  static CampusLocationIncludeList includeList({
    _is.WhereExpressionBuilder<CampusLocationTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<CampusLocationTable>? orderBy,
    _is.OrderByListBuilder<CampusLocationTable>? orderByList,
    CampusLocationInclude? include,
  }) {
    return CampusLocationIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(CampusLocation.t),
      orderByList: orderByList?.call(CampusLocation.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _is.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _CampusLocationImpl extends CampusLocation {
  _CampusLocationImpl({
    int? id,
    required String name,
    required String category,
    required String shortDescription,
    required double latitude,
    required double longitude,
    String? buildingBlock,
    String? openingHours,
    String? contactInfo,
    String? website,
    String? accessibilityInfo,
    required bool isVerified,
    List<String>? tags,
  }) : super._(
         id: id,
         name: name,
         category: category,
         shortDescription: shortDescription,
         latitude: latitude,
         longitude: longitude,
         buildingBlock: buildingBlock,
         openingHours: openingHours,
         contactInfo: contactInfo,
         website: website,
         accessibilityInfo: accessibilityInfo,
         isVerified: isVerified,
         tags: tags,
       );

  /// Returns a shallow copy of this [CampusLocation]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  @override
  CampusLocation copyWith({
    Object? id = _Undefined,
    String? name,
    String? category,
    String? shortDescription,
    double? latitude,
    double? longitude,
    Object? buildingBlock = _Undefined,
    Object? openingHours = _Undefined,
    Object? contactInfo = _Undefined,
    Object? website = _Undefined,
    Object? accessibilityInfo = _Undefined,
    bool? isVerified,
    Object? tags = _Undefined,
  }) {
    return CampusLocation(
      id: id is int? ? id : this.id,
      name: name ?? this.name,
      category: category ?? this.category,
      shortDescription: shortDescription ?? this.shortDescription,
      latitude: latitude ?? this.latitude,
      longitude: longitude ?? this.longitude,
      buildingBlock: buildingBlock is String?
          ? buildingBlock
          : this.buildingBlock,
      openingHours: openingHours is String? ? openingHours : this.openingHours,
      contactInfo: contactInfo is String? ? contactInfo : this.contactInfo,
      website: website is String? ? website : this.website,
      accessibilityInfo: accessibilityInfo is String?
          ? accessibilityInfo
          : this.accessibilityInfo,
      isVerified: isVerified ?? this.isVerified,
      tags: tags is List<String>? ? tags : this.tags?.map((e0) => e0).toList(),
    );
  }
}

class CampusLocationUpdateTable extends _is.UpdateTable<CampusLocationTable> {
  CampusLocationUpdateTable(super.table);

  _is.ColumnValue<String, String> name(String value) => _is.ColumnValue(
    table.name,
    value,
  );

  _is.ColumnValue<String, String> category(String value) => _is.ColumnValue(
    table.category,
    value,
  );

  _is.ColumnValue<String, String> shortDescription(String value) =>
      _is.ColumnValue(
        table.shortDescription,
        value,
      );

  _is.ColumnValue<double, double> latitude(double value) => _is.ColumnValue(
    table.latitude,
    value,
  );

  _is.ColumnValue<double, double> longitude(double value) => _is.ColumnValue(
    table.longitude,
    value,
  );

  _is.ColumnValue<String, String> buildingBlock(String? value) =>
      _is.ColumnValue(
        table.buildingBlock,
        value,
      );

  _is.ColumnValue<String, String> openingHours(String? value) =>
      _is.ColumnValue(
        table.openingHours,
        value,
      );

  _is.ColumnValue<String, String> contactInfo(String? value) => _is.ColumnValue(
    table.contactInfo,
    value,
  );

  _is.ColumnValue<String, String> website(String? value) => _is.ColumnValue(
    table.website,
    value,
  );

  _is.ColumnValue<String, String> accessibilityInfo(String? value) =>
      _is.ColumnValue(
        table.accessibilityInfo,
        value,
      );

  _is.ColumnValue<bool, bool> isVerified(bool value) => _is.ColumnValue(
    table.isVerified,
    value,
  );

  _is.ColumnValue<List<String>, List<String>> tags(List<String>? value) =>
      _is.ColumnValue(
        table.tags,
        value,
      );
}

class CampusLocationTable extends _is.Table<int?> {
  CampusLocationTable({super.tableRelation})
    : super(tableName: 'campus_location') {
    updateTable = CampusLocationUpdateTable(this);
    name = _is.ColumnString(
      'name',
      this,
    );
    category = _is.ColumnString(
      'category',
      this,
    );
    shortDescription = _is.ColumnString(
      'shortDescription',
      this,
    );
    latitude = _is.ColumnDouble(
      'latitude',
      this,
    );
    longitude = _is.ColumnDouble(
      'longitude',
      this,
    );
    buildingBlock = _is.ColumnString(
      'buildingBlock',
      this,
    );
    openingHours = _is.ColumnString(
      'openingHours',
      this,
    );
    contactInfo = _is.ColumnString(
      'contactInfo',
      this,
    );
    website = _is.ColumnString(
      'website',
      this,
    );
    accessibilityInfo = _is.ColumnString(
      'accessibilityInfo',
      this,
    );
    isVerified = _is.ColumnBool(
      'isVerified',
      this,
    );
    tags = _is.ColumnSerializable<List<String>>(
      'tags',
      this,
    );
  }

  late final CampusLocationUpdateTable updateTable;

  late final _is.ColumnString name;

  late final _is.ColumnString category;

  late final _is.ColumnString shortDescription;

  late final _is.ColumnDouble latitude;

  late final _is.ColumnDouble longitude;

  late final _is.ColumnString buildingBlock;

  late final _is.ColumnString openingHours;

  late final _is.ColumnString contactInfo;

  late final _is.ColumnString website;

  late final _is.ColumnString accessibilityInfo;

  late final _is.ColumnBool isVerified;

  late final _is.ColumnSerializable<List<String>> tags;

  @override
  List<_is.Column> get columns => [
    id,
    name,
    category,
    shortDescription,
    latitude,
    longitude,
    buildingBlock,
    openingHours,
    contactInfo,
    website,
    accessibilityInfo,
    isVerified,
    tags,
  ];
}

class CampusLocationInclude extends _is.IncludeObject {
  CampusLocationInclude._();

  @override
  Map<String, _is.Include?> get includes => {};

  @override
  _is.Table<int?> get table => CampusLocation.t;
}

class CampusLocationIncludeList extends _is.IncludeList {
  CampusLocationIncludeList._({
    _is.WhereExpressionBuilder<CampusLocationTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(CampusLocation.t);
  }

  @override
  Map<String, _is.Include?> get includes => include?.includes ?? {};

  @override
  _is.Table<int?> get table => CampusLocation.t;
}

class CampusLocationRepository {
  const CampusLocationRepository._();

  /// Returns a list of [CampusLocation]s matching the given query parameters.
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
  Future<List<CampusLocation>> find(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<CampusLocationTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<CampusLocationTable>? orderBy,
    _is.OrderByListBuilder<CampusLocationTable>? orderByList,
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.find<CampusLocation>(
      where: where?.call(CampusLocation.t),
      orderBy: orderBy?.call(CampusLocation.t),
      orderByList: orderByList?.call(CampusLocation.t),
      limit: limit,
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Returns the first matching [CampusLocation] matching the given query parameters.
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
  Future<CampusLocation?> findFirstRow(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<CampusLocationTable>? where,
    int? offset,
    _is.OrderByBuilder<CampusLocationTable>? orderBy,
    _is.OrderByListBuilder<CampusLocationTable>? orderByList,
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findFirstRow<CampusLocation>(
      where: where?.call(CampusLocation.t),
      orderBy: orderBy?.call(CampusLocation.t),
      orderByList: orderByList?.call(CampusLocation.t),
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Finds a single [CampusLocation] by its [id] or null if no such row exists.
  Future<CampusLocation?> findById(
    _is.DatabaseSession session,
    int id, {
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findById<CampusLocation>(
      id,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Inserts all [CampusLocation]s in the list and returns the inserted rows.
  ///
  /// The returned [CampusLocation]s will have their `id` fields set.
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
  Future<List<CampusLocation>> insert(
    _is.DatabaseSession session,
    List<CampusLocation> rows, {
    _is.Transaction? transaction,
    bool ignoreConflicts = false,
    bool noReturn = false,
  }) async {
    return session.db.insert<CampusLocation>(
      rows,
      transaction: transaction,
      ignoreConflicts: ignoreConflicts,
      noReturn: noReturn,
    );
  }

  /// Inserts a single [CampusLocation] and returns the inserted row.
  ///
  /// The returned [CampusLocation] will have its `id` field set.
  Future<CampusLocation> insertRow(
    _is.DatabaseSession session,
    CampusLocation row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.insertRow<CampusLocation>(
      row,
      transaction: transaction,
    );
  }

  /// Upserts all [CampusLocation]s in the list and returns the resulting rows.
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
  /// The returned [CampusLocation]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails,
  /// none of the rows will be affected.
  ///
  /// If [noReturn] is set to `true`, the resulting rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<CampusLocation>> upsert(
    _is.DatabaseSession session,
    List<CampusLocation> rows, {
    required _is.ColumnSelections<CampusLocationTable> conflictColumns,
    _is.ColumnSelections<CampusLocationTable>? updateColumns,
    _is.WhereExpressionBuilder<CampusLocationTable>? updateWhere,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.upsert<CampusLocation>(
      rows,
      conflictColumns: conflictColumns(CampusLocation.t),
      updateColumns: updateColumns?.call(CampusLocation.t),
      updateWhere: updateWhere?.call(CampusLocation.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Upserts a single [CampusLocation] and returns the resulting row.
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
  /// The returned [CampusLocation] will have its `id` field set.
  Future<CampusLocation?> upsertRow(
    _is.DatabaseSession session,
    CampusLocation row, {
    required _is.ColumnSelections<CampusLocationTable> conflictColumns,
    _is.ColumnSelections<CampusLocationTable>? updateColumns,
    _is.WhereExpressionBuilder<CampusLocationTable>? updateWhere,
    _is.Transaction? transaction,
  }) async {
    return session.db.upsertRow<CampusLocation>(
      row,
      conflictColumns: conflictColumns(CampusLocation.t),
      updateColumns: updateColumns?.call(CampusLocation.t),
      updateWhere: updateWhere?.call(CampusLocation.t),
      transaction: transaction,
    );
  }

  /// Updates all [CampusLocation]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<CampusLocation>> update(
    _is.DatabaseSession session,
    List<CampusLocation> rows, {
    _is.ColumnSelections<CampusLocationTable>? columns,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.update<CampusLocation>(
      rows,
      columns: columns?.call(CampusLocation.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Updates a single [CampusLocation]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<CampusLocation> updateRow(
    _is.DatabaseSession session,
    CampusLocation row, {
    _is.ColumnSelections<CampusLocationTable>? columns,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateRow<CampusLocation>(
      row,
      columns: columns?.call(CampusLocation.t),
      transaction: transaction,
    );
  }

  /// Updates a single [CampusLocation] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<CampusLocation?> updateById(
    _is.DatabaseSession session,
    int id, {
    required _is.ColumnValueListBuilder<CampusLocationUpdateTable> columnValues,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateById<CampusLocation>(
      id,
      columnValues: columnValues(CampusLocation.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [CampusLocation]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<CampusLocation>> updateWhere(
    _is.DatabaseSession session, {
    required _is.ColumnValueListBuilder<CampusLocationUpdateTable> columnValues,
    required _is.WhereExpressionBuilder<CampusLocationTable> where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<CampusLocationTable>? orderBy,
    _is.OrderByListBuilder<CampusLocationTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.updateWhere<CampusLocation>(
      columnValues: columnValues(CampusLocation.t.updateTable),
      where: where(CampusLocation.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(CampusLocation.t),
      orderByList: orderByList?.call(CampusLocation.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes all [CampusLocation]s in the list and returns the deleted rows.
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
  Future<List<CampusLocation>> delete(
    _is.DatabaseSession session,
    List<CampusLocation> rows, {
    _is.OrderByBuilder<CampusLocationTable>? orderBy,
    _is.OrderByListBuilder<CampusLocationTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.delete<CampusLocation>(
      rows,
      orderBy: orderBy?.call(CampusLocation.t),
      orderByList: orderByList?.call(CampusLocation.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes a single [CampusLocation].
  Future<CampusLocation> deleteRow(
    _is.DatabaseSession session,
    CampusLocation row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.deleteRow<CampusLocation>(
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
  Future<List<CampusLocation>> deleteWhere(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<CampusLocationTable> where,
    _is.OrderByBuilder<CampusLocationTable>? orderBy,
    _is.OrderByListBuilder<CampusLocationTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.deleteWhere<CampusLocation>(
      where: where(CampusLocation.t),
      orderBy: orderBy?.call(CampusLocation.t),
      orderByList: orderByList?.call(CampusLocation.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<CampusLocationTable>? where,
    int? limit,
    _is.Transaction? transaction,
  }) async {
    return session.db.count<CampusLocation>(
      where: where?.call(CampusLocation.t),
      limit: limit,
      transaction: transaction,
    );
  }

  /// Acquires row-level locks on [CampusLocation] rows matching the [where] expression.
  Future<void> lockRows(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<CampusLocationTable> where,
    required _is.LockMode lockMode,
    required _is.Transaction transaction,
    _is.LockBehavior lockBehavior = _is.LockBehavior.wait,
  }) async {
    return session.db.lockRows<CampusLocation>(
      where: where(CampusLocation.t),
      lockMode: lockMode,
      lockBehavior: lockBehavior,
      transaction: transaction,
    );
  }
}
