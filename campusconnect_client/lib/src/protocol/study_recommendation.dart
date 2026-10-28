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
import 'student_profile.dart' as _iovtxv26;
import 'study_preferences.dart' as _ieqi1f6a;

abstract class StudyRecommendation
    implements _isc.SerializableModel, _isc.ProtocolSerialization {
  StudyRecommendation._({
    required this.student,
    this.preferences,
    required this.compatibilityScore,
    required this.sharedSubjects,
    required this.sharedGoals,
    required this.timingMatch,
    required this.modeMatch,
    required this.scoreBreakdown,
  });

  factory StudyRecommendation({
    required _iovtxv26.StudentProfile student,
    _ieqi1f6a.StudyPreferences? preferences,
    required int compatibilityScore,
    required List<String> sharedSubjects,
    required List<String> sharedGoals,
    required bool timingMatch,
    required bool modeMatch,
    required String scoreBreakdown,
  }) = _StudyRecommendationImpl;

  factory StudyRecommendation.fromJson(Map<String, dynamic> jsonSerialization) {
    return StudyRecommendation(
      student: _im7konmk.Protocol().deserialize<_iovtxv26.StudentProfile>(
        jsonSerialization['student'],
      ),
      preferences: jsonSerialization['preferences'] == null
          ? null
          : _im7konmk.Protocol().deserialize<_ieqi1f6a.StudyPreferences>(
              jsonSerialization['preferences'],
            ),
      compatibilityScore: jsonSerialization['compatibilityScore'] as int,
      sharedSubjects: _im7konmk.Protocol().deserialize<List<String>>(
        jsonSerialization['sharedSubjects'],
      ),
      sharedGoals: _im7konmk.Protocol().deserialize<List<String>>(
        jsonSerialization['sharedGoals'],
      ),
      timingMatch: _isc.BoolJsonExtension.fromJson(
        jsonSerialization['timingMatch'],
      ),
      modeMatch: _isc.BoolJsonExtension.fromJson(
        jsonSerialization['modeMatch'],
      ),
      scoreBreakdown: jsonSerialization['scoreBreakdown'] as String,
    );
  }

  _iovtxv26.StudentProfile student;

  _ieqi1f6a.StudyPreferences? preferences;

  int compatibilityScore;

  List<String> sharedSubjects;

  List<String> sharedGoals;

  bool timingMatch;

  bool modeMatch;

  String scoreBreakdown;

  /// Returns a shallow copy of this [StudyRecommendation]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  StudyRecommendation copyWith({
    _iovtxv26.StudentProfile? student,
    _ieqi1f6a.StudyPreferences? preferences,
    int? compatibilityScore,
    List<String>? sharedSubjects,
    List<String>? sharedGoals,
    bool? timingMatch,
    bool? modeMatch,
    String? scoreBreakdown,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'StudyRecommendation',
      'student': student.toJson(),
      if (preferences != null) 'preferences': preferences?.toJson(),
      'compatibilityScore': compatibilityScore,
      'sharedSubjects': sharedSubjects.toJson(),
      'sharedGoals': sharedGoals.toJson(),
      'timingMatch': timingMatch,
      'modeMatch': modeMatch,
      'scoreBreakdown': scoreBreakdown,
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'StudyRecommendation',
      'student': student.toJsonForProtocol(),
      if (preferences != null) 'preferences': preferences?.toJsonForProtocol(),
      'compatibilityScore': compatibilityScore,
      'sharedSubjects': sharedSubjects.toJson(),
      'sharedGoals': sharedGoals.toJson(),
      'timingMatch': timingMatch,
      'modeMatch': modeMatch,
      'scoreBreakdown': scoreBreakdown,
    };
  }

  @override
  String toString() {
    return _isc.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _StudyRecommendationImpl extends StudyRecommendation {
  _StudyRecommendationImpl({
    required _iovtxv26.StudentProfile student,
    _ieqi1f6a.StudyPreferences? preferences,
    required int compatibilityScore,
    required List<String> sharedSubjects,
    required List<String> sharedGoals,
    required bool timingMatch,
    required bool modeMatch,
    required String scoreBreakdown,
  }) : super._(
         student: student,
         preferences: preferences,
         compatibilityScore: compatibilityScore,
         sharedSubjects: sharedSubjects,
         sharedGoals: sharedGoals,
         timingMatch: timingMatch,
         modeMatch: modeMatch,
         scoreBreakdown: scoreBreakdown,
       );

  /// Returns a shallow copy of this [StudyRecommendation]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  @override
  StudyRecommendation copyWith({
    _iovtxv26.StudentProfile? student,
    Object? preferences = _Undefined,
    int? compatibilityScore,
    List<String>? sharedSubjects,
    List<String>? sharedGoals,
    bool? timingMatch,
    bool? modeMatch,
    String? scoreBreakdown,
  }) {
    return StudyRecommendation(
      student: student ?? this.student.copyWith(),
      preferences: preferences is _ieqi1f6a.StudyPreferences?
          ? preferences
          : this.preferences?.copyWith(),
      compatibilityScore: compatibilityScore ?? this.compatibilityScore,
      sharedSubjects:
          sharedSubjects ?? this.sharedSubjects.map((e0) => e0).toList(),
      sharedGoals: sharedGoals ?? this.sharedGoals.map((e0) => e0).toList(),
      timingMatch: timingMatch ?? this.timingMatch,
      modeMatch: modeMatch ?? this.modeMatch,
      scoreBreakdown: scoreBreakdown ?? this.scoreBreakdown,
    );
  }
}
