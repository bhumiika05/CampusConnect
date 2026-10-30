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
import 'package:campusconnect_server/src/generated/activity_notification.dart'
    as _i1of1t5x;
import 'package:campusconnect_server/src/generated/campus_event.dart'
    as _i2zef12b;
import 'package:campusconnect_server/src/generated/collaboration_request.dart'
    as _i6s8cpvv;
import 'package:campusconnect_server/src/generated/event_registration.dart'
    as _i42qkv6p;
import 'package:campusconnect_server/src/generated/project_listing.dart'
    as _iq9o6tcf;
import 'package:campusconnect_server/src/generated/student_profile.dart'
    as _ibrxl8gk;
import 'package:campusconnect_server/src/generated/study_recommendation.dart'
    as _i3kpqc5t;
import 'package:campusconnect_server/src/generated/study_request.dart'
    as _ikk2s12h;
import 'package:serverpod/protocol.dart' as _isp;
import 'package:serverpod/serverpod.dart' as _is;
import 'package:serverpod_auth_core_server/serverpod_auth_core_server.dart'
    as _iacs;
import 'package:serverpod_auth_idp_server/serverpod_auth_idp_server.dart'
    as _iais;
import 'activity_notification.dart' as _irw9wpf5;
import 'campus_event.dart' as _ieh998j0;
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

class Protocol extends _is.DatabaseSerializationManager {
  Protocol._();

  factory Protocol() => _instance;

  static final Protocol _instance = Protocol._().._registerHostProtocols();

