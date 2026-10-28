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

abstract class StudyRequest
    implements _isc.SerializableModel, _isc.ProtocolSerialization {
  StudyRequest._({
    this.id,
    required this.senderId,
    required this.senderName,
    required this.senderBranch,
    this.senderAvatarUrl,
    required this.recipientId,
    required this.recipientName,
    required this.message,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
  });

  factory StudyRequest({
    int? id,
    required int senderId,
    required String senderName,
    required String senderBranch,
    String? senderAvatarUrl,
    required int recipientId,
    required String recipientName,
    required String message,
    required String status,
    required DateTime createdAt,
    required DateTime updatedAt,
  }) = _StudyRequestImpl;

  factory StudyRequest.fromJson(Map<String, dynamic> jsonSerialization) {
    return StudyRequest(
      id: jsonSerialization['id'] as int?,
      senderId: jsonSerialization['senderId'] as int,
      senderName: jsonSerialization['senderName'] as String,
      senderBranch: jsonSerialization['senderBranch'] as String,
      senderAvatarUrl: jsonSerialization['senderAvatarUrl'] as String?,
      recipientId: jsonSerialization['recipientId'] as int,
      recipientName: jsonSerialization['recipientName'] as String,
      message: jsonSerialization['message'] as String,
      status: jsonSerialization['status'] as String,
      createdAt: _isc.DateTimeJsonExtension.fromJson(
        jsonSerialization['createdAt'],
      ),
      updatedAt: _isc.DateTimeJsonExtension.fromJson(
        jsonSerialization['updatedAt'],
      ),
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  int? id;

  int senderId;

  String senderName;

  String senderBranch;

  String? senderAvatarUrl;

  int recipientId;

  String recipientName;

  String message;

  String status;

  DateTime createdAt;

  DateTime updatedAt;

  /// Returns a shallow copy of this [StudyRequest]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  StudyRequest copyWith({
    int? id,
    int? senderId,
    String? senderName,
    String? senderBranch,
    String? senderAvatarUrl,
    int? recipientId,
    String? recipientName,
    String? message,
    String? status,
    DateTime? createdAt,
    DateTime? updatedAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'StudyRequest',
      if (id != null) 'id': id,
      'senderId': senderId,
      'senderName': senderName,
      'senderBranch': senderBranch,
      if (senderAvatarUrl != null) 'senderAvatarUrl': senderAvatarUrl,
      'recipientId': recipientId,
      'recipientName': recipientName,
      'message': message,
      'status': status,
      'createdAt': createdAt.toJson(),
      'updatedAt': updatedAt.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'StudyRequest',
      if (id != null) 'id': id,
      'senderId': senderId,
      'senderName': senderName,
      'senderBranch': senderBranch,
      if (senderAvatarUrl != null) 'senderAvatarUrl': senderAvatarUrl,
      'recipientId': recipientId,
      'recipientName': recipientName,
      'message': message,
      'status': status,
      'createdAt': createdAt.toJson(),
      'updatedAt': updatedAt.toJson(),
    };
  }

  @override
  String toString() {
    return _isc.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _StudyRequestImpl extends StudyRequest {
  _StudyRequestImpl({
    int? id,
    required int senderId,
    required String senderName,
    required String senderBranch,
    String? senderAvatarUrl,
    required int recipientId,
    required String recipientName,
    required String message,
    required String status,
    required DateTime createdAt,
    required DateTime updatedAt,
  }) : super._(
         id: id,
         senderId: senderId,
         senderName: senderName,
         senderBranch: senderBranch,
         senderAvatarUrl: senderAvatarUrl,
         recipientId: recipientId,
         recipientName: recipientName,
         message: message,
         status: status,
         createdAt: createdAt,
         updatedAt: updatedAt,
       );

  /// Returns a shallow copy of this [StudyRequest]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  @override
  StudyRequest copyWith({
    Object? id = _Undefined,
    int? senderId,
    String? senderName,
    String? senderBranch,
    Object? senderAvatarUrl = _Undefined,
    int? recipientId,
    String? recipientName,
    String? message,
    String? status,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return StudyRequest(
      id: id is int? ? id : this.id,
      senderId: senderId ?? this.senderId,
      senderName: senderName ?? this.senderName,
      senderBranch: senderBranch ?? this.senderBranch,
      senderAvatarUrl: senderAvatarUrl is String?
          ? senderAvatarUrl
          : this.senderAvatarUrl,
      recipientId: recipientId ?? this.recipientId,
      recipientName: recipientName ?? this.recipientName,
      message: message ?? this.message,
      status: status ?? this.status,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}
