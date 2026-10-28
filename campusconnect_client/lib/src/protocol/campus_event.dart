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

abstract class CampusEvent
    implements _isc.SerializableModel, _isc.ProtocolSerialization {
  CampusEvent._({
    this.id,
    required this.title,
    required this.description,
    required this.category,
    required this.venue,
    required this.startTime,
    required this.endTime,
    required this.organizer,
    this.organizerId,
    required this.isPublished,
    required this.capacity,
    required this.registeredCount,
    this.bannerColor,
    required this.createdAt,
  });

  factory CampusEvent({
    int? id,
    required String title,
    required String description,
    required String category,
    required String venue,
    required DateTime startTime,
    required DateTime endTime,
    required String organizer,
    int? organizerId,
    required bool isPublished,
    required int capacity,
    required int registeredCount,
    String? bannerColor,
    required DateTime createdAt,
  }) = _CampusEventImpl;

  factory CampusEvent.fromJson(Map<String, dynamic> jsonSerialization) {
    return CampusEvent(
      id: jsonSerialization['id'] as int?,
      title: jsonSerialization['title'] as String,
      description: jsonSerialization['description'] as String,
      category: jsonSerialization['category'] as String,
      venue: jsonSerialization['venue'] as String,
      startTime: _isc.DateTimeJsonExtension.fromJson(
        jsonSerialization['startTime'],
      ),
      endTime: _isc.DateTimeJsonExtension.fromJson(
        jsonSerialization['endTime'],
      ),
      organizer: jsonSerialization['organizer'] as String,
      organizerId: jsonSerialization['organizerId'] as int?,
      isPublished: _isc.BoolJsonExtension.fromJson(
        jsonSerialization['isPublished'],
      ),
      capacity: jsonSerialization['capacity'] as int,
      registeredCount: jsonSerialization['registeredCount'] as int,
      bannerColor: jsonSerialization['bannerColor'] as String?,
      createdAt: _isc.DateTimeJsonExtension.fromJson(
        jsonSerialization['createdAt'],
      ),
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  int? id;

  String title;

  String description;

  String category;

  String venue;

  DateTime startTime;

  DateTime endTime;

  String organizer;

  int? organizerId;

  bool isPublished;

  int capacity;

  int registeredCount;

  String? bannerColor;

  DateTime createdAt;

  /// Returns a shallow copy of this [CampusEvent]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  CampusEvent copyWith({
    int? id,
    String? title,
    String? description,
    String? category,
    String? venue,
    DateTime? startTime,
    DateTime? endTime,
    String? organizer,
    int? organizerId,
    bool? isPublished,
    int? capacity,
    int? registeredCount,
    String? bannerColor,
    DateTime? createdAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'CampusEvent',
      if (id != null) 'id': id,
      'title': title,
      'description': description,
      'category': category,
      'venue': venue,
      'startTime': startTime.toJson(),
      'endTime': endTime.toJson(),
      'organizer': organizer,
      if (organizerId != null) 'organizerId': organizerId,
      'isPublished': isPublished,
      'capacity': capacity,
      'registeredCount': registeredCount,
      if (bannerColor != null) 'bannerColor': bannerColor,
      'createdAt': createdAt.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'CampusEvent',
      if (id != null) 'id': id,
      'title': title,
      'description': description,
      'category': category,
      'venue': venue,
      'startTime': startTime.toJson(),
      'endTime': endTime.toJson(),
      'organizer': organizer,
      if (organizerId != null) 'organizerId': organizerId,
      'isPublished': isPublished,
      'capacity': capacity,
      'registeredCount': registeredCount,
      if (bannerColor != null) 'bannerColor': bannerColor,
      'createdAt': createdAt.toJson(),
    };
  }

  @override
  String toString() {
    return _isc.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _CampusEventImpl extends CampusEvent {
  _CampusEventImpl({
    int? id,
    required String title,
    required String description,
    required String category,
    required String venue,
    required DateTime startTime,
    required DateTime endTime,
    required String organizer,
    int? organizerId,
    required bool isPublished,
    required int capacity,
    required int registeredCount,
    String? bannerColor,
    required DateTime createdAt,
  }) : super._(
         id: id,
         title: title,
         description: description,
         category: category,
         venue: venue,
         startTime: startTime,
         endTime: endTime,
         organizer: organizer,
         organizerId: organizerId,
         isPublished: isPublished,
         capacity: capacity,
         registeredCount: registeredCount,
         bannerColor: bannerColor,
         createdAt: createdAt,
       );

  /// Returns a shallow copy of this [CampusEvent]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  @override
  CampusEvent copyWith({
    Object? id = _Undefined,
    String? title,
    String? description,
    String? category,
    String? venue,
    DateTime? startTime,
    DateTime? endTime,
    String? organizer,
    Object? organizerId = _Undefined,
    bool? isPublished,
    int? capacity,
    int? registeredCount,
    Object? bannerColor = _Undefined,
    DateTime? createdAt,
  }) {
    return CampusEvent(
      id: id is int? ? id : this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      category: category ?? this.category,
      venue: venue ?? this.venue,
      startTime: startTime ?? this.startTime,
      endTime: endTime ?? this.endTime,
      organizer: organizer ?? this.organizer,
      organizerId: organizerId is int? ? organizerId : this.organizerId,
      isPublished: isPublished ?? this.isPublished,
      capacity: capacity ?? this.capacity,
      registeredCount: registeredCount ?? this.registeredCount,
      bannerColor: bannerColor is String? ? bannerColor : this.bannerColor,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}
