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
import 'package:campusconnect_server/src/generated/campus_event.dart'
    as _i2zef12b;
import 'package:campusconnect_server/src/generated/planner_item.dart'
    as _igkghzxl;
import 'package:campusconnect_server/src/generated/project_listing.dart'
    as _iq9o6tcf;
import 'package:campusconnect_server/src/generated/student_profile.dart'
    as _ibrxl8gk;
import 'package:campusconnect_server/src/generated/study_preferences.dart'
    as _iv9oh772;
import 'package:serverpod/serverpod.dart' as _is;
import 'package:serverpod_auth_core_server/serverpod_auth_core_server.dart'
    as _iacs;
import 'package:serverpod_auth_idp_server/serverpod_auth_idp_server.dart'
    as _iais;
import '../auth/email_idp_endpoint.dart' as _iuc1hd5t;
import '../auth/jwt_refresh_endpoint.dart' as _inwq3ztq;
import '../endpoints/activity_endpoint.dart' as _ijhtbkuk;
import '../endpoints/collaboration_endpoint.dart' as _it38s895;
import '../endpoints/copilot_endpoint.dart' as _ihft4d9p;
import '../endpoints/dashboard_endpoint.dart' as _ibmx856o;
import '../endpoints/event_endpoint.dart' as _icw8lb6p;
import '../endpoints/event_registration_endpoint.dart' as _ikdqwe68;
import '../endpoints/planner_endpoint.dart' as _i3d44723;
import '../endpoints/profile_endpoint.dart' as _i2cx2pww;
import '../endpoints/project_endpoint.dart' as _iemg8ri2;
import '../endpoints/seed_endpoint.dart' as _i8h1zywb;
import '../endpoints/study_buddy_endpoint.dart' as _iz7nttta;
import '../endpoints/study_request_endpoint.dart' as _i2439pix;
import '../greetings/greeting_endpoint.dart' as _il624ik7;

