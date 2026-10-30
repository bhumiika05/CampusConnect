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
import 'dart:async' as _ida;
import 'package:campusconnect_client/src/protocol/activity_notification.dart'
    as _iq707l6z;
import 'package:campusconnect_client/src/protocol/campus_event.dart'
    as _iq3u3g5y;
import 'package:campusconnect_client/src/protocol/collaboration_request.dart'
    as _iqiqy8rh;
import 'package:campusconnect_client/src/protocol/copilot_response.dart'
    as _imgcvws8;
import 'package:campusconnect_client/src/protocol/dashboard_data.dart'
    as _icgq1zx7;
import 'package:campusconnect_client/src/protocol/event_registration.dart'
    as _i5ab8n3y;
import 'package:campusconnect_client/src/protocol/greetings/greeting.dart'
    as _inxi8v3n;
import 'package:campusconnect_client/src/protocol/planner_item.dart'
    as _itig9q59;
import 'package:campusconnect_client/src/protocol/project_listing.dart'
    as _iy7kf7ii;
import 'package:campusconnect_client/src/protocol/student_profile.dart'
    as _i7gx854o;
import 'package:campusconnect_client/src/protocol/study_preferences.dart'
    as _iipaoo6h;
import 'package:campusconnect_client/src/protocol/study_recommendation.dart'
    as _i0k9swt0;
import 'package:campusconnect_client/src/protocol/study_request.dart'
    as _ian5kjnn;
import 'package:campusconnect_client/src/protocol/weekly_planner_summary.dart'
    as _ix0bi4jg;
import 'package:http/http.dart' as _i85jenna;
import 'package:serverpod_auth_core_client/serverpod_auth_core_client.dart'
    as _iacc;
import 'package:serverpod_auth_idp_client/serverpod_auth_idp_client.dart'
    as _iaic;
import 'package:serverpod_client/serverpod_client.dart' as _isc;
import 'protocol.dart' as _il2as5qe;

/// By extending [EmailIdpBaseEndpoint], the email identity provider endpoints
/// are made available on the server and enable the corresponding sign-in widget
/// on the client.
/// {@category Endpoint}
class EndpointEmailIdp extends _iaic.EndpointEmailIdpBase {
  EndpointEmailIdp(_isc.EndpointCaller caller) : super(caller);

  @override
  String get name => 'emailIdp';

  /// Logs in the user and returns a new session.
  ///
  /// Throws an [EmailAccountLoginException] in case of errors, with reason:
  /// - [EmailAccountLoginExceptionReason.invalidCredentials] if the email or
  ///   password is incorrect.
  /// - [EmailAccountLoginExceptionReason.tooManyAttempts] if there have been
  ///   too many failed login attempts.
  ///
  /// Throws an [AuthUserBlockedException] if the auth user is blocked.
  @override
  _ida.Future<_iacc.AuthSuccess> login({
    required String email,
    required String password,
  }) => caller.callServerEndpoint<_iacc.AuthSuccess>(
    'emailIdp',
    'login',
    {
      'email': email,
      'password': password,
    },
  );

  /// Starts the registration for a new user account with an email-based login
  /// associated to it.
  ///
  /// Upon successful completion of this method, an email will have been
  /// sent to [email] with a verification link, which the user must open to
  /// complete the registration.
  ///
  /// Always returns a account request ID, which can be used to complete the
  /// registration. If the email is already registered, the returned ID will not
  /// be valid.
  @override
  _ida.Future<_isc.UuidValue> startRegistration({required String email}) =>
      caller.callServerEndpoint<_isc.UuidValue>(
        'emailIdp',
        'startRegistration',
        {'email': email},
      );

  /// Verifies an account request code and returns a token
  /// that can be used to complete the account creation.
  ///
  /// Throws an [EmailAccountRequestException] in case of errors, with reason:
  /// - [EmailAccountRequestExceptionReason.expired] if the account request has
  ///   already expired.
  /// - [EmailAccountRequestExceptionReason.policyViolation] if the password
  ///   does not comply with the password policy.
  /// - [EmailAccountRequestExceptionReason.invalid] if no request exists
  ///   for the given [accountRequestId] or [verificationCode] is invalid.
  @override
  _ida.Future<String> verifyRegistrationCode({
    required _isc.UuidValue accountRequestId,
    required String verificationCode,
  }) => caller.callServerEndpoint<String>(
    'emailIdp',
    'verifyRegistrationCode',
    {
      'accountRequestId': accountRequestId,
      'verificationCode': verificationCode,
    },
  );

