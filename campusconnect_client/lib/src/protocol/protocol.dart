/* AUTOMATICALLY GENERATED CODE DO NOT MODIFY */
/*   To generate run: "serverpod generate"    */

// ignore_for_file: implementation_imports
// ignore_for_file: library_private_types_in_public_api
// ignore_for_file: non_constant_identifier_names
// ignore_for_file: public_member_api_docs
// ignore_for_file: type_literal_in_constant_pattern
// ignore_for_file: use_super_parameters
// ignore_for_file: invalid_use_of_internal_member
// ignore_for_file: dead_code, unnecessary_type_check

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:campusconnect_client/src/protocol/activity_notification.dart'
    as _iq707l6z;
import 'package:campusconnect_client/src/protocol/campus_event.dart'
    as _iq3u3g5y;
import 'package:campusconnect_client/src/protocol/campus_location.dart'
    as _i7e4p0ip;
import 'package:campusconnect_client/src/protocol/collaboration_request.dart'
    as _iqiqy8rh;
import 'package:campusconnect_client/src/protocol/event_registration.dart'
    as _i5ab8n3y;
import 'package:campusconnect_client/src/protocol/project_listing.dart'
    as _iy7kf7ii;
import 'package:campusconnect_client/src/protocol/student_profile.dart'
    as _i7gx854o;
import 'package:campusconnect_client/src/protocol/study_recommendation.dart'
    as _i0k9swt0;
import 'package:campusconnect_client/src/protocol/study_request.dart'
    as _ian5kjnn;
import 'package:serverpod_auth_core_client/serverpod_auth_core_client.dart'
    as _iacc;
import 'package:serverpod_auth_idp_client/serverpod_auth_idp_client.dart'
    as _iaic;
import 'package:serverpod_client/serverpod_client.dart' as _isc;
import 'activity_notification.dart' as _irw9wpf5;
import 'campus_event.dart' as _ieh998j0;
import 'campus_location.dart' as _ib8flzxr;
import 'collaboration_request.dart' as _irwixkwz;
import 'copilot_action_card.dart' as _isfb8n60;
import 'copilot_response.dart' as _i5r7h6ax;
import 'dashboard_data.dart' as _irt0lj0o;
import 'event_bookmark.dart' as _ihuolqct;
import 'event_registration.dart' as _i27uzliw;
import 'greetings/greeting.dart' as _izw8z7ou;
import 'planner_item.dart' as _in2kwev7;
import 'project_listing.dart' as _ir8do2mw;
import 'student_profile.dart' as _iovtxv26;
import 'study_preferences.dart' as _ieqi1f6a;
import 'study_recommendation.dart' as _i4zw24pz;
import 'study_request.dart' as _i2p0wucy;
import 'weekly_planner_summary.dart' as _iwrx71z1;
export 'activity_notification.dart';
export 'campus_event.dart';
export 'campus_location.dart';
export 'collaboration_request.dart';
export 'copilot_action_card.dart';
export 'copilot_response.dart';
export 'dashboard_data.dart';
export 'event_bookmark.dart';
export 'event_registration.dart';
export 'greetings/greeting.dart';
export 'planner_item.dart';
export 'project_listing.dart';
export 'student_profile.dart';
export 'study_preferences.dart';
export 'study_recommendation.dart';
export 'study_request.dart';
export 'weekly_planner_summary.dart';
export 'client.dart';

class Protocol extends _isc.SerializationManager {
  Protocol._();

  factory Protocol() => _instance;

  static final Protocol _instance = Protocol._().._registerHostProtocols();

  static String? getClassNameFromObjectJson(dynamic data) {
    if (data is! Map) return null;
    final className = data['__className__'] as String?;
    return className;
  }

