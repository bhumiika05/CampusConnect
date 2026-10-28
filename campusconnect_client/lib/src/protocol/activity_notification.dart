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

abstract class ActivityNotification
    implements _isc.SerializableModel, _isc.ProtocolSerialization {
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
      isRead: _isc.BoolJsonExtension.fromJson(jsonSerialization['isRead']),
      createdAt: _isc.DateTimeJsonExtension.fromJson(
        jsonSerialization['createdAt'],
      ),
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  int? id;

  int recipientId;

  String activityType;

  String title;

  String message;

  bool isRead;

  DateTime createdAt;

  /// Returns a shallow copy of this [ActivityNotification]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
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

  @override
  String toString() {
    return _isc.SerializationManager.encode(this);
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
  @_isc.useResult
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