  /// Completes a new account registration, creating a new auth user with a
  /// profile and attaching the given email account to it.
  ///
  /// Throws an [EmailAccountRequestException] in case of errors, with reason:
  /// - [EmailAccountRequestExceptionReason.expired] if the account request has
  ///   already expired.
  /// - [EmailAccountRequestExceptionReason.policyViolation] if the password
  ///   does not comply with the password policy.
  /// - [EmailAccountRequestExceptionReason.invalid] if the [registrationToken]
  ///   is invalid.
  ///
  /// Throws an [AuthUserBlockedException] if the auth user is blocked.
  ///
  /// Returns a session for the newly created user.
  @override
  _ida.Future<_iacc.AuthSuccess> finishRegistration({
    required String registrationToken,
    required String password,
  }) => caller.callServerEndpoint<_iacc.AuthSuccess>(
    'emailIdp',
    'finishRegistration',
    {
      'registrationToken': registrationToken,
      'password': password,
    },
  );

  /// Requests a password reset for [email].
  ///
  /// If the email address is registered, an email with reset instructions will
  /// be send out. If the email is unknown, this method will have no effect.
  ///
  /// Always returns a password reset request ID, which can be used to complete
  /// the reset. If the email is not registered, the returned ID will not be
  /// valid.
  ///
  /// Throws an [EmailAccountPasswordResetException] in case of errors, with reason:
  /// - [EmailAccountPasswordResetExceptionReason.tooManyAttempts] if the user has
  ///   made too many attempts trying to request a password reset.
  ///
  @override
  _ida.Future<_isc.UuidValue> startPasswordReset({required String email}) =>
      caller.callServerEndpoint<_isc.UuidValue>(
        'emailIdp',
        'startPasswordReset',
        {'email': email},
      );

  /// Verifies a password reset code and returns a finishPasswordResetToken
  /// that can be used to finish the password reset.
  ///
  /// Throws an [EmailAccountPasswordResetException] in case of errors, with reason:
  /// - [EmailAccountPasswordResetExceptionReason.expired] if the password reset
  ///   request has already expired.
  /// - [EmailAccountPasswordResetExceptionReason.tooManyAttempts] if the user has
  ///   made too many attempts trying to verify the password reset.
  /// - [EmailAccountPasswordResetExceptionReason.invalid] if no request exists
  ///   for the given [passwordResetRequestId] or [verificationCode] is invalid.
  ///
  /// If multiple steps are required to complete the password reset, this endpoint
  /// should be overridden to return credentials for the next step instead
  /// of the credentials for setting the password.
  @override
  _ida.Future<String> verifyPasswordResetCode({
    required _isc.UuidValue passwordResetRequestId,
    required String verificationCode,
  }) => caller.callServerEndpoint<String>(
    'emailIdp',
    'verifyPasswordResetCode',
    {
      'passwordResetRequestId': passwordResetRequestId,
      'verificationCode': verificationCode,
    },
  );

  /// Completes a password reset request by setting a new password.
  ///
  /// The [verificationCode] returned from [verifyPasswordResetCode] is used to
  /// validate the password reset request.
  ///
  /// Throws an [EmailAccountPasswordResetException] in case of errors, with reason:
  /// - [EmailAccountPasswordResetExceptionReason.expired] if the password reset
  ///   request has already expired.
  /// - [EmailAccountPasswordResetExceptionReason.policyViolation] if the new
  ///   password does not comply with the password policy.
  /// - [EmailAccountPasswordResetExceptionReason.invalid] if no request exists
  ///   for the given [passwordResetRequestId] or [verificationCode] is invalid.
  ///
  /// Throws an [AuthUserBlockedException] if the auth user is blocked.
  @override
  _ida.Future<void> finishPasswordReset({
    required String finishPasswordResetToken,
    required String newPassword,
  }) => caller.callServerEndpoint<void>(
    'emailIdp',
    'finishPasswordReset',
    {
      'finishPasswordResetToken': finishPasswordResetToken,
      'newPassword': newPassword,
    },
  );