  static List<_isp.TableDefinition> get targetTableDefinitions => [
    _isp.TableDefinition(
      name: 'activity_notification',
      dartName: 'ActivityNotification',
      schema: 'public',
      module: 'campusconnect',
      columns: [
        _isp.ColumnDefinition(
          name: 'id',
          columnType: _isp.ColumnType.bigint,
          isNullable: false,
          dartType: 'int?',
          columnDefault: 'serial',
        ),
        _isp.ColumnDefinition(
          name: 'recipientId',
          columnType: _isp.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _isp.ColumnDefinition(
          name: 'activityType',
          columnType: _isp.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _isp.ColumnDefinition(
          name: 'title',
          columnType: _isp.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _isp.ColumnDefinition(
          name: 'message',
          columnType: _isp.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _isp.ColumnDefinition(
          name: 'isRead',
          columnType: _isp.ColumnType.boolean,
          isNullable: false,
          dartType: 'bool',
        ),
        _isp.ColumnDefinition(
          name: 'createdAt',
          columnType: _isp.ColumnType.timestampWithoutTimeZone,
          isNullable: false,
          dartType: 'DateTime',
        ),
      ],
      foreignKeys: [],
      indexes: [],
      managed: true,
    ),
    _isp.TableDefinition(
      name: 'campus_event',
      dartName: 'CampusEvent',
      schema: 'public',
      module: 'campusconnect',
      columns: [
        _isp.ColumnDefinition(
          name: 'id',
          columnType: _isp.ColumnType.bigint,
          isNullable: false,
          dartType: 'int?',
          columnDefault: 'serial',
        ),
        _isp.ColumnDefinition(
          name: 'title',
          columnType: _isp.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _isp.ColumnDefinition(
          name: 'description',
          columnType: _isp.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _isp.ColumnDefinition(
          name: 'category',
          columnType: _isp.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _isp.ColumnDefinition(
          name: 'venue',
          columnType: _isp.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _isp.ColumnDefinition(
          name: 'startTime',
          columnType: _isp.ColumnType.timestampWithoutTimeZone,
          isNullable: false,
          dartType: 'DateTime',
        ),
        _isp.ColumnDefinition(
          name: 'endTime',
          columnType: _isp.ColumnType.timestampWithoutTimeZone,
          isNullable: false,
          dartType: 'DateTime',
        ),
        _isp.ColumnDefinition(
          name: 'organizer',
          columnType: _isp.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _isp.ColumnDefinition(
          name: 'organizerId',
          columnType: _isp.ColumnType.bigint,
          isNullable: true,
          dartType: 'int?',
        ),
        _isp.ColumnDefinition(
          name: 'isPublished',
          columnType: _isp.ColumnType.boolean,
          isNullable: false,
          dartType: 'bool',
        ),
        _isp.ColumnDefinition(
          name: 'capacity',
          columnType: _isp.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _isp.ColumnDefinition(
          name: 'registeredCount',
          columnType: _isp.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _isp.ColumnDefinition(
          name: 'bannerColor',
          columnType: _isp.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _isp.ColumnDefinition(
          name: 'createdAt',
          columnType: _isp.ColumnType.timestampWithoutTimeZone,
          isNullable: false,
          dartType: 'DateTime',
        ),
      ],
      foreignKeys: [],
      indexes: [],
      managed: true,
    ),
    _isp.TableDefinition(
      name: 'collaboration_request',
      dartName: 'CollaborationRequest',
      schema: 'public',
      module: 'campusconnect',
      columns: [
        _isp.ColumnDefinition(
          name: 'id',
          columnType: _isp.ColumnType.bigint,
          isNullable: false,
          dartType: 'int?',
          columnDefault: 'serial',
        ),
        _isp.ColumnDefinition(
          name: 'projectId',
          columnType: _isp.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _isp.ColumnDefinition(
          name: 'projectTitle',
          columnType: _isp.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _isp.ColumnDefinition(
          name: 'projectCreatorId',
          columnType: _isp.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _isp.ColumnDefinition(
          name: 'studentId',
          columnType: _isp.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _isp.ColumnDefinition(
          name: 'studentName',
          columnType: _isp.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _isp.ColumnDefinition(
          name: 'studentBranch',
          columnType: _isp.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _isp.ColumnDefinition(
          name: 'studentSkills',
          columnType: _isp.ColumnType.json,
          isNullable: false,
          dartType: 'List<String>',
        ),
        _isp.ColumnDefinition(
          name: 'message',
          columnType: _isp.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _isp.ColumnDefinition(
          name: 'status',
          columnType: _isp.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _isp.ColumnDefinition(
          name: 'createdAt',
          columnType: _isp.ColumnType.timestampWithoutTimeZone,
          isNullable: false,
          dartType: 'DateTime',
        ),
      ],
      foreignKeys: [],
      indexes: [],
      managed: true,
    ),
    _isp.TableDefinition(
      name: 'event_bookmark',
      dartName: 'EventBookmark',
      schema: 'public',
      module: 'campusconnect',
      columns: [
        _isp.ColumnDefinition(
          name: 'id',
          columnType: _isp.ColumnType.bigint,
          isNullable: false,
          dartType: 'int?',
          columnDefault: 'serial',
        ),
        _isp.ColumnDefinition(
          name: 'studentId',
          columnType: _isp.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _isp.ColumnDefinition(
          name: 'eventId',
          columnType: _isp.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _isp.ColumnDefinition(
          name: 'createdAt',
          columnType: _isp.ColumnType.timestampWithoutTimeZone,
          isNullable: false,
          dartType: 'DateTime',
        ),
      ],
      foreignKeys: [],
      indexes: [],
      managed: true,
    ),
    _isp.TableDefinition(
      name: 'event_registration',
      dartName: 'EventRegistration',
      schema: 'public',
      module: 'campusconnect',
      columns: [
        _isp.ColumnDefinition(
          name: 'id',
          columnType: _isp.ColumnType.bigint,
          isNullable: false,
          dartType: 'int?',
          columnDefault: 'serial',
        ),
        _isp.ColumnDefinition(
          name: 'studentId',
          columnType: _isp.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _isp.ColumnDefinition(
          name: 'studentName',
          columnType: _isp.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _isp.ColumnDefinition(
          name: 'studentEmail',
          columnType: _isp.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _isp.ColumnDefinition(
          name: 'eventId',
          columnType: _isp.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _isp.ColumnDefinition(
          name: 'eventTitle',
          columnType: _isp.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _isp.ColumnDefinition(
          name: 'status',
          columnType: _isp.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _isp.ColumnDefinition(
          name: 'createdAt',
          columnType: _isp.ColumnType.timestampWithoutTimeZone,
          isNullable: false,
          dartType: 'DateTime',
        ),
      ],
      foreignKeys: [],
      indexes: [],
      managed: true,
    ),
    _isp.TableDefinition(
      name: 'planner_item',
      dartName: 'PlannerItem',
      schema: 'public',
      module: 'campusconnect',
      columns: [
        _isp.ColumnDefinition(
          name: 'id',
          columnType: _isp.ColumnType.bigint,
          isNullable: false,
          dartType: 'int?',
          columnDefault: 'serial',
        ),
        _isp.ColumnDefinition(
          name: 'studentId',
          columnType: _isp.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _isp.ColumnDefinition(
          name: 'title',
          columnType: _isp.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _isp.ColumnDefinition(
          name: 'category',
          columnType: _isp.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _isp.ColumnDefinition(
          name: 'dayOfWeek',
          columnType: _isp.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _isp.ColumnDefinition(
          name: 'timeSlot',
          columnType: _isp.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _isp.ColumnDefinition(
          name: 'location',
          columnType: _isp.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _isp.ColumnDefinition(
          name: 'description',
          columnType: _isp.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _isp.ColumnDefinition(
          name: 'referenceId',
          columnType: _isp.ColumnType.bigint,
          isNullable: true,
          dartType: 'int?',
        ),
        _isp.ColumnDefinition(
          name: 'isCompleted',
          columnType: _isp.ColumnType.boolean,
          isNullable: false,
          dartType: 'bool',
        ),
        _isp.ColumnDefinition(
          name: 'createdAt',
          columnType: _isp.ColumnType.timestampWithoutTimeZone,
          isNullable: false,
          dartType: 'DateTime',
        ),
      ],
      foreignKeys: [],
      indexes: [],
      managed: true,
    ),
    _isp.TableDefinition(
      name: 'project_listing',
      dartName: 'ProjectListing',
      schema: 'public',
      module: 'campusconnect',
      columns: [
        _isp.ColumnDefinition(
          name: 'id',
          columnType: _isp.ColumnType.bigint,
          isNullable: false,
          dartType: 'int?',
          columnDefault: 'serial',
        ),
        _isp.ColumnDefinition(
          name: 'title',
          columnType: _isp.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _isp.ColumnDefinition(
          name: 'description',
          columnType: _isp.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _isp.ColumnDefinition(
          name: 'creatorId',
          columnType: _isp.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _isp.ColumnDefinition(
          name: 'creatorName',
          columnType: _isp.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _isp.ColumnDefinition(
          name: 'creatorBranch',
          columnType: _isp.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _isp.ColumnDefinition(
          name: 'techStack',
          columnType: _isp.ColumnType.json,
          isNullable: false,
          dartType: 'List<String>',
        ),
        _isp.ColumnDefinition(
          name: 'requiredSkills',
          columnType: _isp.ColumnType.json,
          isNullable: false,
          dartType: 'List<String>',
        ),
        _isp.ColumnDefinition(
          name: 'category',
          columnType: _isp.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _isp.ColumnDefinition(
          name: 'totalPositions',
          columnType: _isp.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _isp.ColumnDefinition(
          name: 'openPositions',
          columnType: _isp.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _isp.ColumnDefinition(
          name: 'status',
          columnType: _isp.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _isp.ColumnDefinition(
          name: 'createdAt',
          columnType: _isp.ColumnType.timestampWithoutTimeZone,
          isNullable: false,
          dartType: 'DateTime',
        ),
      ],
      foreignKeys: [],
      indexes: [],
      managed: true,
    ),
    _isp.TableDefinition(
      name: 'student_profile',
      dartName: 'StudentProfile',
      schema: 'public',
      module: 'campusconnect',
      columns: [
        _isp.ColumnDefinition(
          name: 'id',
          columnType: _isp.ColumnType.bigint,
          isNullable: false,
          dartType: 'int?',
          columnDefault: 'serial',
        ),
        _isp.ColumnDefinition(
          name: 'userId',
          columnType: _isp.ColumnType.bigint,
          isNullable: true,
          dartType: 'int?',
        ),
        _isp.ColumnDefinition(
          name: 'name',
          columnType: _isp.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _isp.ColumnDefinition(
          name: 'email',
          columnType: _isp.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _isp.ColumnDefinition(
          name: 'branch',
          columnType: _isp.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _isp.ColumnDefinition(
          name: 'academicYear',
          columnType: _isp.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _isp.ColumnDefinition(
          name: 'bio',
          columnType: _isp.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _isp.ColumnDefinition(
          name: 'avatarUrl',
          columnType: _isp.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _isp.ColumnDefinition(
          name: 'skills',
          columnType: _isp.ColumnType.json,
          isNullable: false,
          dartType: 'List<String>',
        ),
        _isp.ColumnDefinition(
          name: 'interests',
          columnType: _isp.ColumnType.json,
          isNullable: false,
          dartType: 'List<String>',
        ),
        _isp.ColumnDefinition(
          name: 'isOrganizer',
          columnType: _isp.ColumnType.boolean,
          isNullable: false,
          dartType: 'bool',
        ),
        _isp.ColumnDefinition(
          name: 'createdAt',
          columnType: _isp.ColumnType.timestampWithoutTimeZone,
          isNullable: false,
          dartType: 'DateTime',
        ),
        _isp.ColumnDefinition(
          name: 'updatedAt',
          columnType: _isp.ColumnType.timestampWithoutTimeZone,
          isNullable: false,
          dartType: 'DateTime',
        ),
      ],
      foreignKeys: [],
      indexes: [],
      managed: true,
    ),
    _isp.TableDefinition(
      name: 'study_preferences',
      dartName: 'StudyPreferences',
      schema: 'public',
      module: 'campusconnect',
      columns: [
        _isp.ColumnDefinition(
          name: 'id',
          columnType: _isp.ColumnType.bigint,
          isNullable: false,
          dartType: 'int?',
          columnDefault: 'serial',
        ),
        _isp.ColumnDefinition(
          name: 'studentId',
          columnType: _isp.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _isp.ColumnDefinition(
          name: 'subjects',
          columnType: _isp.ColumnType.json,
          isNullable: false,
          dartType: 'List<String>',
        ),
        _isp.ColumnDefinition(
          name: 'technicalInterests',
          columnType: _isp.ColumnType.json,
          isNullable: false,
          dartType: 'List<String>',
        ),
        _isp.ColumnDefinition(
          name: 'preferredTimings',
          columnType: _isp.ColumnType.json,
          isNullable: false,
          dartType: 'List<String>',
        ),
        _isp.ColumnDefinition(
          name: 'studyMode',
          columnType: _isp.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _isp.ColumnDefinition(
          name: 'learningGoals',
          columnType: _isp.ColumnType.json,
          isNullable: false,
          dartType: 'List<String>',
        ),
        _isp.ColumnDefinition(
          name: 'skillLevel',
          columnType: _isp.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _isp.ColumnDefinition(
          name: 'updatedAt',
          columnType: _isp.ColumnType.timestampWithoutTimeZone,
          isNullable: false,
          dartType: 'DateTime',
        ),
      ],
      foreignKeys: [],
      indexes: [],
      managed: true,
    ),
    _isp.TableDefinition(
      name: 'study_request',
      dartName: 'StudyRequest',
      schema: 'public',
      module: 'campusconnect',
      columns: [
        _isp.ColumnDefinition(
          name: 'id',
          columnType: _isp.ColumnType.bigint,
          isNullable: false,
          dartType: 'int?',
          columnDefault: 'serial',
        ),
        _isp.ColumnDefinition(
          name: 'senderId',
          columnType: _isp.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _isp.ColumnDefinition(
          name: 'senderName',
          columnType: _isp.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _isp.ColumnDefinition(
          name: 'senderBranch',
          columnType: _isp.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _isp.ColumnDefinition(
          name: 'senderAvatarUrl',
          columnType: _isp.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _isp.ColumnDefinition(
          name: 'recipientId',
          columnType: _isp.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _isp.ColumnDefinition(
          name: 'recipientName',
          columnType: _isp.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _isp.ColumnDefinition(
          name: 'message',
          columnType: _isp.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _isp.ColumnDefinition(
          name: 'status',
          columnType: _isp.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _isp.ColumnDefinition(
          name: 'createdAt',
          columnType: _isp.ColumnType.timestampWithoutTimeZone,
          isNullable: false,
          dartType: 'DateTime',
        ),
        _isp.ColumnDefinition(
          name: 'updatedAt',
          columnType: _isp.ColumnType.timestampWithoutTimeZone,
          isNullable: false,
          dartType: 'DateTime',
        ),
      ],
      foreignKeys: [],
      indexes: [],
      managed: true,
    ),
    ..._iais.Protocol.targetTableDefinitions,
    ..._iacs.Protocol.targetTableDefinitions,
    ..._isp.Protocol.targetTableDefinitions,
  ];

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
      } on _is.DeserializationClassNameNotFoundException catch (_) {
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
    if (t == _is.getType<_irw9wpf5.ActivityNotification?>()) {
      return (data != null
              ? _irw9wpf5.ActivityNotification.fromJson(data)
              : null)
          as T;
    }
    if (t == _is.getType<_ieh998j0.CampusEvent?>()) {
      return (data != null ? _ieh998j0.CampusEvent.fromJson(data) : null) as T;
    }
    if (t == _is.getType<_irwixkwz.CollaborationRequest?>()) {
      return (data != null
              ? _irwixkwz.CollaborationRequest.fromJson(data)
              : null)
          as T;
    }
    if (t == _is.getType<_isfb8n60.CopilotActionCard?>()) {
      return (data != null ? _isfb8n60.CopilotActionCard.fromJson(data) : null)
          as T;
    }
    if (t == _is.getType<_i5r7h6ax.CopilotResponse?>()) {
      return (data != null ? _i5r7h6ax.CopilotResponse.fromJson(data) : null)
          as T;
    }
    if (t == _is.getType<_irt0lj0o.DashboardData?>()) {
      return (data != null ? _irt0lj0o.DashboardData.fromJson(data) : null)
          as T;
    }
    if (t == _is.getType<_ihuolqct.EventBookmark?>()) {
      return (data != null ? _ihuolqct.EventBookmark.fromJson(data) : null)
          as T;
    }
    if (t == _is.getType<_i27uzliw.EventRegistration?>()) {
      return (data != null ? _i27uzliw.EventRegistration.fromJson(data) : null)
          as T;
    }
    if (t == _is.getType<_izw8z7ou.Greeting?>()) {
      return (data != null ? _izw8z7ou.Greeting.fromJson(data) : null) as T;
    }
    if (t == _is.getType<_in2kwev7.PlannerItem?>()) {
      return (data != null ? _in2kwev7.PlannerItem.fromJson(data) : null) as T;
    }
    if (t == _is.getType<_ir8do2mw.ProjectListing?>()) {
      return (data != null ? _ir8do2mw.ProjectListing.fromJson(data) : null)
          as T;
    }
    if (t == _is.getType<_iovtxv26.StudentProfile?>()) {
      return (data != null ? _iovtxv26.StudentProfile.fromJson(data) : null)
          as T;
    }
    if (t == _is.getType<_ieqi1f6a.StudyPreferences?>()) {
      return (data != null ? _ieqi1f6a.StudyPreferences.fromJson(data) : null)
          as T;
    }
    if (t == _is.getType<_i4zw24pz.StudyRecommendation?>()) {
      return (data != null
              ? _i4zw24pz.StudyRecommendation.fromJson(data)
              : null)
          as T;
    }
    if (t == _is.getType<_i2p0wucy.StudyRequest?>()) {
      return (data != null ? _i2p0wucy.StudyRequest.fromJson(data) : null) as T;
    }
    if (t == _is.getType<_iwrx71z1.WeeklyPlannerSummary?>()) {
      return (data != null
              ? _iwrx71z1.WeeklyPlannerSummary.fromJson(data)
              : null)
          as T;
    }
    if (t == List<String>) {
      return (data as List).map((e) => deserialize<String>(e)).toList() as T;
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
    if (t == List<_i1of1t5x.ActivityNotification>) {
      return (data as List)
              .map((e) => deserialize<_i1of1t5x.ActivityNotification>(e))
              .toList()
          as T;
    }
    if (t == List<_i6s8cpvv.CollaborationRequest>) {
      return (data as List)
              .map((e) => deserialize<_i6s8cpvv.CollaborationRequest>(e))
              .toList()
          as T;
    }
    if (t == List<_i2zef12b.CampusEvent>) {
      return (data as List)
              .map((e) => deserialize<_i2zef12b.CampusEvent>(e))
              .toList()
          as T;
    }
    if (t == List<int>) {
      return (data as List).map((e) => deserialize<int>(e)).toList() as T;
    }
    if (t == List<_i42qkv6p.EventRegistration>) {
      return (data as List)
              .map((e) => deserialize<_i42qkv6p.EventRegistration>(e))
              .toList()
          as T;
    }
    if (t == List<_ibrxl8gk.StudentProfile>) {
      return (data as List)
              .map((e) => deserialize<_ibrxl8gk.StudentProfile>(e))
              .toList()
          as T;
    }
    if (t == List<_iq9o6tcf.ProjectListing>) {
      return (data as List)
              .map((e) => deserialize<_iq9o6tcf.ProjectListing>(e))
              .toList()
          as T;
    }
    if (t == List<_i3kpqc5t.StudyRecommendation>) {
      return (data as List)
              .map((e) => deserialize<_i3kpqc5t.StudyRecommendation>(e))
              .toList()
          as T;
    }
    if (t == List<_ikk2s12h.StudyRequest>) {
      return (data as List)
              .map((e) => deserialize<_ikk2s12h.StudyRequest>(e))
              .toList()
          as T;
    }
    try {
      return _iais.Protocol().deserialize<T>(data, t);
    } on _is.DeserializationTypeNotFoundException catch (_) {}
    try {
      return _iacs.Protocol().deserialize<T>(data, t);
    } on _is.DeserializationTypeNotFoundException catch (_) {}
    try {
      return _isp.Protocol().deserialize<T>(data, t);
    } on _is.DeserializationTypeNotFoundException catch (_) {}
    return super.deserialize<T>(data, t);
  }

  static String? getClassNameForType(Type type) {
    return switch (type) {
      _irw9wpf5.ActivityNotification => 'ActivityNotification',
      _ieh998j0.CampusEvent => 'CampusEvent',
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
    className = _iais.Protocol().getClassNameForObject(data);
    if (className != null) {
      return className.contains('.')
          ? className
          : 'serverpod_auth_idp.$className';
    }
    className = _iacs.Protocol().getClassNameForObject(data);
    if (className != null) {
      return className.contains('.')
          ? className
          : 'serverpod_auth_core.$className';
    }
    className = _isp.Protocol().getClassNameForObject(data);
    if (className != null) {
      return className.contains('.') ? className : 'serverpod.$className';
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
      return _iais.Protocol().deserializeByClassName(data);
    }
    if (dataClassName.startsWith('serverpod_auth_core.')) {
      data['className'] = dataClassName.substring(20);
      return _iacs.Protocol().deserializeByClassName(data);
    }
    if (dataClassName.startsWith('serverpod.')) {
      data['className'] = dataClassName.substring(10);
      return _isp.Protocol().deserializeByClassName(data);
    }
    return super.deserializeByClassName(data);
  }

  void _registerHostProtocols() {
    _iais.Protocol().registerHostProtocol('campusconnect', this);
    _iacs.Protocol().registerHostProtocol('campusconnect', this);
  }

  @override
  _is.Table? getTableForType(Type t) {
    {
      var table = _iais.Protocol().getTableForType(t);
      if (table != null) {
        return table;
      }
    }
    {
      var table = _iacs.Protocol().getTableForType(t);
      if (table != null) {
        return table;
      }
    }
    {
      var table = _isp.Protocol().getTableForType(t);
      if (table != null) {
        return table;
      }
    }
    switch (t) {
      case _irw9wpf5.ActivityNotification:
        return _irw9wpf5.ActivityNotification.t;
      case _ieh998j0.CampusEvent:
        return _ieh998j0.CampusEvent.t;
      case _irwixkwz.CollaborationRequest:
        return _irwixkwz.CollaborationRequest.t;
      case _ihuolqct.EventBookmark:
        return _ihuolqct.EventBookmark.t;
      case _i27uzliw.EventRegistration:
        return _i27uzliw.EventRegistration.t;
      case _in2kwev7.PlannerItem:
        return _in2kwev7.PlannerItem.t;
      case _ir8do2mw.ProjectListing:
        return _ir8do2mw.ProjectListing.t;
      case _iovtxv26.StudentProfile:
        return _iovtxv26.StudentProfile.t;
      case _ieqi1f6a.StudyPreferences:
        return _ieqi1f6a.StudyPreferences.t;
      case _i2p0wucy.StudyRequest:
        return _i2p0wucy.StudyRequest.t;
    }
    return null;
  }

  @override
  List<_isp.TableDefinition> getTargetTableDefinitions() =>
      targetTableDefinitions;

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
      return _iais.Protocol().mapRecordToJson(record);
    } catch (_) {}
    try {
      return _iacs.Protocol().mapRecordToJson(record);
    } catch (_) {}
    throw Exception('Unsupported record type ${record.runtimeType}');
  }
}
