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

abstract class EventBookmark
    implements _isc.SerializableModel, _isc.ProtocolSerialization {
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

  int eventId;

  DateTime createdAt;

  /// Returns a shallow copy of this [EventBookmark]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
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

  @override
  String toString() {
    return _isc.SerializationManager.encode(this);
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
  @_isc.useResult
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