  @override
  T deserialize<T>(
    dynamic data, [
    Type? t,
  ]) {
    t ??= T;

    final dataClassName = getClassNameFromObjectJson(data);
    if (dataClassName != null && dataClassName != getClassNameForType(t)) {
      try {
        return deserializeByClassName({
          'className': dataClassName,
          'data': data,
        });
      } on _isc.DeserializationClassNameNotFoundException catch (_) {
        // If the className is not recognized (e.g., older client receiving
        // data with a new subtype), fall back to deserializing without the
        // className, using the expected type T.
      }
    }

    if (t == _irw9wpf5.ActivityNotification) {
      return _irw9wpf5.ActivityNotification.fromJson(data) as T;
    }
    if (t == _ieh998j0.CampusEvent) {
      return _ieh998j0.CampusEvent.fromJson(data) as T;
    }
    if (t == _ib8flzxr.CampusLocation) {
      return _ib8flzxr.CampusLocation.fromJson(data) as T;
    }
    if (t == _irwixkwz.CollaborationRequest) {
      return _irwixkwz.CollaborationRequest.fromJson(data) as T;
    }
    if (t == _isfb8n60.CopilotActionCard) {
      return _isfb8n60.CopilotActionCard.fromJson(data) as T;
    }
    if (t == _i5r7h6ax.CopilotResponse) {
      return _i5r7h6ax.CopilotResponse.fromJson(data) as T;
    }
    if (t == _irt0lj0o.DashboardData) {
      return _irt0lj0o.DashboardData.fromJson(data) as T;
    }
    if (t == _ihuolqct.EventBookmark) {
      return _ihuolqct.EventBookmark.fromJson(data) as T;
    }
    if (t == _i27uzliw.EventRegistration) {
      return _i27uzliw.EventRegistration.fromJson(data) as T;
    }
    if (t == _izw8z7ou.Greeting) {
      return _izw8z7ou.Greeting.fromJson(data) as T;
    }
    if (t == _in2kwev7.PlannerItem) {
      return _in2kwev7.PlannerItem.fromJson(data) as T;
    }
    if (t == _ir8do2mw.ProjectListing) {
      return _ir8do2mw.ProjectListing.fromJson(data) as T;
    }
    if (t == _iovtxv26.StudentProfile) {
      return _iovtxv26.StudentProfile.fromJson(data) as T;
    }
    if (t == _ieqi1f6a.StudyPreferences) {
      return _ieqi1f6a.StudyPreferences.fromJson(data) as T;
    }
    if (t == _i4zw24pz.StudyRecommendation) {
      return _i4zw24pz.StudyRecommendation.fromJson(data) as T;
    }
    if (t == _i2p0wucy.StudyRequest) {
      return _i2p0wucy.StudyRequest.fromJson(data) as T;
    }
    if (t == _iwrx71z1.WeeklyPlannerSummary) {
      return _iwrx71z1.WeeklyPlannerSummary.fromJson(data) as T;
    }
    if (t == _isc.getType<_irw9wpf5.ActivityNotification?>()) {
      return (data != null
              ? _irw9wpf5.ActivityNotification.fromJson(data)
              : null)
          as T;
    }
    if (t == _isc.getType<_ieh998j0.CampusEvent?>()) {
      return (data != null ? _ieh998j0.CampusEvent.fromJson(data) : null) as T;
    }
    if (t == _isc.getType<_ib8flzxr.CampusLocation?>()) {
      return (data != null ? _ib8flzxr.CampusLocation.fromJson(data) : null)
          as T;
    }
    if (t == _isc.getType<_irwixkwz.CollaborationRequest?>()) {
      return (data != null
              ? _irwixkwz.CollaborationRequest.fromJson(data)
              : null)
          as T;
    }
    if (t == _isc.getType<_isfb8n60.CopilotActionCard?>()) {
      return (data != null ? _isfb8n60.CopilotActionCard.fromJson(data) : null)
          as T;
    }
    if (t == _isc.getType<_i5r7h6ax.CopilotResponse?>()) {
      return (data != null ? _i5r7h6ax.CopilotResponse.fromJson(data) : null)
          as T;
    }
    if (t == _isc.getType<_irt0lj0o.DashboardData?>()) {
      return (data != null ? _irt0lj0o.DashboardData.fromJson(data) : null)
          as T;
    }
    if (t == _isc.getType<_ihuolqct.EventBookmark?>()) {
      return (data != null ? _ihuolqct.EventBookmark.fromJson(data) : null)
          as T;
    }
    if (t == _isc.getType<_i27uzliw.EventRegistration?>()) {
      return (data != null ? _i27uzliw.EventRegistration.fromJson(data) : null)
          as T;
    }
    if (t == _isc.getType<_izw8z7ou.Greeting?>()) {
      return (data != null ? _izw8z7ou.Greeting.fromJson(data) : null) as T;
    }
    if (t == _isc.getType<_in2kwev7.PlannerItem?>()) {
      return (data != null ? _in2kwev7.PlannerItem.fromJson(data) : null) as T;
    }
    if (t == _isc.getType<_ir8do2mw.ProjectListing?>()) {
      return (data != null ? _ir8do2mw.ProjectListing.fromJson(data) : null)
          as T;
    }
    if (t == _isc.getType<_iovtxv26.StudentProfile?>()) {
      return (data != null ? _iovtxv26.StudentProfile.fromJson(data) : null)
          as T;
    }
    if (t == _isc.getType<_ieqi1f6a.StudyPreferences?>()) {
      return (data != null ? _ieqi1f6a.StudyPreferences.fromJson(data) : null)
          as T;
    }
    if (t == _isc.getType<_i4zw24pz.StudyRecommendation?>()) {
      return (data != null
              ? _i4zw24pz.StudyRecommendation.fromJson(data)
              : null)
          as T;
    }
    if (t == _isc.getType<_i2p0wucy.StudyRequest?>()) {
      return (data != null ? _i2p0wucy.StudyRequest.fromJson(data) : null) as T;
    }
    if (t == _isc.getType<_iwrx71z1.WeeklyPlannerSummary?>()) {
      return (data != null
              ? _iwrx71z1.WeeklyPlannerSummary.fromJson(data)
              : null)
          as T;
    }
    if (t == List<String>) {
      return (data as List).map((e) => deserialize<String>(e)).toList() as T;
    }
    if (t == _isc.getType<List<String>?>()) {
      return (data != null
              ? (data as List).map((e) => deserialize<String>(e)).toList()
              : null)
          as T;
    }
    if (t == List<_isfb8n60.CopilotActionCard>) {
      return (data as List)
              .map((e) => deserialize<_isfb8n60.CopilotActionCard>(e))
              .toList()
          as T;
    }
    if (t == List<_i4zw24pz.StudyRecommendation>) {
      return (data as List)
              .map((e) => deserialize<_i4zw24pz.StudyRecommendation>(e))
              .toList()
          as T;
    }
    if (t == List<_ieh998j0.CampusEvent>) {
      return (data as List)
              .map((e) => deserialize<_ieh998j0.CampusEvent>(e))
              .toList()
          as T;
    }
    if (t == List<_ir8do2mw.ProjectListing>) {
      return (data as List)
              .map((e) => deserialize<_ir8do2mw.ProjectListing>(e))
              .toList()
          as T;
    }
    if (t == List<_irw9wpf5.ActivityNotification>) {
      return (data as List)
              .map((e) => deserialize<_irw9wpf5.ActivityNotification>(e))
              .toList()
          as T;
    }
    if (t == List<_in2kwev7.PlannerItem>) {
      return (data as List)
              .map((e) => deserialize<_in2kwev7.PlannerItem>(e))
              .toList()
          as T;
    }
    if (t == List<_iq707l6z.ActivityNotification>) {
      return (data as List)
              .map((e) => deserialize<_iq707l6z.ActivityNotification>(e))
              .toList()
          as T;
    }
    if (t == List<_iqiqy8rh.CollaborationRequest>) {
      return (data as List)
              .map((e) => deserialize<_iqiqy8rh.CollaborationRequest>(e))
              .toList()
          as T;
    }
    if (t == List<_iq3u3g5y.CampusEvent>) {
      return (data as List)
              .map((e) => deserialize<_iq3u3g5y.CampusEvent>(e))
              .toList()
          as T;
    }
    if (t == List<int>) {
      return (data as List).map((e) => deserialize<int>(e)).toList() as T;
    }
    if (t == List<_i5ab8n3y.EventRegistration>) {
      return (data as List)
              .map((e) => deserialize<_i5ab8n3y.EventRegistration>(e))
              .toList()
          as T;
    }
    if (t == List<_i7e4p0ip.CampusLocation>) {
      return (data as List)
              .map((e) => deserialize<_i7e4p0ip.CampusLocation>(e))
              .toList()
          as T;
    }
    if (t == List<_i7gx854o.StudentProfile>) {
      return (data as List)
              .map((e) => deserialize<_i7gx854o.StudentProfile>(e))
              .toList()
          as T;
    }
    if (t == List<_iy7kf7ii.ProjectListing>) {
      return (data as List)
              .map((e) => deserialize<_iy7kf7ii.ProjectListing>(e))
              .toList()
          as T;
    }
    if (t == List<_i0k9swt0.StudyRecommendation>) {
      return (data as List)
              .map((e) => deserialize<_i0k9swt0.StudyRecommendation>(e))
              .toList()
          as T;
    }
    if (t == List<_ian5kjnn.StudyRequest>) {
      return (data as List)
              .map((e) => deserialize<_ian5kjnn.StudyRequest>(e))
              .toList()
          as T;
    }
    try {
      return _iaic.Protocol().deserialize<T>(data, t);
    } on _isc.DeserializationTypeNotFoundException catch (_) {}
    try {
      return _iacc.Protocol().deserialize<T>(data, t);
    } on _isc.DeserializationTypeNotFoundException catch (_) {}
    return super.deserialize<T>(data, t);
  }