  @override
  _ida.Future<bool> hasAccount() => caller.callServerEndpoint<bool>(
    'emailIdp',
    'hasAccount',
    {},
  );
}

/// By extending [RefreshJwtTokensEndpoint], the JWT token refresh endpoint
/// is made available on the server and enables automatic token refresh on the client.
/// {@category Endpoint}
class EndpointJwtRefresh extends _iacc.EndpointRefreshJwtTokens {
  EndpointJwtRefresh(_isc.EndpointCaller caller) : super(caller);

  @override
  String get name => 'jwtRefresh';

  /// Creates a new token pair for the given [refreshToken].
  ///
  /// If [refreshToken] is omitted, cookie-mode web clients fall back to the
  /// configured HttpOnly refresh cookie. When neither source is present this
  /// throws [RefreshTokenNotFoundException], the same public "no usable refresh
  /// credential" exception used for unknown refresh tokens.
  ///
  /// Can throw the following exceptions:
  /// -[RefreshTokenMalformedException]: refresh token is malformed and could
  ///   not be parsed. Not expected to happen for tokens issued by the server.
  /// -[RefreshTokenNotFoundException]: refresh token is unknown to the server.
  ///   Either the token was deleted or generated by a different server.
  /// -[RefreshTokenExpiredException]: refresh token has expired. Will happen
  ///   only if it has not been used within configured `refreshTokenLifetime`.
  /// -[RefreshTokenInvalidSecretException]: refresh token is incorrect, meaning
  ///   it does not refer to the current secret refresh token. This indicates
  ///   either a malfunctioning client or a malicious attempt by someone who has
  ///   obtained the refresh token. In this case the underlying refresh token
  ///   will be deleted, and access to it will expire fully when the last access
  ///   token is elapsed.
  ///
  /// This endpoint is unauthenticated, meaning the client won't include any
  /// authentication information with the call.
  @override
  _ida.Future<_iacc.AuthSuccess> refreshAccessToken({String? refreshToken}) =>
      caller.callServerEndpoint<_iacc.AuthSuccess>(
        'jwtRefresh',
        'refreshAccessToken',
        {'refreshToken': refreshToken},
        authenticated: false,
      );
}

/// {@category Endpoint}
class EndpointActivity extends _isc.EndpointRef {
  EndpointActivity(_isc.EndpointCaller caller) : super(caller);

  @override
  String get name => 'activity';

  /// Fetch recent activity notifications for a student.
  _ida.Future<List<_iq707l6z.ActivityNotification>> getMyActivities(
    int recipientId,
  ) => caller.callServerEndpoint<List<_iq707l6z.ActivityNotification>>(
    'activity',
    'getMyActivities',
    {'recipientId': recipientId},
  );

  /// Mark a single notification as read.
  _ida.Future<bool> markAsRead(
    int notificationId,
    int recipientId,
  ) => caller.callServerEndpoint<bool>(
    'activity',
    'markAsRead',
    {
      'notificationId': notificationId,
      'recipientId': recipientId,
    },
  );

  /// Mark all notifications as read for a student.
  _ida.Future<bool> markAllAsRead(int recipientId) =>
      caller.callServerEndpoint<bool>(
        'activity',
        'markAllAsRead',
        {'recipientId': recipientId},
      );
}

/// {@category Endpoint}
class EndpointCollaboration extends _isc.EndpointRef {
  EndpointCollaboration(_isc.EndpointCaller caller) : super(caller);

  @override
  String get name => 'collaboration';

  /// Send a collaboration request to join a project.
  _ida.Future<_iqiqy8rh.CollaborationRequest> sendRequest(
    int projectId,
    int studentId,
    String message,
  ) => caller.callServerEndpoint<_iqiqy8rh.CollaborationRequest>(
    'collaboration',
    'sendRequest',
    {
      'projectId': projectId,
      'studentId': studentId,
      'message': message,
    },
  );

