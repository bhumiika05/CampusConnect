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

abstract class StudentProfile
    implements _isc.SerializableModel, _isc.ProtocolSerialization {
  StudentProfile._({
    this.id,
    this.userId,
    required this.name,
    required this.email,
    required this.branch,
    required this.academicYear,
    required this.bio,
    this.avatarUrl,
    required this.skills,
    required this.interests,
    required this.isOrganizer,
    required this.createdAt,
    required this.updatedAt,
  });

  factory StudentProfile({
    int? id,
    int? userId,
    required String name,
    required String email,
    required String branch,
    required String academicYear,
    required String bio,
    String? avatarUrl,
    required List<String> skills,
    required List<String> interests,
    required bool isOrganizer,
    required DateTime createdAt,
    required DateTime updatedAt,
  }) = _StudentProfileImpl;

  factory StudentProfile.fromJson(Map<String, dynamic> jsonSerialization) {
    return StudentProfile(
      id: jsonSerialization['id'] as int?,
      userId: jsonSerialization['userId'] as int?,
      name: jsonSerialization['name'] as String,
      email: jsonSerialization['email'] as String,
      branch: jsonSerialization['branch'] as String,
      academicYear: jsonSerialization['academicYear'] as String,
      bio: jsonSerialization['bio'] as String,
      avatarUrl: jsonSerialization['avatarUrl'] as String?,
      skills: _im7konmk.Protocol().deserialize<List<String>>(
        jsonSerialization['skills'],
      ),
      interests: _im7konmk.Protocol().deserialize<List<String>>(
        jsonSerialization['interests'],
      ),
      isOrganizer: _isc.BoolJsonExtension.fromJson(
        jsonSerialization['isOrganizer'],
      ),
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

  int? userId;

  String name;

  String email;

  String branch;

  String academicYear;

  String bio;

  String? avatarUrl;

  List<String> skills;

  List<String> interests;

  bool isOrganizer;

  DateTime createdAt;

  DateTime updatedAt;

  /// Returns a shallow copy of this [StudentProfile]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  StudentProfile copyWith({
    int? id,
    int? userId,
    String? name,
    String? email,
    String? branch,
    String? academicYear,
    String? bio,
    String? avatarUrl,
    List<String>? skills,
    List<String>? interests,
    bool? isOrganizer,
    DateTime? createdAt,
    DateTime? updatedAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'StudentProfile',
      if (id != null) 'id': id,
      if (userId != null) 'userId': userId,
      'name': name,
      'email': email,
      'branch': branch,
      'academicYear': academicYear,
      'bio': bio,
      if (avatarUrl != null) 'avatarUrl': avatarUrl,
      'skills': skills.toJson(),
      'interests': interests.toJson(),
      'isOrganizer': isOrganizer,
      'createdAt': createdAt.toJson(),
      'updatedAt': updatedAt.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'StudentProfile',
      if (id != null) 'id': id,
      if (userId != null) 'userId': userId,
      'name': name,
      'email': email,
      'branch': branch,
      'academicYear': academicYear,
      'bio': bio,
      if (avatarUrl != null) 'avatarUrl': avatarUrl,
      'skills': skills.toJson(),
      'interests': interests.toJson(),
      'isOrganizer': isOrganizer,
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

class _StudentProfileImpl extends StudentProfile {
  _StudentProfileImpl({
    int? id,
    int? userId,
    required String name,
    required String email,
    required String branch,
    required String academicYear,
    required String bio,
    String? avatarUrl,
    required List<String> skills,
    required List<String> interests,
    required bool isOrganizer,
    required DateTime createdAt,
    required DateTime updatedAt,
  }) : super._(
         id: id,
         userId: userId,
         name: name,
         email: email,
         branch: branch,
         academicYear: academicYear,
         bio: bio,
         avatarUrl: avatarUrl,
         skills: skills,
         interests: interests,
         isOrganizer: isOrganizer,
         createdAt: createdAt,
         updatedAt: updatedAt,
       );

  /// Returns a shallow copy of this [StudentProfile]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  @override
  StudentProfile copyWith({
    Object? id = _Undefined,
    Object? userId = _Undefined,
    String? name,
    String? email,
    String? branch,
    String? academicYear,
    String? bio,
    Object? avatarUrl = _Undefined,
    List<String>? skills,
    List<String>? interests,
    bool? isOrganizer,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return StudentProfile(
      id: id is int? ? id : this.id,
      userId: userId is int? ? userId : this.userId,
      name: name ?? this.name,
      email: email ?? this.email,
      branch: branch ?? this.branch,
      academicYear: academicYear ?? this.academicYear,
      bio: bio ?? this.bio,
      avatarUrl: avatarUrl is String? ? avatarUrl : this.avatarUrl,
      skills: skills ?? this.skills.map((e0) => e0).toList(),
      interests: interests ?? this.interests.map((e0) => e0).toList(),
      isOrganizer: isOrganizer ?? this.isOrganizer,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}
