import 'package:campusconnect_server/src/generated/protocol.dart';
import 'package:test/test.dart';
import 'test_tools/serverpod_test_tools.dart';

void main() {
  withServerpod(
    'CampusConnect Core Logic Tests',
    (sessionBuilder, endpoints) {
      late StudentProfile studentA;
      late StudentProfile studentB;
      late StudentProfile studentC;
      late CampusEvent testEvent;
      late ProjectListing testProject;

      setUp(() async {
        final now = DateTime.now();

        // Create test students with unique emails per setup
        final unique = DateTime.now().microsecondsSinceEpoch;
        studentA = await endpoints.profile.createOrUpdateProfile(
          sessionBuilder,
          StudentProfile(
            name: 'Student A',
            email: 'student.a.$unique@campus.edu',
            branch: 'Computer Science',
            academicYear: '3rd Year',
            bio: 'CS student passionate about systems',
            skills: ['Dart', 'Flutter'],
            interests: ['Systems'],
            isOrganizer: true,
            createdAt: now,
            updatedAt: now,
          ),
        );

        studentB = await endpoints.profile.createOrUpdateProfile(
          sessionBuilder,
          StudentProfile(
            name: 'Student B',
            email: 'student.b.$unique@campus.edu',
            branch: 'Computer Science',
            academicYear: '3rd Year',
            bio: 'CS student identical preferences to A',
            skills: ['Dart', 'Flutter'],
            interests: ['Systems'],
            isOrganizer: false,
            createdAt: now,
            updatedAt: now,
          ),
        );

        studentC = await endpoints.profile.createOrUpdateProfile(
          sessionBuilder,
          StudentProfile(
            name: 'Student C',
            email: 'student.c.$unique@campus.edu',
            branch: 'Civil Engineering',
            academicYear: '1st Year',
            bio: 'Different interests',
            skills: ['AutoCAD'],
            interests: ['Construction'],
            isOrganizer: false,
            createdAt: now,
            updatedAt: now,
          ),
        );

        // Student A & B identical preferences
        await endpoints.studyBuddy.updatePreferences(
          sessionBuilder,
          StudyPreferences(
            studentId: studentA.id!,
            subjects: ['OS', 'Networks', 'Databases'],
            technicalInterests: ['Serverpod'],
            preferredTimings: ['Evening'],
            studyMode: 'Online',
            learningGoals: ['Exam Prep', 'Skill Building'],
            skillLevel: 'Advanced',
            updatedAt: now,
          ),
        );

        await endpoints.studyBuddy.updatePreferences(
          sessionBuilder,
          StudyPreferences(
            studentId: studentB.id!,
            subjects: ['OS', 'Networks', 'Databases'],
            technicalInterests: ['Serverpod'],
            preferredTimings: ['Evening'],
            studyMode: 'Online',
            learningGoals: ['Exam Prep', 'Skill Building'],
            skillLevel: 'Advanced',
            updatedAt: now,
          ),
        );

        // Student C completely non-overlapping preferences
        await endpoints.studyBuddy.updatePreferences(
          sessionBuilder,
          StudyPreferences(
            studentId: studentC.id!,
            subjects: ['Structural Analysis', 'Geotechnical'],
            technicalInterests: ['CAD'],
            preferredTimings: ['Morning'],
            studyMode: 'Offline',
            learningGoals: ['Site Visit'],
            skillLevel: 'Beginner',
            updatedAt: now,
          ),
        );

        // Create test campus event
        testEvent = await endpoints.event.createEvent(
          sessionBuilder,
          CampusEvent(
            title: 'Unit Test Campus Build Challenge',
            description: 'Testing event registrations',
            category: 'Competitions',
            venue: 'Lab 101',
            startTime: now.add(const Duration(days: 1)),
            endTime: now.add(const Duration(days: 2)),
            organizer: 'Student A',
            organizerId: studentA.id,
            isPublished: true,
            capacity: 1, // Only 1 spot for capacity test
            registeredCount: 0,
            bannerColor: '0xFF4338CA',
            createdAt: now,
          ),
          studentA.id!,
        );

        // Create test project
        testProject = await endpoints.project.createProject(
          sessionBuilder,
          ProjectListing(
            title: 'Unit Test Project',
            description: 'Testing teamup collaborations',
            creatorId: studentA.id!,
            creatorName: studentA.name,
            creatorBranch: studentA.branch,
            techStack: ['Flutter'],
            requiredSkills: ['Dart'],
            category: 'Mobile Development',
            totalPositions: 1,
            openPositions: 1,
            status: 'open',
            createdAt: now,
          ),
          studentA.id!,
        );
      });

      test('1. Study matching with identical preferences yields 100% score', () async {
        final recommendations = await endpoints.studyBuddy.getRecommendations(
          sessionBuilder,
          studentA.id!,
        );

        final matchB = recommendations.firstWhere((r) => r.student.id == studentB.id);
        expect(matchB.compatibilityScore, equals(100));
        expect(matchB.timingMatch, isTrue);
        expect(matchB.modeMatch, isTrue);
        expect(matchB.sharedSubjects.length, equals(3));
        expect(matchB.sharedGoals.length, equals(2));
      });

      test('2. Study matching with partially overlapping preferences calculates exact score', () async {
        // Modify B to have partial overlap
        await endpoints.studyBuddy.updatePreferences(
          sessionBuilder,
          StudyPreferences(
            studentId: studentB.id!,
            subjects: ['OS'],
            technicalInterests: ['Serverpod'],
            preferredTimings: ['Morning'], // Not matching student A's Evening -> 0 pts
            studyMode: 'Online', // Matching Online -> 20 pts
            learningGoals: ['Exam Prep'], // 1 of 1 goal -> 15 pts
            skillLevel: 'Intermediate',
            updatedAt: DateTime.now(),
          ),
        );

        final recommendations = await endpoints.studyBuddy.getRecommendations(
          sessionBuilder,
          studentA.id!,
        );

        final matchB = recommendations.firstWhere((r) => r.student.id == studentB.id);
        expect(matchB.compatibilityScore, greaterThan(40));
        expect(matchB.compatibilityScore, lessThan(100));
        expect(matchB.timingMatch, isFalse);
        expect(matchB.modeMatch, isTrue);
      });

      test('3. Study matching with no overlapping preferences yields 0 score', () async {
        final recommendations = await endpoints.studyBuddy.getRecommendations(
          sessionBuilder,
          studentA.id!,
        );

        final matchC = recommendations.firstWhere((r) => r.student.id == studentC.id);
        expect(matchC.compatibilityScore, equals(0));
        expect(matchC.timingMatch, isFalse);
        expect(matchC.modeMatch, isFalse);
        expect(matchC.sharedSubjects, isEmpty);
      });

      test('4. Exclusion of the current student from recommendations', () async {
        final recommendations = await endpoints.studyBuddy.getRecommendations(
          sessionBuilder,
          studentA.id!,
        );

        final containsSelf = recommendations.any((r) => r.student.id == studentA.id);
        expect(containsSelf, isFalse);
      });

      test('5. Duplicate study-request prevention', () async {
        // First request succeeds
        await endpoints.studyRequest.sendRequest(
          sessionBuilder,
          studentA.id!,
          studentB.id!,
          'Let us study together!',
        );

        // Duplicate request should throw exception
        expect(
          endpoints.studyRequest.sendRequest(
            sessionBuilder,
            studentA.id!,
            studentB.id!,
            'Second request should fail',
          ),
          throwsA(isA<Exception>()),
        );
      });

      test('6. Study-request authorization (only recipient can accept/reject)', () async {
        final request = await endpoints.studyRequest.sendRequest(
          sessionBuilder,
          studentA.id!,
          studentB.id!,
          'Study together please',
        );

        // Third party (studentC) trying to respond must fail
        expect(
          endpoints.studyRequest.respondToRequest(
            sessionBuilder,
            request.id!,
            studentC.id!,
            'accepted',
          ),
          throwsA(isA<Exception>()),
        );

        // Actual recipient (studentB) can accept
        final accepted = await endpoints.studyRequest.respondToRequest(
          sessionBuilder,
          request.id!,
          studentB.id!,
          'accepted',
        );
        expect(accepted.status, equals('accepted'));
      });

      test('7. Duplicate event-registration prevention', () async {
        final reg1 = await endpoints.eventRegistration.registerForEvent(
          sessionBuilder,
          studentB.id!,
          testEvent.id!,
        );
        expect(reg1.status, equals('confirmed'));

        // Duplicate registration attempt by studentB should fail
        expect(
          endpoints.eventRegistration.registerForEvent(
            sessionBuilder,
            studentB.id!,
            testEvent.id!,
          ),
          throwsA(isA<Exception>()),
        );
      });

      test('8. Event publication permissions (only organizer can publish/unpublish)', () async {
        // Non-organizer (studentB) attempting to toggle publish should fail
        expect(
          endpoints.event.togglePublishEvent(
            sessionBuilder,
            testEvent.id!,
            studentB.id!,
            false,
          ),
          throwsA(isA<Exception>()),
        );

        // Actual organizer (studentA) succeeds
        final result = await endpoints.event.togglePublishEvent(
          sessionBuilder,
          testEvent.id!,
          studentA.id!,
          false,
        );
        expect(result, isFalse);
      });

      test('9. Collaboration-request authorization & creator response', () async {
        // Cannot request own project
        expect(
          endpoints.collaboration.sendRequest(
            sessionBuilder,
            testProject.id!,
            studentA.id!,
            'Joining my own project',
          ),
          throwsA(isA<Exception>()),
        );

        // Student B requests to join
        final req = await endpoints.collaboration.sendRequest(
          sessionBuilder,
          testProject.id!,
          studentB.id!,
          'I know Flutter and Dart!',
        );
        expect(req.status, equals('pending'));

        // Non-creator cannot accept
        expect(
          endpoints.collaboration.respondToRequest(
            sessionBuilder,
            req.id!,
            studentC.id!,
            'accepted',
          ),
          throwsA(isA<Exception>()),
        );

        // Creator accepts
        final accepted = await endpoints.collaboration.respondToRequest(
          sessionBuilder,
          req.id!,
          studentA.id!,
          'accepted',
        );
        expect(accepted.status, equals('accepted'));
      });

      test('10. Project capacity validation prevents registration beyond open positions', () async {
        // Create full project with 0 open positions
        final fullProject = await endpoints.project.createProject(
          sessionBuilder,
          ProjectListing(
            title: 'Full Capacity Project',
            description: 'No spots available',
            creatorId: studentA.id!,
            creatorName: studentA.name,
            creatorBranch: studentA.branch,
            techStack: ['Flutter'],
            requiredSkills: ['Dart'],
            category: 'Mobile Development',
            totalPositions: 0,
            openPositions: 0,
            status: 'in_progress',
            createdAt: DateTime.now(),
          ),
          studentA.id!,
        );

        expect(
          endpoints.collaboration.sendRequest(
            sessionBuilder,
            fullProject.id!,
            studentC.id!,
            'Any more spots left?',
          ),
          throwsA(isA<Exception>()),
        );
      });

      test('11. Planner: add personal task, toggle completion, and retrieve week plan', () async {
        final item = await endpoints.planner.addPlannerItem(
          sessionBuilder,
          PlannerItem(
            studentId: studentA.id!,
            title: 'Algorithms Revision',
            category: 'study_session',
            dayOfWeek: 'Monday',
            timeSlot: '09:00 AM - 10:30 AM',
            location: 'Central Library',
            description: 'Focused graph traversal review.',
            isCompleted: false,
            createdAt: DateTime.now(),
          ),
        );
        expect(item.id, isNotNull);
        expect(item.title, equals('Algorithms Revision'));

        // Toggle completion
        final toggled = await endpoints.planner.toggleItemCompleted(
          sessionBuilder,
          item.id!,
          studentA.id!,
        );
        expect(toggled, isTrue);

        // Retrieve full week plan
        final summary = await endpoints.planner.getWeekPlan(
          sessionBuilder,
          studentA.id!,
        );
        expect(summary.totalTasks, greaterThanOrEqualTo(1));
        expect(summary.completedTasks, greaterThanOrEqualTo(1));
      });

      test('12. AI Campus Copilot: returns personalized 4-pillar response and grounded action cards', () async {
        final response = await endpoints.copilot.askCopilot(
          sessionBuilder,
          studentA.id!,
          'What should I do this week?',
        );

        expect(response.category, equals('weekly_plan'));
        expect(response.reply, contains('curated weekly campus plan'));
        expect(response.recommendedCards, isNotEmpty);
        expect(response.suggestedPrompts, isNotEmpty);
      });
    },
    rollbackDatabase: RollbackDatabase.disabled,
  );
}