  /// List incoming collaboration requests for projects created by this student.
  _ida.Future<List<_iqiqy8rh.CollaborationRequest>> getIncomingRequests(
    int creatorId,
  ) => caller.callServerEndpoint<List<_iqiqy8rh.CollaborationRequest>>(
    'collaboration',
    'getIncomingRequests',
    {'creatorId': creatorId},
  );

  /// List outgoing collaboration requests made by this student.
  _ida.Future<List<_iqiqy8rh.CollaborationRequest>> getOutgoingRequests(
    int studentId,
  ) => caller.callServerEndpoint<List<_iqiqy8rh.CollaborationRequest>>(
    'collaboration',
    'getOutgoingRequests',
    {'studentId': studentId},
  );

  /// Project owner response: accept or reject the collaboration request.
  _ida.Future<_iqiqy8rh.CollaborationRequest> respondToRequest(
    int requestId,
    int creatorId,
    String status,
  ) => caller.callServerEndpoint<_iqiqy8rh.CollaborationRequest>(
    'collaboration',
    'respondToRequest',
    {
      'requestId': requestId,
      'creatorId': creatorId,
      'status': status,
    },
  );
}

/// {@category Endpoint}
class EndpointCopilot extends _isc.EndpointRef {
  EndpointCopilot(_isc.EndpointCaller caller) : super(caller);

  @override
  String get name => 'copilot';

  /// Primary conversational AI assistant endpoint that processes student questions
  /// and generates personalized, grounded recommendations using live PostgreSQL records.
  _ida.Future<_imgcvws8.CopilotResponse> askCopilot(
    int studentId,
    String userQuery,
  ) => caller.callServerEndpoint<_imgcvws8.CopilotResponse>(
    'copilot',
    'askCopilot',
    {
      'studentId': studentId,
      'userQuery': userQuery,
    },
  );

  /// One-click helper to synchronize Copilot recommendations into the student's weekly planner
  _ida.Future<bool> syncCopilotRecommendationsToPlanner(int studentId) =>
      caller.callServerEndpoint<bool>(
        'copilot',
        'syncCopilotRecommendationsToPlanner',
        {'studentId': studentId},
      );
}

/// {@category Endpoint}
class EndpointDashboard extends _isc.EndpointRef {
  EndpointDashboard(_isc.EndpointCaller caller) : super(caller);

  @override
  String get name => 'dashboard';

  /// Aggregates personalized dashboard data for a student.
  _ida.Future<_icgq1zx7.DashboardData> getDashboardData(int studentId) =>
      caller.callServerEndpoint<_icgq1zx7.DashboardData>(
        'dashboard',
        'getDashboardData',
        {'studentId': studentId},
      );
}

/// {@category Endpoint}
class EndpointEvent extends _isc.EndpointRef {
  EndpointEvent(_isc.EndpointCaller caller) : super(caller);

  @override
  String get name => 'event';

  /// Fetch all published upcoming campus events, with optional category filtering and search.
  _ida.Future<List<_iq3u3g5y.CampusEvent>> getEvents({
    String? category,
    String? search,
  }) => caller.callServerEndpoint<List<_iq3u3g5y.CampusEvent>>(
    'event',
    'getEvents',
    {
      'category': category,
      'search': search,
    },
  );

  /// Get details for a specific event.
  _ida.Future<_iq3u3g5y.CampusEvent?> getEventById(int id) =>
      caller.callServerEndpoint<_iq3u3g5y.CampusEvent?>(
        'event',
        'getEventById',
        {'id': id},
      );

  /// Organizer: Create a new campus event.
  _ida.Future<_iq3u3g5y.CampusEvent> createEvent(
    _iq3u3g5y.CampusEvent event,
    int creatorId,
  ) => caller.callServerEndpoint<_iq3u3g5y.CampusEvent>(
    'event',
    'createEvent',
    {
      'event': event,
      'creatorId': creatorId,
    },
  );

