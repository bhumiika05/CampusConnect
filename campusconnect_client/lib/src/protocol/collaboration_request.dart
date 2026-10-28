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
import 'package:campusconnect_client/src/protocol/protocol.dart' as _im7konmk;
import 'package:serverpod_client/serverpod_client.dart' as _isc;

abstract class CollaborationRequest
    implements _isc.SerializableModel, _isc.ProtocolSerialization {
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
      studentSkills: _im7konmk.Protocol().deserialize<List<String>>(
        jsonSerialization['studentSkills'],
      ),
      message: jsonSerialization['message'] as String,
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

  /// Returns a shallow copy of this [CollaborationRequest]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
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

  @override
  String toString() {
    return _isc.SerializationManager.encode(this);
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
  @_isc.useResult
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
