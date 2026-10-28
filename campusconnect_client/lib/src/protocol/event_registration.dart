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

abstract class EventRegistration
    implements _isc.SerializableModel, _isc.ProtocolSerialization {
  EventRegistration._({
    this.id,
    required this.studentId,
    required this.studentName,
    required this.studentEmail,
    required this.eventId,
    required this.eventTitle,
    required this.status,
    required this.createdAt,
  });

  factory EventRegistration({
    int? id,
    required int studentId,
    required String studentName,
    required String studentEmail,
    required int eventId,
    required String eventTitle,
    required String status,
    required DateTime createdAt,
  }) = _EventRegistrationImpl;

  factory EventRegistration.fromJson(Map<String, dynamic> jsonSerialization) {
    return EventRegistration(
      id: jsonSerialization['id'] as int?,
      studentId: jsonSerialization['studentId'] as int,
      studentName: jsonSerialization['studentName'] as String,
      studentEmail: jsonSerialization['studentEmail'] as String,
      eventId: jsonSerialization['eventId'] as int,
      eventTitle: jsonSerialization['eventTitle'] as String,
      status: jsonSerialization['status'] as String,
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

  String studentName;

  String studentEmail;

  int eventId;

  String eventTitle;

  String status;

  DateTime createdAt;

  /// Returns a shallow copy of this [EventRegistration]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  EventRegistration copyWith({
    int? id,
    int? studentId,
    String? studentName,
    String? studentEmail,
    int? eventId,
    String? eventTitle,
    String? status,
    DateTime? createdAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'EventRegistration',
      if (id != null) 'id': id,
      'studentId': studentId,
      'studentName': studentName,
      'studentEmail': studentEmail,
      'eventId': eventId,
      'eventTitle': eventTitle,
      'status': status,
      'createdAt': createdAt.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'EventRegistration',
      if (id != null) 'id': id,
      'studentId': studentId,
      'studentName': studentName,
      'studentEmail': studentEmail,
      'eventId': eventId,
      'eventTitle': eventTitle,
      'status': status,
      'createdAt': createdAt.toJson(),
    };
  }

  @override
  String toString() {
    return _isc.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _EventRegistrationImpl extends EventRegistration {
  _EventRegistrationImpl({
    int? id,
    required int studentId,
    required String studentName,
    required String studentEmail,
    required int eventId,
    required String eventTitle,
    required String status,
    required DateTime createdAt,
  }) : super._(
         id: id,
         studentId: studentId,
         studentName: studentName,
         studentEmail: studentEmail,
         eventId: eventId,
         eventTitle: eventTitle,
         status: status,
         createdAt: createdAt,
       );

  /// Returns a shallow copy of this [EventRegistration]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  @override
  EventRegistration copyWith({
    Object? id = _Undefined,
    int? studentId,
    String? studentName,
    String? studentEmail,
    int? eventId,
    String? eventTitle,
    String? status,
    DateTime? createdAt,
  }) {
    return EventRegistration(
      id: id is int? ? id : this.id,
      studentId: studentId ?? this.studentId,
      studentName: studentName ?? this.studentName,
      studentEmail: studentEmail ?? this.studentEmail,
      eventId: eventId ?? this.eventId,
      eventTitle: eventTitle ?? this.eventTitle,
      status: status ?? this.status,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}