  /// Organizer: Update an existing event.
  _ida.Future<_iq3u3g5y.CampusEvent> updateEvent(
    _iq3u3g5y.CampusEvent event,
    int organizerId,
  ) => caller.callServerEndpoint<_iq3u3g5y.CampusEvent>(
    'event',
    'updateEvent',
    {
      'event': event,
      'organizerId': organizerId,
    },
  );

  /// Organizer: Toggle publication status of an event.
  _ida.Future<bool> togglePublishEvent(
    int eventId,
    int organizerId,
    bool publish,
  ) => caller.callServerEndpoint<bool>(
    'event',
    'togglePublishEvent',
    {
      'eventId': eventId,
      'organizerId': organizerId,
      'publish': publish,
    },
  );

  /// Organizer: Fetch events organized by this student.
  _ida.Future<List<_iq3u3g5y.CampusEvent>> getOrganizedEvents(
    int organizerId,
  ) => caller.callServerEndpoint<List<_iq3u3g5y.CampusEvent>>(
    'event',
    'getOrganizedEvents',
    {'organizerId': organizerId},
  );

  /// Toggle bookmark for an event.
  _ida.Future<bool> toggleBookmark(
    int studentId,
    int eventId,
  ) => caller.callServerEndpoint<bool>(
    'event',
    'toggleBookmark',
    {
      'studentId': studentId,
      'eventId': eventId,
    },
  );

  /// Get list of bookmarked event IDs for a student.
  _ida.Future<List<int>> getBookmarkedEventIds(int studentId) =>
      caller.callServerEndpoint<List<int>>(
        'event',
        'getBookmarkedEventIds',
        {'studentId': studentId},
      );
}

/// {@category Endpoint}
class EndpointEventRegistration extends _isc.EndpointRef {
  EndpointEventRegistration(_isc.EndpointCaller caller) : super(caller);

  @override
  String get name => 'eventRegistration';

  /// Register a student for a campus event.
  _ida.Future<_i5ab8n3y.EventRegistration> registerForEvent(
    int studentId,
    int eventId,
  ) => caller.callServerEndpoint<_i5ab8n3y.EventRegistration>(
    'eventRegistration',
    'registerForEvent',
    {
      'studentId': studentId,
      'eventId': eventId,
    },
  );

  /// Cancel an existing event registration.
  _ida.Future<bool> cancelRegistration(
    int studentId,
    int eventId,
  ) => caller.callServerEndpoint<bool>(
    'eventRegistration',
    'cancelRegistration',
    {
      'studentId': studentId,
      'eventId': eventId,
    },
  );

  /// List registrations for a student.
  _ida.Future<List<_i5ab8n3y.EventRegistration>> getMyRegistrations(
    int studentId,
  ) => caller.callServerEndpoint<List<_i5ab8n3y.EventRegistration>>(
    'eventRegistration',
    'getMyRegistrations',
    {'studentId': studentId},
  );

  /// Organizer: View attendee registrations for an event.
  _ida.Future<List<_i5ab8n3y.EventRegistration>> getEventRegistrations(
    int eventId,
    int organizerId,
  ) => caller.callServerEndpoint<List<_i5ab8n3y.EventRegistration>>(
    'eventRegistration',
    'getEventRegistrations',
    {
      'eventId': eventId,
      'organizerId': organizerId,
    },
  );
}

/// {@category Endpoint}
class EndpointPlanner extends _isc.EndpointRef {
  EndpointPlanner(_isc.EndpointCaller caller) : super(caller);

  @override
  String get name => 'planner';

  /// Get the full week plan for a student, synthesizing registered events
  /// and personal tasks into an organized schedule.
  _ida.Future<_ix0bi4jg.WeeklyPlannerSummary> getWeekPlan(int studentId) =>
      caller.callServerEndpoint<_ix0bi4jg.WeeklyPlannerSummary>(
        'planner',
        'getWeekPlan',
        {'studentId': studentId},
      );

  /// Add a new personal planner task or study session
  _ida.Future<_itig9q59.PlannerItem> addPlannerItem(
    _itig9q59.PlannerItem item,
  ) => caller.callServerEndpoint<_itig9q59.PlannerItem>(
    'planner',
    'addPlannerItem',
    {'item': item},
  );