  static String? getClassNameForType(Type type) {
    return switch (type) {
      _irw9wpf5.ActivityNotification => 'ActivityNotification',
      _ieh998j0.CampusEvent => 'CampusEvent',
      _ib8flzxr.CampusLocation => 'CampusLocation',
      _irwixkwz.CollaborationRequest => 'CollaborationRequest',
      _isfb8n60.CopilotActionCard => 'CopilotActionCard',
      _i5r7h6ax.CopilotResponse => 'CopilotResponse',
      _irt0lj0o.DashboardData => 'DashboardData',
      _ihuolqct.EventBookmark => 'EventBookmark',
      _i27uzliw.EventRegistration => 'EventRegistration',
      _izw8z7ou.Greeting => 'Greeting',
      _in2kwev7.PlannerItem => 'PlannerItem',
      _ir8do2mw.ProjectListing => 'ProjectListing',
      _iovtxv26.StudentProfile => 'StudentProfile',
      _ieqi1f6a.StudyPreferences => 'StudyPreferences',
      _i4zw24pz.StudyRecommendation => 'StudyRecommendation',
      _i2p0wucy.StudyRequest => 'StudyRequest',
      _iwrx71z1.WeeklyPlannerSummary => 'WeeklyPlannerSummary',
      _ => null,
    };
  }