class Endpoints extends _is.EndpointDispatch {
  @override
  void initializeEndpoints(_is.Server server) {
    var endpoints = <String, _is.Endpoint>{
      'emailIdp': _iuc1hd5t.EmailIdpEndpoint()
        ..initialize(
          server,
          'emailIdp',
          null,
        ),
      'jwtRefresh': _inwq3ztq.JwtRefreshEndpoint()
        ..initialize(
          server,
          'jwtRefresh',
          null,
        ),
      'activity': _ijhtbkuk.ActivityEndpoint()
        ..initialize(
          server,
          'activity',
          null,
        ),
      'collaboration': _it38s895.CollaborationEndpoint()
        ..initialize(
          server,
          'collaboration',
          null,
        ),
      'copilot': _ihft4d9p.CopilotEndpoint()
        ..initialize(
          server,
          'copilot',
          null,
        ),
      'dashboard': _ibmx856o.DashboardEndpoint()
        ..initialize(
          server,
          'dashboard',
          null,
        ),
      'event': _icw8lb6p.EventEndpoint()
        ..initialize(
          server,
          'event',
          null,
        ),
      'eventRegistration': _ikdqwe68.EventRegistrationEndpoint()
        ..initialize(
          server,
          'eventRegistration',
          null,
        ),
      'planner': _i3d44723.PlannerEndpoint()
        ..initialize(
          server,
          'planner',
          null,
        ),
      'profile': _i2cx2pww.ProfileEndpoint()
        ..initialize(
          server,
          'profile',
          null,
        ),
      'project': _iemg8ri2.ProjectEndpoint()
        ..initialize(
          server,
          'project',
          null,
        ),
      'seed': _i8h1zywb.SeedEndpoint()
        ..initialize(
          server,
          'seed',
          null,
        ),
      'studyBuddy': _iz7nttta.StudyBuddyEndpoint()
        ..initialize(
          server,
          'studyBuddy',
          null,
        ),
      'studyRequest': _i2439pix.StudyRequestEndpoint()
        ..initialize(
          server,
          'studyRequest',
          null,
        ),
      'greeting': _il624ik7.GreetingEndpoint()
        ..initialize(
          server,
          'greeting',
          null,
        ),
    };
    connectors['emailIdp'] = _is.EndpointConnector(
      name: 'emailIdp',
      endpoint: endpoints['emailIdp']!,
      methodConnectors: {
        'login': _is.MethodConnector(
          name: 'login',
          params: {
            'email': _is.ParameterDescription(
              name: 'email',
              type: _is.getType<String>(),
              nullable: false,
            ),
            'password': _is.ParameterDescription(
              name: 'password',
              type: _is.getType<String>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['emailIdp'] as _iuc1hd5t.EmailIdpEndpoint).login(
                    session,
                    email: params['email'],
                    password: params['password'],
                  ),
        ),
        'startRegistration': _is.MethodConnector(
          name: 'startRegistration',
          params: {
            'email': _is.ParameterDescription(
              name: 'email',
              type: _is.getType<String>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['emailIdp'] as _iuc1hd5t.EmailIdpEndpoint)
                  .startRegistration(
                    session,
                    email: params['email'],
                  ),
        ),
        'verifyRegistrationCode': _is.MethodConnector(
          name: 'verifyRegistrationCode',
          params: {
            'accountRequestId': _is.ParameterDescription(
              name: 'accountRequestId',
              type: _is.getType<_is.UuidValue>(),
              nullable: false,
            ),
            'verificationCode': _is.ParameterDescription(
              name: 'verificationCode',
              type: _is.getType<String>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['emailIdp'] as _iuc1hd5t.EmailIdpEndpoint)
                  .verifyRegistrationCode(
                    session,
                    accountRequestId: params['accountRequestId'],
                    verificationCode: params['verificationCode'],
                  ),
        ),
        'finishRegistration': _is.MethodConnector(
          name: 'finishRegistration',
          params: {
            'registrationToken': _is.ParameterDescription(
              name: 'registrationToken',
              type: _is.getType<String>(),
              nullable: false,
            ),
            'password': _is.ParameterDescription(
              name: 'password',
              type: _is.getType<String>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['emailIdp'] as _iuc1hd5t.EmailIdpEndpoint)
                  .finishRegistration(
                    session,
                    registrationToken: params['registrationToken'],
                    password: params['password'],
                  ),
        ),
        'startPasswordReset': _is.MethodConnector(
          name: 'startPasswordReset',
          params: {
            'email': _is.ParameterDescription(
              name: 'email',
              type: _is.getType<String>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['emailIdp'] as _iuc1hd5t.EmailIdpEndpoint)
                  .startPasswordReset(
                    session,
                    email: params['email'],
                  ),
        ),
        'verifyPasswordResetCode': _is.MethodConnector(
          name: 'verifyPasswordResetCode',
          params: {
            'passwordResetRequestId': _is.ParameterDescription(
              name: 'passwordResetRequestId',
              type: _is.getType<_is.UuidValue>(),
              nullable: false,
            ),
            'verificationCode': _is.ParameterDescription(
              name: 'verificationCode',
              type: _is.getType<String>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['emailIdp'] as _iuc1hd5t.EmailIdpEndpoint)
                  .verifyPasswordResetCode(
                    session,
                    passwordResetRequestId: params['passwordResetRequestId'],
                    verificationCode: params['verificationCode'],
                  ),
        ),
        'finishPasswordReset': _is.MethodConnector(
          name: 'finishPasswordReset',
          params: {
            'finishPasswordResetToken': _is.ParameterDescription(
              name: 'finishPasswordResetToken',
              type: _is.getType<String>(),
              nullable: false,
            ),
            'newPassword': _is.ParameterDescription(
              name: 'newPassword',
              type: _is.getType<String>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['emailIdp'] as _iuc1hd5t.EmailIdpEndpoint)
                  .finishPasswordReset(
                    session,
                    finishPasswordResetToken:
                        params['finishPasswordResetToken'],
                    newPassword: params['newPassword'],
                  ),
        ),
        'hasAccount': _is.MethodConnector(
          name: 'hasAccount',
          params: {},
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['emailIdp'] as _iuc1hd5t.EmailIdpEndpoint)
                  .hasAccount(session),
        ),
      },
    );
    connectors['jwtRefresh'] = _is.EndpointConnector(
      name: 'jwtRefresh',
      endpoint: endpoints['jwtRefresh']!,
      methodConnectors: {
        'refreshAccessToken': _is.MethodConnector(
          name: 'refreshAccessToken',
          params: {
            'refreshToken': _is.ParameterDescription(
              name: 'refreshToken',
              type: _is.getType<String?>(),
              nullable: true,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['jwtRefresh'] as _inwq3ztq.JwtRefreshEndpoint)
                      .refreshAccessToken(
                        session,
                        refreshToken: params['refreshToken'],
                      ),
        ),
      },
    );
    connectors['activity'] = _is.EndpointConnector(
      name: 'activity',
      endpoint: endpoints['activity']!,
      methodConnectors: {
        'getMyActivities': _is.MethodConnector(
          name: 'getMyActivities',
          params: {
            'recipientId': _is.ParameterDescription(
              name: 'recipientId',
              type: _is.getType<int>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['activity'] as _ijhtbkuk.ActivityEndpoint)
                  .getMyActivities(
                    session,
                    params['recipientId'],
                  ),
        ),
        'markAsRead': _is.MethodConnector(
          name: 'markAsRead',
          params: {
            'notificationId': _is.ParameterDescription(
              name: 'notificationId',
              type: _is.getType<int>(),
              nullable: false,
            ),
            'recipientId': _is.ParameterDescription(
              name: 'recipientId',
              type: _is.getType<int>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['activity'] as _ijhtbkuk.ActivityEndpoint)
                  .markAsRead(
                    session,
                    params['notificationId'],
                    params['recipientId'],
                  ),
        ),
        'markAllAsRead': _is.MethodConnector(
          name: 'markAllAsRead',
          params: {
            'recipientId': _is.ParameterDescription(
              name: 'recipientId',
              type: _is.getType<int>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['activity'] as _ijhtbkuk.ActivityEndpoint)
                  .markAllAsRead(
                    session,
                    params['recipientId'],
                  ),
        ),
      },
    );
    connectors['collaboration'] = _is.EndpointConnector(
      name: 'collaboration',
      endpoint: endpoints['collaboration']!,
      methodConnectors: {
        'sendRequest': _is.MethodConnector(
          name: 'sendRequest',
          params: {
            'projectId': _is.ParameterDescription(
              name: 'projectId',
              type: _is.getType<int>(),
              nullable: false,
            ),
            'studentId': _is.ParameterDescription(
              name: 'studentId',
              type: _is.getType<int>(),
              nullable: false,
            ),
            'message': _is.ParameterDescription(
              name: 'message',
              type: _is.getType<String>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['collaboration']
                          as _it38s895.CollaborationEndpoint)
                      .sendRequest(
                        session,
                        params['projectId'],
                        params['studentId'],
                        params['message'],
                      ),
        ),
        'getIncomingRequests': _is.MethodConnector(
          name: 'getIncomingRequests',
          params: {
            'creatorId': _is.ParameterDescription(
              name: 'creatorId',
              type: _is.getType<int>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['collaboration']
                          as _it38s895.CollaborationEndpoint)
                      .getIncomingRequests(
                        session,
                        params['creatorId'],
                      ),
        ),
        'getOutgoingRequests': _is.MethodConnector(
          name: 'getOutgoingRequests',
          params: {
            'studentId': _is.ParameterDescription(
              name: 'studentId',
              type: _is.getType<int>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['collaboration']
                          as _it38s895.CollaborationEndpoint)
                      .getOutgoingRequests(
                        session,
                        params['studentId'],
                      ),
        ),
        'respondToRequest': _is.MethodConnector(
          name: 'respondToRequest',
          params: {
            'requestId': _is.ParameterDescription(
              name: 'requestId',
              type: _is.getType<int>(),
              nullable: false,
            ),
            'creatorId': _is.ParameterDescription(
              name: 'creatorId',
              type: _is.getType<int>(),
              nullable: false,
            ),
            'status': _is.ParameterDescription(
              name: 'status',
              type: _is.getType<String>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['collaboration']
                          as _it38s895.CollaborationEndpoint)
                      .respondToRequest(
                        session,
                        params['requestId'],
                        params['creatorId'],
                        params['status'],
                      ),
        ),
      },
    );
    connectors['copilot'] = _is.EndpointConnector(
      name: 'copilot',
      endpoint: endpoints['copilot']!,
      methodConnectors: {
        'askCopilot': _is.MethodConnector(
          name: 'askCopilot',
          params: {
            'studentId': _is.ParameterDescription(
              name: 'studentId',
              type: _is.getType<int>(),
              nullable: false,
            ),
            'userQuery': _is.ParameterDescription(
              name: 'userQuery',
              type: _is.getType<String>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['copilot'] as _ihft4d9p.CopilotEndpoint)
                  .askCopilot(
                    session,
                    params['studentId'],
                    params['userQuery'],
                  ),
        ),
        'syncCopilotRecommendationsToPlanner': _is.MethodConnector(
          name: 'syncCopilotRecommendationsToPlanner',
          params: {
            'studentId': _is.ParameterDescription(
              name: 'studentId',
              type: _is.getType<int>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['copilot'] as _ihft4d9p.CopilotEndpoint)
                  .syncCopilotRecommendationsToPlanner(
                    session,
                    params['studentId'],
                  ),
        ),
      },
    );
    connectors['dashboard'] = _is.EndpointConnector(
      name: 'dashboard',
      endpoint: endpoints['dashboard']!,
      methodConnectors: {
        'getDashboardData': _is.MethodConnector(
          name: 'getDashboardData',
          params: {
            'studentId': _is.ParameterDescription(
              name: 'studentId',
              type: _is.getType<int>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['dashboard'] as _ibmx856o.DashboardEndpoint)
                  .getDashboardData(
                    session,
                    params['studentId'],
                  ),
        ),
      },
    );
    connectors['event'] = _is.EndpointConnector(
      name: 'event',
      endpoint: endpoints['event']!,
      methodConnectors: {
        'getEvents': _is.MethodConnector(
          name: 'getEvents',
          params: {
            'category': _is.ParameterDescription(
              name: 'category',
              type: _is.getType<String?>(),
              nullable: true,
            ),
            'search': _is.ParameterDescription(
              name: 'search',
              type: _is.getType<String?>(),
              nullable: true,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['event'] as _icw8lb6p.EventEndpoint).getEvents(
                    session,
                    category: params['category'],
                    search: params['search'],
                  ),
        ),
        'getEventById': _is.MethodConnector(
          name: 'getEventById',
          params: {
            'id': _is.ParameterDescription(
              name: 'id',
              type: _is.getType<int>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['event'] as _icw8lb6p.EventEndpoint).getEventById(
                    session,
                    params['id'],
                  ),
        ),
        'createEvent': _is.MethodConnector(
          name: 'createEvent',
          params: {
            'event': _is.ParameterDescription(
              name: 'event',
              type: _is.getType<_i2zef12b.CampusEvent>(),
              nullable: false,
            ),
            'creatorId': _is.ParameterDescription(
              name: 'creatorId',
              type: _is.getType<int>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['event'] as _icw8lb6p.EventEndpoint).createEvent(
                    session,
                    params['event'],
                    params['creatorId'],
                  ),
        ),
        'updateEvent': _is.MethodConnector(
          name: 'updateEvent',
          params: {
            'event': _is.ParameterDescription(
              name: 'event',
              type: _is.getType<_i2zef12b.CampusEvent>(),
              nullable: false,
            ),
            'organizerId': _is.ParameterDescription(
              name: 'organizerId',
              type: _is.getType<int>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['event'] as _icw8lb6p.EventEndpoint).updateEvent(
                    session,
                    params['event'],
                    params['organizerId'],
                  ),
        ),
        'togglePublishEvent': _is.MethodConnector(
          name: 'togglePublishEvent',
          params: {
            'eventId': _is.ParameterDescription(
              name: 'eventId',
              type: _is.getType<int>(),
              nullable: false,
            ),
            'organizerId': _is.ParameterDescription(
              name: 'organizerId',
              type: _is.getType<int>(),
              nullable: false,
            ),
            'publish': _is.ParameterDescription(
              name: 'publish',
              type: _is.getType<bool>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['event'] as _icw8lb6p.EventEndpoint)
                  .togglePublishEvent(
                    session,
                    params['eventId'],
                    params['organizerId'],
                    params['publish'],
                  ),
        ),
        'getOrganizedEvents': _is.MethodConnector(
          name: 'getOrganizedEvents',
          params: {
            'organizerId': _is.ParameterDescription(
              name: 'organizerId',
              type: _is.getType<int>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['event'] as _icw8lb6p.EventEndpoint)
                  .getOrganizedEvents(
                    session,
                    params['organizerId'],
                  ),
        ),
        'toggleBookmark': _is.MethodConnector(
          name: 'toggleBookmark',
          params: {
            'studentId': _is.ParameterDescription(
              name: 'studentId',
              type: _is.getType<int>(),
              nullable: false,
            ),
            'eventId': _is.ParameterDescription(
              name: 'eventId',
              type: _is.getType<int>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['event'] as _icw8lb6p.EventEndpoint)
                  .toggleBookmark(
                    session,
                    params['studentId'],
                    params['eventId'],
                  ),
        ),
        'getBookmarkedEventIds': _is.MethodConnector(
          name: 'getBookmarkedEventIds',
          params: {
            'studentId': _is.ParameterDescription(
              name: 'studentId',
              type: _is.getType<int>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['event'] as _icw8lb6p.EventEndpoint)
                  .getBookmarkedEventIds(
                    session,
                    params['studentId'],
                  ),
        ),
      },
    );
    connectors['eventRegistration'] = _is.EndpointConnector(
      name: 'eventRegistration',
      endpoint: endpoints['eventRegistration']!,
      methodConnectors: {
        'registerForEvent': _is.MethodConnector(
          name: 'registerForEvent',
          params: {
            'studentId': _is.ParameterDescription(
              name: 'studentId',
              type: _is.getType<int>(),
              nullable: false,
            ),
            'eventId': _is.ParameterDescription(
              name: 'eventId',
              type: _is.getType<int>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['eventRegistration']
                          as _ikdqwe68.EventRegistrationEndpoint)
                      .registerForEvent(
                        session,
                        params['studentId'],
                        params['eventId'],
                      ),
        ),
        'cancelRegistration': _is.MethodConnector(
          name: 'cancelRegistration',
          params: {
            'studentId': _is.ParameterDescription(
              name: 'studentId',
              type: _is.getType<int>(),
              nullable: false,
            ),
            'eventId': _is.ParameterDescription(
              name: 'eventId',
              type: _is.getType<int>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['eventRegistration']
                          as _ikdqwe68.EventRegistrationEndpoint)
                      .cancelRegistration(
                        session,
                        params['studentId'],
                        params['eventId'],
                      ),
        ),
        'getMyRegistrations': _is.MethodConnector(
          name: 'getMyRegistrations',
          params: {
            'studentId': _is.ParameterDescription(
              name: 'studentId',
              type: _is.getType<int>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['eventRegistration']
                          as _ikdqwe68.EventRegistrationEndpoint)
                      .getMyRegistrations(
                        session,
                        params['studentId'],
                      ),
        ),
        'getEventRegistrations': _is.MethodConnector(
          name: 'getEventRegistrations',
          params: {
            'eventId': _is.ParameterDescription(
              name: 'eventId',
              type: _is.getType<int>(),
              nullable: false,
            ),
            'organizerId': _is.ParameterDescription(
              name: 'organizerId',
              type: _is.getType<int>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['eventRegistration']
                          as _ikdqwe68.EventRegistrationEndpoint)
                      .getEventRegistrations(
                        session,
                        params['eventId'],
                        params['organizerId'],
                      ),
        ),
      },
    );
    connectors['planner'] = _is.EndpointConnector(
      name: 'planner',
      endpoint: endpoints['planner']!,
      methodConnectors: {
        'getWeekPlan': _is.MethodConnector(
          name: 'getWeekPlan',
          params: {
            'studentId': _is.ParameterDescription(
              name: 'studentId',
              type: _is.getType<int>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['planner'] as _i3d44723.PlannerEndpoint)
                  .getWeekPlan(
                    session,
                    params['studentId'],
                  ),
        ),
        'addPlannerItem': _is.MethodConnector(
          name: 'addPlannerItem',
          params: {
            'item': _is.ParameterDescription(
              name: 'item',
              type: _is.getType<_igkghzxl.PlannerItem>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['planner'] as _i3d44723.PlannerEndpoint)
                  .addPlannerItem(
                    session,
                    params['item'],
                  ),
        ),
        'updatePlannerItem': _is.MethodConnector(
          name: 'updatePlannerItem',
          params: {
            'item': _is.ParameterDescription(
              name: 'item',
              type: _is.getType<_igkghzxl.PlannerItem>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['planner'] as _i3d44723.PlannerEndpoint)
                  .updatePlannerItem(
                    session,
                    params['item'],
                  ),
        ),
        'toggleItemCompleted': _is.MethodConnector(
          name: 'toggleItemCompleted',
          params: {
            'itemId': _is.ParameterDescription(
              name: 'itemId',
              type: _is.getType<int>(),
              nullable: false,
            ),
            'studentId': _is.ParameterDescription(
              name: 'studentId',
              type: _is.getType<int>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['planner'] as _i3d44723.PlannerEndpoint)
                  .toggleItemCompleted(
                    session,
                    params['itemId'],
                    params['studentId'],
                  ),
        ),
        'deletePlannerItem': _is.MethodConnector(
          name: 'deletePlannerItem',
          params: {
            'itemId': _is.ParameterDescription(
              name: 'itemId',
              type: _is.getType<int>(),
              nullable: false,
            ),
            'studentId': _is.ParameterDescription(
              name: 'studentId',
              type: _is.getType<int>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['planner'] as _i3d44723.PlannerEndpoint)
                  .deletePlannerItem(
                    session,
                    params['itemId'],
                    params['studentId'],
                  ),
        ),
      },
    );
    connectors['profile'] = _is.EndpointConnector(
      name: 'profile',
      endpoint: endpoints['profile']!,
      methodConnectors: {
        'getMyProfile': _is.MethodConnector(
          name: 'getMyProfile',
          params: {
            'email': _is.ParameterDescription(
              name: 'email',
              type: _is.getType<String>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['profile'] as _i2cx2pww.ProfileEndpoint)
                  .getMyProfile(
                    session,
                    params['email'],
                  ),
        ),
        'getProfileById': _is.MethodConnector(
          name: 'getProfileById',
          params: {
            'id': _is.ParameterDescription(
              name: 'id',
              type: _is.getType<int>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['profile'] as _i2cx2pww.ProfileEndpoint)
                  .getProfileById(
                    session,
                    params['id'],
                  ),
        ),
        'createOrUpdateProfile': _is.MethodConnector(
          name: 'createOrUpdateProfile',
          params: {
            'profile': _is.ParameterDescription(
              name: 'profile',
              type: _is.getType<_ibrxl8gk.StudentProfile>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['profile'] as _i2cx2pww.ProfileEndpoint)
                  .createOrUpdateProfile(
                    session,
                    params['profile'],
                  ),
        ),
        'getAllStudents': _is.MethodConnector(
          name: 'getAllStudents',
          params: {},
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['profile'] as _i2cx2pww.ProfileEndpoint)
                  .getAllStudents(session),
        ),
      },
    );
    connectors['project'] = _is.EndpointConnector(
      name: 'project',
      endpoint: endpoints['project']!,
      methodConnectors: {
        'createProject': _is.MethodConnector(
          name: 'createProject',
          params: {
            'project': _is.ParameterDescription(
              name: 'project',
              type: _is.getType<_iq9o6tcf.ProjectListing>(),
              nullable: false,
            ),
            'creatorId': _is.ParameterDescription(
              name: 'creatorId',
              type: _is.getType<int>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['project'] as _iemg8ri2.ProjectEndpoint)
                  .createProject(
                    session,
                    params['project'],
                    params['creatorId'],
                  ),
        ),
        'getProjects': _is.MethodConnector(
          name: 'getProjects',
          params: {
            'category': _is.ParameterDescription(
              name: 'category',
              type: _is.getType<String?>(),
              nullable: true,
            ),
            'search': _is.ParameterDescription(
              name: 'search',
              type: _is.getType<String?>(),
              nullable: true,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['project'] as _iemg8ri2.ProjectEndpoint)
                  .getProjects(
                    session,
                    category: params['category'],
                    search: params['search'],
                  ),
        ),
        'getProjectById': _is.MethodConnector(
          name: 'getProjectById',
          params: {
            'id': _is.ParameterDescription(
              name: 'id',
              type: _is.getType<int>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['project'] as _iemg8ri2.ProjectEndpoint)
                  .getProjectById(
                    session,
                    params['id'],
                  ),
        ),
        'getMyProjects': _is.MethodConnector(
          name: 'getMyProjects',
          params: {
            'creatorId': _is.ParameterDescription(
              name: 'creatorId',
              type: _is.getType<int>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['project'] as _iemg8ri2.ProjectEndpoint)
                  .getMyProjects(
                    session,
                    params['creatorId'],
                  ),
        ),
        'updateProjectStatus': _is.MethodConnector(
          name: 'updateProjectStatus',
          params: {
            'projectId': _is.ParameterDescription(
              name: 'projectId',
              type: _is.getType<int>(),
              nullable: false,
            ),
            'creatorId': _is.ParameterDescription(
              name: 'creatorId',
              type: _is.getType<int>(),
              nullable: false,
            ),
            'status': _is.ParameterDescription(
              name: 'status',
              type: _is.getType<String>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['project'] as _iemg8ri2.ProjectEndpoint)
                  .updateProjectStatus(
                    session,
                    params['projectId'],
                    params['creatorId'],
                    params['status'],
                  ),
        ),
      },
    );
    connectors['seed'] = _is.EndpointConnector(
      name: 'seed',
      endpoint: endpoints['seed']!,
      methodConnectors: {
        'seedInitialData': _is.MethodConnector(
          name: 'seedInitialData',
          params: {
            'force': _is.ParameterDescription(
              name: 'force',
              type: _is.getType<bool>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['seed'] as _i8h1zywb.SeedEndpoint).seedInitialData(
                    session,
                    force: params['force'],
                  ),
        ),
      },
    );
    connectors['studyBuddy'] = _is.EndpointConnector(
      name: 'studyBuddy',
      endpoint: endpoints['studyBuddy']!,
      methodConnectors: {
        'getPreferences': _is.MethodConnector(
          name: 'getPreferences',
          params: {
            'studentId': _is.ParameterDescription(
              name: 'studentId',
              type: _is.getType<int>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['studyBuddy'] as _iz7nttta.StudyBuddyEndpoint)
                      .getPreferences(
                        session,
                        params['studentId'],
                      ),
        ),
        'updatePreferences': _is.MethodConnector(
          name: 'updatePreferences',
          params: {
            'preferences': _is.ParameterDescription(
              name: 'preferences',
              type: _is.getType<_iv9oh772.StudyPreferences>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['studyBuddy'] as _iz7nttta.StudyBuddyEndpoint)
                      .updatePreferences(
                        session,
                        params['preferences'],
                      ),
        ),
        'getRecommendations': _is.MethodConnector(
          name: 'getRecommendations',
          params: {
            'currentStudentId': _is.ParameterDescription(
              name: 'currentStudentId',
              type: _is.getType<int>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['studyBuddy'] as _iz7nttta.StudyBuddyEndpoint)
                      .getRecommendations(
                        session,
                        params['currentStudentId'],
                      ),
        ),
      },
    );
    connectors['studyRequest'] = _is.EndpointConnector(
      name: 'studyRequest',
      endpoint: endpoints['studyRequest']!,
      methodConnectors: {
        'sendRequest': _is.MethodConnector(
          name: 'sendRequest',
          params: {
            'senderId': _is.ParameterDescription(
              name: 'senderId',
              type: _is.getType<int>(),
              nullable: false,
            ),
            'recipientId': _is.ParameterDescription(
              name: 'recipientId',
              type: _is.getType<int>(),
              nullable: false,
            ),
            'message': _is.ParameterDescription(
              name: 'message',
              type: _is.getType<String>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['studyRequest'] as _i2439pix.StudyRequestEndpoint)
                      .sendRequest(
                        session,
                        params['senderId'],
                        params['recipientId'],
                        params['message'],
                      ),
        ),
        'getIncomingRequests': _is.MethodConnector(
          name: 'getIncomingRequests',
          params: {
            'recipientId': _is.ParameterDescription(
              name: 'recipientId',
              type: _is.getType<int>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['studyRequest'] as _i2439pix.StudyRequestEndpoint)
                      .getIncomingRequests(
                        session,
                        params['recipientId'],
                      ),
        ),
        'getOutgoingRequests': _is.MethodConnector(
          name: 'getOutgoingRequests',
          params: {
            'senderId': _is.ParameterDescription(
              name: 'senderId',
              type: _is.getType<int>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['studyRequest'] as _i2439pix.StudyRequestEndpoint)
                      .getOutgoingRequests(
                        session,
                        params['senderId'],
                      ),
        ),
        'respondToRequest': _is.MethodConnector(
          name: 'respondToRequest',
          params: {
            'requestId': _is.ParameterDescription(
              name: 'requestId',
              type: _is.getType<int>(),
              nullable: false,
            ),
            'responderId': _is.ParameterDescription(
              name: 'responderId',
              type: _is.getType<int>(),
              nullable: false,
            ),
            'status': _is.ParameterDescription(
              name: 'status',
              type: _is.getType<String>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['studyRequest'] as _i2439pix.StudyRequestEndpoint)
                      .respondToRequest(
                        session,
                        params['requestId'],
                        params['responderId'],
                        params['status'],
                      ),
        ),
        'cancelRequest': _is.MethodConnector(
          name: 'cancelRequest',
          params: {
            'requestId': _is.ParameterDescription(
              name: 'requestId',
              type: _is.getType<int>(),
              nullable: false,
            ),
            'senderId': _is.ParameterDescription(
              name: 'senderId',
              type: _is.getType<int>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['studyRequest'] as _i2439pix.StudyRequestEndpoint)
                      .cancelRequest(
                        session,
                        params['requestId'],
                        params['senderId'],
                      ),
        ),
      },
    );
    connectors['greeting'] = _is.EndpointConnector(
      name: 'greeting',
      endpoint: endpoints['greeting']!,
      methodConnectors: {
        'hello': _is.MethodConnector(
          name: 'hello',
          params: {
            'name': _is.ParameterDescription(
              name: 'name',
              type: _is.getType<String>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['greeting'] as _il624ik7.GreetingEndpoint).hello(
                    session,
                    params['name'],
                  ),
        ),
      },
    );
    modules['serverpod_auth_idp'] = _iais.Endpoints()
      ..initializeEndpoints(server);
    modules['serverpod_auth_core'] = _iacs.Endpoints()
      ..initializeEndpoints(server);
  }
}
