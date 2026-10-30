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
import 'package:serverpod_client/serverpod_client.dart' as _isc;

abstract class PlannerItem
    implements _isc.SerializableModel, _isc.ProtocolSerialization {
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
      isCompleted: _isc.BoolJsonExtension.fromJson(
        jsonSerialization['isCompleted'],
      ),
      createdAt: _isc.DateTimeJsonExtension.fromJson(
        jsonSerialization['createdAt'],
      ),
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
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

  /// Returns a shallow copy of this [PlannerItem]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
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

  @override
  String toString() {
    return _isc.SerializationManager.encode(this);
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
  @_isc.useResult
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