  /// Update an existing planner item
  _ida.Future<_itig9q59.PlannerItem> updatePlannerItem(
    _itig9q59.PlannerItem item,
  ) => caller.callServerEndpoint<_itig9q59.PlannerItem>(
    'planner',
    'updatePlannerItem',
    {'item': item},
  );

  /// Toggle task completion status
  _ida.Future<bool> toggleItemCompleted(
    int itemId,
    int studentId,
  ) => caller.callServerEndpoint<bool>(
    'planner',
    'toggleItemCompleted',
    {
      'itemId': itemId,
      'studentId': studentId,
    },
  );

  /// Delete a custom planner task
  _ida.Future<bool> deletePlannerItem(
    int itemId,
    int studentId,
  ) => caller.callServerEndpoint<bool>(
    'planner',
    'deletePlannerItem',
    {
      'itemId': itemId,
      'studentId': studentId,
    },
  );
}

/// {@category Endpoint}
class EndpointProfile extends _isc.EndpointRef {
  EndpointProfile(_isc.EndpointCaller caller) : super(caller);

  @override
  String get name => 'profile';

  /// Fetch a student profile by their unique email.
  _ida.Future<_i7gx854o.StudentProfile?> getMyProfile(String email) =>
      caller.callServerEndpoint<_i7gx854o.StudentProfile?>(
        'profile',
        'getMyProfile',
        {'email': email},
      );

  /// Fetch a student profile by ID.
  _ida.Future<_i7gx854o.StudentProfile?> getProfileById(int id) =>
      caller.callServerEndpoint<_i7gx854o.StudentProfile?>(
        'profile',
        'getProfileById',
        {'id': id},
      );

  /// Create a new profile or update existing one.
  _ida.Future<_i7gx854o.StudentProfile> createOrUpdateProfile(
    _i7gx854o.StudentProfile profile,
  ) => caller.callServerEndpoint<_i7gx854o.StudentProfile>(
    'profile',
    'createOrUpdateProfile',
    {'profile': profile},
  );

  /// Retrieve all registered students.
  _ida.Future<List<_i7gx854o.StudentProfile>> getAllStudents() =>
      caller.callServerEndpoint<List<_i7gx854o.StudentProfile>>(
        'profile',
        'getAllStudents',
        {},
      );
}

/// {@category Endpoint}
class EndpointProject extends _isc.EndpointRef {
  EndpointProject(_isc.EndpointCaller caller) : super(caller);

  @override
  String get name => 'project';

  /// Create a new project listing.
  _ida.Future<_iy7kf7ii.ProjectListing> createProject(
    _iy7kf7ii.ProjectListing project,
    int creatorId,
  ) => caller.callServerEndpoint<_iy7kf7ii.ProjectListing>(
    'project',
    'createProject',
    {
      'project': project,
      'creatorId': creatorId,
    },
  );

  /// Discover open projects with optional category and search filters.
  _ida.Future<List<_iy7kf7ii.ProjectListing>> getProjects({
    String? category,
    String? search,
  }) => caller.callServerEndpoint<List<_iy7kf7ii.ProjectListing>>(
    'project',
    'getProjects',
    {
      'category': category,
      'search': search,
    },
  );

  /// Get details of a single project listing.
  _ida.Future<_iy7kf7ii.ProjectListing?> getProjectById(int id) =>
      caller.callServerEndpoint<_iy7kf7ii.ProjectListing?>(
        'project',
        'getProjectById',
        {'id': id},
      );

  /// List projects created by a specific student.
  _ida.Future<List<_iy7kf7ii.ProjectListing>> getMyProjects(int creatorId) =>
      caller.callServerEndpoint<List<_iy7kf7ii.ProjectListing>>(
        'project',
        'getMyProjects',
        {'creatorId': creatorId},
      );

