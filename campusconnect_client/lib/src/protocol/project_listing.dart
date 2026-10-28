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

abstract class ProjectListing
    implements _isc.SerializableModel, _isc.ProtocolSerialization {
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
      techStack: _im7konmk.Protocol().deserialize<List<String>>(
        jsonSerialization['techStack'],
      ),
      requiredSkills: _im7konmk.Protocol().deserialize<List<String>>(
        jsonSerialization['requiredSkills'],
      ),
      category: jsonSerialization['category'] as String,
      totalPositions: jsonSerialization['totalPositions'] as int,
      openPositions: jsonSerialization['openPositions'] as int,
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

  /// Returns a shallow copy of this [ProjectListing]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
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

  @override
  String toString() {
    return _isc.SerializationManager.encode(this);
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
  @_isc.useResult
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
