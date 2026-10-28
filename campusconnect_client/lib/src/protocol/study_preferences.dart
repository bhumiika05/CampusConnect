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

abstract class StudyPreferences
    implements _isc.SerializableModel, _isc.ProtocolSerialization {
  StudyPreferences._({
    this.id,
    required this.studentId,
    required this.subjects,
    required this.technicalInterests,
    required this.preferredTimings,
    required this.studyMode,
    required this.learningGoals,
    required this.skillLevel,
    required this.updatedAt,
  });

  factory StudyPreferences({
    int? id,
    required int studentId,
    required List<String> subjects,
    required List<String> technicalInterests,
    required List<String> preferredTimings,
    required String studyMode,
    required List<String> learningGoals,
    required String skillLevel,
    required DateTime updatedAt,
  }) = _StudyPreferencesImpl;

  factory StudyPreferences.fromJson(Map<String, dynamic> jsonSerialization) {
    return StudyPreferences(
      id: jsonSerialization['id'] as int?,
      studentId: jsonSerialization['studentId'] as int,
      subjects: _im7konmk.Protocol().deserialize<List<String>>(
        jsonSerialization['subjects'],
      ),
      technicalInterests: _im7konmk.Protocol().deserialize<List<String>>(
        jsonSerialization['technicalInterests'],
      ),
      preferredTimings: _im7konmk.Protocol().deserialize<List<String>>(
        jsonSerialization['preferredTimings'],
      ),
      studyMode: jsonSerialization['studyMode'] as String,
      learningGoals: _im7konmk.Protocol().deserialize<List<String>>(
        jsonSerialization['learningGoals'],
      ),
      skillLevel: jsonSerialization['skillLevel'] as String,
      updatedAt: _isc.DateTimeJsonExtension.fromJson(
        jsonSerialization['updatedAt'],
      ),
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  int? id;

  int studentId;

  List<String> subjects;

  List<String> technicalInterests;

  List<String> preferredTimings;

  String studyMode;

  List<String> learningGoals;

  String skillLevel;

  DateTime updatedAt;

  /// Returns a shallow copy of this [StudyPreferences]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  StudyPreferences copyWith({
    int? id,
    int? studentId,
    List<String>? subjects,
    List<String>? technicalInterests,
    List<String>? preferredTimings,
    String? studyMode,
    List<String>? learningGoals,
    String? skillLevel,
    DateTime? updatedAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'StudyPreferences',
      if (id != null) 'id': id,
      'studentId': studentId,
      'subjects': subjects.toJson(),
      'technicalInterests': technicalInterests.toJson(),
      'preferredTimings': preferredTimings.toJson(),
      'studyMode': studyMode,
      'learningGoals': learningGoals.toJson(),
      'skillLevel': skillLevel,
      'updatedAt': updatedAt.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'StudyPreferences',
      if (id != null) 'id': id,
      'studentId': studentId,
      'subjects': subjects.toJson(),
      'technicalInterests': technicalInterests.toJson(),
      'preferredTimings': preferredTimings.toJson(),
      'studyMode': studyMode,
      'learningGoals': learningGoals.toJson(),
      'skillLevel': skillLevel,
      'updatedAt': updatedAt.toJson(),
    };
  }

  @override
  String toString() {
    return _isc.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _StudyPreferencesImpl extends StudyPreferences {
  _StudyPreferencesImpl({
    int? id,
    required int studentId,
    required List<String> subjects,
    required List<String> technicalInterests,
    required List<String> preferredTimings,
    required String studyMode,
    required List<String> learningGoals,
    required String skillLevel,
    required DateTime updatedAt,
  }) : super._(
         id: id,
         studentId: studentId,
         subjects: subjects,
         technicalInterests: technicalInterests,
         preferredTimings: preferredTimings,
         studyMode: studyMode,
         learningGoals: learningGoals,
         skillLevel: skillLevel,
         updatedAt: updatedAt,
       );

  /// Returns a shallow copy of this [StudyPreferences]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  @override
  StudyPreferences copyWith({
    Object? id = _Undefined,
    int? studentId,
    List<String>? subjects,
    List<String>? technicalInterests,
    List<String>? preferredTimings,
    String? studyMode,
    List<String>? learningGoals,
    String? skillLevel,
    DateTime? updatedAt,
  }) {
    return StudyPreferences(
      id: id is int? ? id : this.id,
      studentId: studentId ?? this.studentId,
      subjects: subjects ?? this.subjects.map((e0) => e0).toList(),
      technicalInterests:
          technicalInterests ??
          this.technicalInterests.map((e0) => e0).toList(),
      preferredTimings:
          preferredTimings ?? this.preferredTimings.map((e0) => e0).toList(),
      studyMode: studyMode ?? this.studyMode,
      learningGoals:
          learningGoals ?? this.learningGoals.map((e0) => e0).toList(),
      skillLevel: skillLevel ?? this.skillLevel,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}