  /// Update the status of a project (e.g. open, in_progress, completed).
  _ida.Future<_iy7kf7ii.ProjectListing> updateProjectStatus(
    int projectId,
    int creatorId,
    String status,
  ) => caller.callServerEndpoint<_iy7kf7ii.ProjectListing>(
    'project',
    'updateProjectStatus',
    {
      'projectId': projectId,
      'creatorId': creatorId,
      'status': status,
    },
  );
}

/// {@category Endpoint}
class EndpointSeed extends _isc.EndpointRef {
  EndpointSeed(_isc.EndpointCaller caller) : super(caller);

  @override
  String get name => 'seed';

  /// Seeds initial campus community data if database is empty or force is true.
  _ida.Future<bool> seedInitialData({required bool force}) =>
      caller.callServerEndpoint<bool>(
        'seed',
        'seedInitialData',
        {'force': force},
      );
}

/// {@category Endpoint}
class EndpointStudyBuddy extends _isc.EndpointRef {
  EndpointStudyBuddy(_isc.EndpointCaller caller) : super(caller);

  @override
  String get name => 'studyBuddy';

  /// Fetch study preferences for a student.
  _ida.Future<_iipaoo6h.StudyPreferences?> getPreferences(int studentId) =>
      caller.callServerEndpoint<_iipaoo6h.StudyPreferences?>(
        'studyBuddy',
        'getPreferences',
        {'studentId': studentId},
      );

  /// Update or save study preferences.
  _ida.Future<_iipaoo6h.StudyPreferences> updatePreferences(
    _iipaoo6h.StudyPreferences preferences,
  ) => caller.callServerEndpoint<_iipaoo6h.StudyPreferences>(
    'studyBuddy',
    'updatePreferences',
    {'preferences': preferences},
  );

  /// Deterministic, explainable rule-based study buddy recommendation algorithm.
  /// Weights:
  /// - Shared subjects: 40 points
  /// - Compatible study timings: 25 points
  /// - Compatible study mode: 20 points
  /// - Shared learning goals: 15 points
  /// Total: 100 points
  _ida.Future<List<_i0k9swt0.StudyRecommendation>> getRecommendations(
    int currentStudentId,
  ) => caller.callServerEndpoint<List<_i0k9swt0.StudyRecommendation>>(
    'studyBuddy',
    'getRecommendations',
    {'currentStudentId': currentStudentId},
  );
}

/// {@category Endpoint}
class EndpointStudyRequest extends _isc.EndpointRef {
  EndpointStudyRequest(_isc.EndpointCaller caller) : super(caller);

  @override
  String get name => 'studyRequest';

  /// Send a study connection request.
  _ida.Future<_ian5kjnn.StudyRequest> sendRequest(
    int senderId,
    int recipientId,
    String message,
  ) => caller.callServerEndpoint<_ian5kjnn.StudyRequest>(
    'studyRequest',
    'sendRequest',
    {
      'senderId': senderId,
      'recipientId': recipientId,
      'message': message,
    },
  );

  /// List incoming study requests.
  _ida.Future<List<_ian5kjnn.StudyRequest>> getIncomingRequests(
    int recipientId,
  ) => caller.callServerEndpoint<List<_ian5kjnn.StudyRequest>>(
    'studyRequest',
    'getIncomingRequests',
    {'recipientId': recipientId},
  );

  /// List outgoing study requests.
  _ida.Future<List<_ian5kjnn.StudyRequest>> getOutgoingRequests(int senderId) =>
      caller.callServerEndpoint<List<_ian5kjnn.StudyRequest>>(
        'studyRequest',
        'getOutgoingRequests',
        {'senderId': senderId},
      );

  /// Accept or reject incoming request.
  _ida.Future<_ian5kjnn.StudyRequest> respondToRequest(
    int requestId,
    int responderId,
    String status,
  ) => caller.callServerEndpoint<_ian5kjnn.StudyRequest>(
    'studyRequest',
    'respondToRequest',
    {
      'requestId': requestId,
      'responderId': responderId,
      'status': status,
    },
  );

  /// Cancel outgoing pending request.
  _ida.Future<_ian5kjnn.StudyRequest> cancelRequest(
    int requestId,
    int senderId,
  ) => caller.callServerEndpoint<_ian5kjnn.StudyRequest>(
    'studyRequest',
    'cancelRequest',
    {
      'requestId': requestId,
      'senderId': senderId,
    },
  );
}