  @override
  String? getClassNameForObject(Object? data) {
    String? className = super.getClassNameForObject(data);
    if (className != null) return className;

    if (data is Map<String, dynamic> && data['__className__'] is String) {
      return (data['__className__'] as String).replaceFirst(
        'campusconnect.',
        '',
      );
    }

    switch (data) {
      case _irw9wpf5.ActivityNotification():
        return 'ActivityNotification';
      case _ieh998j0.CampusEvent():
        return 'CampusEvent';
      case _ib8flzxr.CampusLocation():
        return 'CampusLocation';
      case _irwixkwz.CollaborationRequest():
        return 'CollaborationRequest';
      case _isfb8n60.CopilotActionCard():
        return 'CopilotActionCard';
      case _i5r7h6ax.CopilotResponse():
        return 'CopilotResponse';
      case _irt0lj0o.DashboardData():
        return 'DashboardData';
      case _ihuolqct.EventBookmark():
        return 'EventBookmark';
      case _i27uzliw.EventRegistration():
        return 'EventRegistration';
      case _izw8z7ou.Greeting():
        return 'Greeting';
      case _in2kwev7.PlannerItem():
        return 'PlannerItem';
      case _ir8do2mw.ProjectListing():
        return 'ProjectListing';
      case _iovtxv26.StudentProfile():
        return 'StudentProfile';
      case _ieqi1f6a.StudyPreferences():
        return 'StudyPreferences';
      case _i4zw24pz.StudyRecommendation():
        return 'StudyRecommendation';
      case _i2p0wucy.StudyRequest():
        return 'StudyRequest';
      case _iwrx71z1.WeeklyPlannerSummary():
        return 'WeeklyPlannerSummary';
    }
    className = _iaic.Protocol().getClassNameForObject(data);
    if (className != null) {
      return className.contains('.')
          ? className
          : 'serverpod_auth_idp.$className';
    }
    className = _iacc.Protocol().getClassNameForObject(data);
    if (className != null) {
      return className.contains('.')
          ? className
          : 'serverpod_auth_core.$className';
    }
    return null;
  }

