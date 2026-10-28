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
import 'package:campusconnect_server/src/generated/protocol.dart' as _iusjeinx;
import 'package:serverpod/serverpod.dart' as _is;
import 'activity_notification.dart' as _irw9wpf5;
import 'campus_event.dart' as _ieh998j0;
import 'project_listing.dart' as _ir8do2mw;
import 'student_profile.dart' as _iovtxv26;
import 'study_recommendation.dart' as _i4zw24pz;

abstract class DashboardData
    implements _is.SerializableModel, _is.ProtocolSerialization {
  DashboardData._({
    this.profile,
    required this.recommendedBuddies,
    required this.upcomingEvents,
    required this.openProjects,
    required this.recentActivities,
    required this.profileCompletionPercent,
    required this.unreadNotificationCount,
  });

  factory DashboardData({
    _iovtxv26.StudentProfile? profile,
    required List<_i4zw24pz.StudyRecommendation> recommendedBuddies,
    required List<_ieh998j0.CampusEvent> upcomingEvents,
    required List<_ir8do2mw.ProjectListing> openProjects,
    required List<_irw9wpf5.ActivityNotification> recentActivities,
    required int profileCompletionPercent,
    required int unreadNotificationCount,
  }) = _DashboardDataImpl;

  factory DashboardData.fromJson(Map<String, dynamic> jsonSerialization) {
    return DashboardData(
      profile: jsonSerialization['profile'] == null
          ? null
          : _iusjeinx.Protocol().deserialize<_iovtxv26.StudentProfile>(
              jsonSerialization['profile'],
            ),
      recommendedBuddies: _iusjeinx.Protocol()
          .deserialize<List<_i4zw24pz.StudyRecommendation>>(
            jsonSerialization['recommendedBuddies'],
          ),
      upcomingEvents: _iusjeinx.Protocol()
          .deserialize<List<_ieh998j0.CampusEvent>>(
            jsonSerialization['upcomingEvents'],
          ),
      openProjects: _iusjeinx.Protocol()
          .deserialize<List<_ir8do2mw.ProjectListing>>(
            jsonSerialization['openProjects'],
          ),
      recentActivities: _iusjeinx.Protocol()
          .deserialize<List<_irw9wpf5.ActivityNotification>>(
            jsonSerialization['recentActivities'],
          ),
      profileCompletionPercent:
          jsonSerialization['profileCompletionPercent'] as int,
      unreadNotificationCount:
          jsonSerialization['unreadNotificationCount'] as int,
    );
  }

  _iovtxv26.StudentProfile? profile;

  List<_i4zw24pz.StudyRecommendation> recommendedBuddies;

  List<_ieh998j0.CampusEvent> upcomingEvents;

  List<_ir8do2mw.ProjectListing> openProjects;

  List<_irw9wpf5.ActivityNotification> recentActivities;

  int profileCompletionPercent;

  int unreadNotificationCount;

  /// Returns a shallow copy of this [DashboardData]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  DashboardData copyWith({
    _iovtxv26.StudentProfile? profile,
    List<_i4zw24pz.StudyRecommendation>? recommendedBuddies,
    List<_ieh998j0.CampusEvent>? upcomingEvents,
    List<_ir8do2mw.ProjectListing>? openProjects,
    List<_irw9wpf5.ActivityNotification>? recentActivities,
    int? profileCompletionPercent,
    int? unreadNotificationCount,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'DashboardData',
      if (profile != null) 'profile': profile?.toJson(),
      'recommendedBuddies': recommendedBuddies.toJson(
        valueToJson: (v) => v.toJson(),
      ),
      'upcomingEvents': upcomingEvents.toJson(valueToJson: (v) => v.toJson()),
      'openProjects': openProjects.toJson(valueToJson: (v) => v.toJson()),
      'recentActivities': recentActivities.toJson(
        valueToJson: (v) => v.toJson(),
      ),
      'profileCompletionPercent': profileCompletionPercent,
      'unreadNotificationCount': unreadNotificationCount,
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'DashboardData',
      if (profile != null) 'profile': profile?.toJsonForProtocol(),
      'recommendedBuddies': recommendedBuddies.toJson(
        valueToJson: (v) => v.toJsonForProtocol(),
      ),
      'upcomingEvents': upcomingEvents.toJson(
        valueToJson: (v) => v.toJsonForProtocol(),
      ),
      'openProjects': openProjects.toJson(
        valueToJson: (v) => v.toJsonForProtocol(),
      ),
      'recentActivities': recentActivities.toJson(
        valueToJson: (v) => v.toJsonForProtocol(),
      ),
      'profileCompletionPercent': profileCompletionPercent,
      'unreadNotificationCount': unreadNotificationCount,
    };
  }

  @override
  String toString() {
    return _is.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _DashboardDataImpl extends DashboardData {
  _DashboardDataImpl({
    _iovtxv26.StudentProfile? profile,
    required List<_i4zw24pz.StudyRecommendation> recommendedBuddies,
    required List<_ieh998j0.CampusEvent> upcomingEvents,
    required List<_ir8do2mw.ProjectListing> openProjects,
    required List<_irw9wpf5.ActivityNotification> recentActivities,
    required int profileCompletionPercent,
    required int unreadNotificationCount,
  }) : super._(
         profile: profile,
         recommendedBuddies: recommendedBuddies,
         upcomingEvents: upcomingEvents,
         openProjects: openProjects,
         recentActivities: recentActivities,
         profileCompletionPercent: profileCompletionPercent,
         unreadNotificationCount: unreadNotificationCount,
       );

  /// Returns a shallow copy of this [DashboardData]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  @override
  DashboardData copyWith({
    Object? profile = _Undefined,
    List<_i4zw24pz.StudyRecommendation>? recommendedBuddies,
    List<_ieh998j0.CampusEvent>? upcomingEvents,
    List<_ir8do2mw.ProjectListing>? openProjects,
    List<_irw9wpf5.ActivityNotification>? recentActivities,
    int? profileCompletionPercent,
    int? unreadNotificationCount,
  }) {
    return DashboardData(
      profile: profile is _iovtxv26.StudentProfile?
          ? profile
          : this.profile?.copyWith(),
      recommendedBuddies:
          recommendedBuddies ??
          this.recommendedBuddies.map((e0) => e0.copyWith()).toList(),
      upcomingEvents:
          upcomingEvents ??
          this.upcomingEvents.map((e0) => e0.copyWith()).toList(),
      openProjects:
          openProjects ?? this.openProjects.map((e0) => e0.copyWith()).toList(),
      recentActivities:
          recentActivities ??
          this.recentActivities.map((e0) => e0.copyWith()).toList(),
      profileCompletionPercent:
          profileCompletionPercent ?? this.profileCompletionPercent,
      unreadNotificationCount:
          unreadNotificationCount ?? this.unreadNotificationCount,
    );
  }
}