/// This is an example endpoint that returns a greeting message through
/// its [hello] method.
/// {@category Endpoint}
class EndpointGreeting extends _isc.EndpointRef {
  EndpointGreeting(_isc.EndpointCaller caller) : super(caller);

  @override
  String get name => 'greeting';

  /// Returns a personalized greeting message: "Hello {name}".
  _ida.Future<_inxi8v3n.Greeting> hello(String name) =>
      caller.callServerEndpoint<_inxi8v3n.Greeting>(
        'greeting',
        'hello',
        {'name': name},
      );
}

class Modules {
  Modules(Client client) {
    serverpod_auth_idp = _iaic.Caller(client);
    serverpod_auth_core = _iacc.Caller(client);
  }

  late final _iaic.Caller serverpod_auth_idp;

  late final _iacc.Caller serverpod_auth_core;
}

class Client extends _isc.ServerpodClientShared {
  Client(
    String host, {
    dynamic securityContext,
    Duration? streamingConnectionTimeout,
    Duration? connectionTimeout,
    Function(
      _isc.MethodCallContext,
      Object,
      StackTrace,
    )?
    onFailedCall,
    Function(_isc.MethodCallContext)? onSucceededCall,
    bool? disconnectStreamsOnLostInternetConnection,
    _i85jenna.Client? httpClientOverride,
  }) : super(
         host,
         _il2as5qe.Protocol(),
         securityContext: securityContext,
         streamingConnectionTimeout: streamingConnectionTimeout,
         connectionTimeout: connectionTimeout,
         onFailedCall: onFailedCall,
         onSucceededCall: onSucceededCall,
         disconnectStreamsOnLostInternetConnection:
             disconnectStreamsOnLostInternetConnection,
         httpClientOverride: httpClientOverride,
       ) {
    emailIdp = EndpointEmailIdp(this);
    jwtRefresh = EndpointJwtRefresh(this);
    activity = EndpointActivity(this);
    collaboration = EndpointCollaboration(this);
    copilot = EndpointCopilot(this);
    dashboard = EndpointDashboard(this);
    event = EndpointEvent(this);
    eventRegistration = EndpointEventRegistration(this);
    planner = EndpointPlanner(this);
    profile = EndpointProfile(this);
    project = EndpointProject(this);
    seed = EndpointSeed(this);
    studyBuddy = EndpointStudyBuddy(this);
    studyRequest = EndpointStudyRequest(this);
    greeting = EndpointGreeting(this);
    modules = Modules(this);
  }

  late final EndpointEmailIdp emailIdp;

  late final EndpointJwtRefresh jwtRefresh;

  late final EndpointActivity activity;

  late final EndpointCollaboration collaboration;

  late final EndpointCopilot copilot;

  late final EndpointDashboard dashboard;

  late final EndpointEvent event;

  late final EndpointEventRegistration eventRegistration;

  late final EndpointPlanner planner;

  late final EndpointProfile profile;

  late final EndpointProject project;

  late final EndpointSeed seed;

  late final EndpointStudyBuddy studyBuddy;

  late final EndpointStudyRequest studyRequest;

  late final EndpointGreeting greeting;

  late final Modules modules;

  @override
  Map<String, _isc.EndpointRef> get endpointRefLookup => {
    'emailIdp': emailIdp,
    'jwtRefresh': jwtRefresh,
    'activity': activity,
    'collaboration': collaboration,
    'copilot': copilot,
    'dashboard': dashboard,
    'event': event,
    'eventRegistration': eventRegistration,
    'planner': planner,
    'profile': profile,
    'project': project,
    'seed': seed,
    'studyBuddy': studyBuddy,
    'studyRequest': studyRequest,
    'greeting': greeting,
  };

  @override
  Map<String, _isc.ModuleEndpointCaller> get moduleLookup => {
    'serverpod_auth_idp': modules.serverpod_auth_idp,
    'serverpod_auth_core': modules.serverpod_auth_core,
  };
}