  @override
  dynamic deserializeByClassName(Map<String, dynamic> data) {
    var dataClassName = data['className'];
    if (dataClassName is! String) {
      return super.deserializeByClassName(data);
    }
    if (dataClassName == 'ActivityNotification') {
      return deserialize<_irw9wpf5.ActivityNotification>(data['data']);
    }
    if (dataClassName == 'CampusEvent') {
      return deserialize<_ieh998j0.CampusEvent>(data['data']);
    }
    if (dataClassName == 'CampusLocation') {
      return deserialize<_ib8flzxr.CampusLocation>(data['data']);
    }
    if (dataClassName == 'CollaborationRequest') {
      return deserialize<_irwixkwz.CollaborationRequest>(data['data']);
    }
    if (dataClassName == 'CopilotActionCard') {
      return deserialize<_isfb8n60.CopilotActionCard>(data['data']);
    }
    if (dataClassName == 'CopilotResponse') {
      return deserialize<_i5r7h6ax.CopilotResponse>(data['data']);
    }
    if (dataClassName == 'DashboardData') {
      return deserialize<_irt0lj0o.DashboardData>(data['data']);
    }
    if (dataClassName == 'EventBookmark') {
      return deserialize<_ihuolqct.EventBookmark>(data['data']);
    }
    if (dataClassName == 'EventRegistration') {
      return deserialize<_i27uzliw.EventRegistration>(data['data']);
    }
    if (dataClassName == 'Greeting') {
      return deserialize<_izw8z7ou.Greeting>(data['data']);
    }
    if (dataClassName == 'PlannerItem') {
      return deserialize<_in2kwev7.PlannerItem>(data['data']);
    }
    if (dataClassName == 'ProjectListing') {
      return deserialize<_ir8do2mw.ProjectListing>(data['data']);
    }
    if (dataClassName == 'StudentProfile') {
      return deserialize<_iovtxv26.StudentProfile>(data['data']);
    }
    if (dataClassName == 'StudyPreferences') {
      return deserialize<_ieqi1f6a.StudyPreferences>(data['data']);
    }
    if (dataClassName == 'StudyRecommendation') {
      return deserialize<_i4zw24pz.StudyRecommendation>(data['data']);
    }
    if (dataClassName == 'StudyRequest') {
      return deserialize<_i2p0wucy.StudyRequest>(data['data']);
    }
    if (dataClassName == 'WeeklyPlannerSummary') {
      return deserialize<_iwrx71z1.WeeklyPlannerSummary>(data['data']);
    }
    if (dataClassName.startsWith('serverpod_auth_idp.')) {
      data['className'] = dataClassName.substring(19);
      return _iaic.Protocol().deserializeByClassName(data);
    }
    if (dataClassName.startsWith('serverpod_auth_core.')) {
      data['className'] = dataClassName.substring(20);
      return _iacc.Protocol().deserializeByClassName(data);
    }
    return super.deserializeByClassName(data);
  }

  void _registerHostProtocols() {
    _iaic.Protocol().registerHostProtocol('campusconnect', this);
    _iacc.Protocol().registerHostProtocol('campusconnect', this);
  }

  @override
  String getModuleName() => 'campusconnect';

  /// Maps any `Record`s known to this [Protocol] to their JSON representation
  ///
  /// Throws in case the record type is not known.
  ///
  /// This method will return `null` (only) for `null` inputs.
  Map<String, dynamic>? mapRecordToJson(Record? record) {
    if (record == null) {
      return null;
    }
    try {
      return _iaic.Protocol().mapRecordToJson(record);
    } catch (_) {}
    try {
      return _iacc.Protocol().mapRecordToJson(record);
    } catch (_) {}
    throw Exception('Unsupported record type ${record.runtimeType}');
  }
}
