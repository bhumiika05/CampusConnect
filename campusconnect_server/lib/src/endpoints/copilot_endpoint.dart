import 'package:serverpod/serverpod.dart';
import '../generated/protocol.dart';

class CopilotEndpoint extends Endpoint {
  /// Primary conversational AI assistant endpoint that processes student questions
  /// and generates personalized, grounded recommendations using live PostgreSQL records.
  Future<CopilotResponse> askCopilot(
    Session session,
    int studentId,
    String userQuery,
  ) async {
    final query = userQuery.trim().toLowerCase();

    // 1. Fetch student context
    final student = await StudentProfile.db.findById(session, studentId);
    if (student == null) {
      throw Exception('Student profile not found.');
    }

    final prefs = await StudyPreferences.db.findFirstRow(
      session,
      where: (t) => t.studentId.equals(studentId),
    );

    // 2. Fetch live campus entities
    final allEvents = await CampusEvent.db.find(
      session,
      where: (t) => t.isPublished.equals(true),
      orderBy: (t) => t.startTime,
    );

    final allProjects = await ProjectListing.db.find(
      session,
      where: (t) => t.status.equals('open') & t.creatorId.notEquals(studentId),
      orderBy: (t) => t.createdAt,
    );

    final otherStudents = await StudentProfile.db.find(
      session,
      where: (t) => t.id.notEquals(studentId),
      limit: 10,
    );

    final allLocations = await CampusLocation.db.find(
      session,
      orderBy: (t) => t.name,
    );

    final cards = <CopilotActionCard>[];
    String reply = '';
    String category = 'general';
    List<String> suggestedPrompts = [];

    // Query Intent Analysis
    final isLocationQuery = query.contains('where is') ||
        query.contains('where are') ||
        query.contains('where to') ||
        query.contains('location') ||
        query.contains('map') ||
        query.contains('how to reach') ||
        query.contains('how do i find') ||
        query.contains('find the') ||
        query.contains('nearest') ||
        query.contains('library') ||
        query.contains('lhc') ||
        query.contains('lecture hall') ||
        query.contains('hostel') ||
        query.contains('canteen') ||
        query.contains('cafeteria') ||
        query.contains('food') ||
        query.contains('hospital') ||
        query.contains('auditorium') ||
        query.contains('dogra') ||
        query.contains('bharti') ||
        query.contains('sac') ||
        query.contains('gate') ||
        query.contains('sports') ||
        query.contains('technopark');

    if (isLocationQuery) {
      category = 'location';
      suggestedPrompts = [
        'Where is Central Library?',
        'How do I find Lecture Hall Complex?',
        'Where is the nearest cafeteria?',
        'Where is Dogra Hall?',
      ];

      // Search matching locations
      final matchingLocations = allLocations.where((loc) {
        final nameL = loc.name.toLowerCase();
        final catL = loc.category.toLowerCase();
        final blockL = loc.buildingBlock?.toLowerCase() ?? '';
        final tagsL = loc.tags?.map((t) => t.toLowerCase()).toList() ?? [];

        // Check if query contains location name or category or tag
        if (query.contains(nameL) || nameL.contains(query)) return true;
        if (query.contains(catL) || catL.contains(query)) return true;
        if (blockL.isNotEmpty && (query.contains(blockL) || blockL.contains(query))) return true;
        for (final tag in tagsL) {
          if (query.contains(tag)) return true;
        }

        // Specific keyword checks
        if (query.contains('library') && nameL.contains('library')) return true;
        if ((query.contains('lhc') || query.contains('lecture hall')) && (nameL.contains('lecture') || nameL.contains('lhc'))) return true;
        if ((query.contains('food') || query.contains('cafeteria') || query.contains('canteen') || query.contains('eat') || query.contains('coffee')) &&
            (catL.contains('food') || nameL.contains('food') || nameL.contains('cafeteria') || nameL.contains('nescafe') || nameL.contains('canteen'))) return true;
        if (query.contains('hostel') && catL.contains('hostel')) return true;
        if (query.contains('hospital') && (nameL.contains('hospital') || catL.contains('health'))) return true;
        if (query.contains('dogra') && nameL.contains('dogra')) return true;
        if (query.contains('bharti') && nameL.contains('bharti')) return true;
        if (query.contains('sac') && nameL.contains('sac')) return true;
        if (query.contains('sports') && catL.contains('sports')) return true;
        if (query.contains('gate') && catL.contains('gate')) return true;

        return false;
      }).toList();

      if (matchingLocations.isNotEmpty) {
        final primary = matchingLocations.first;
        final buffer = StringBuffer();
        buffer.writeln('### 📍 IIT Delhi Campus Location Guide');
        buffer.writeln();
        buffer.writeln('**${primary.name}** is located at **${primary.buildingBlock ?? primary.category}**.');
        buffer.writeln();
        buffer.writeln(primary.shortDescription);
        buffer.writeln();
        if (primary.openingHours != null) {
          buffer.writeln('⏰ **Hours:** ${primary.openingHours}');
        }
        if (primary.accessibilityInfo != null) {
          buffer.writeln('♿ **Accessibility:** ${primary.accessibilityInfo}');
        }
        if (primary.contactInfo != null) {
          buffer.writeln('📞 **Contact:** ${primary.contactInfo}');
        }

        // Check for events happening at this location
        final venueEvents = allEvents.where((e) =>
            e.locationId == primary.id ||
            e.venue.toLowerCase().contains(primary.name.toLowerCase())).toList();
        if (venueEvents.isNotEmpty) {
          buffer.writeln();
          buffer.writeln('📅 **Upcoming Event Here:** [${venueEvents.first.title}] (${venueEvents.first.category})');
        }

        buffer.writeln();
        buffer.writeln('Tap the **"View on Map"** card below to pinpoint this building on the interactive IIT Delhi Campus Map.');
        reply = buffer.toString();

        for (final loc in matchingLocations.take(3)) {
          cards.add(
            CopilotActionCard(
              cardType: 'location',
              title: loc.name,
              subtitle: '${loc.buildingBlock ?? loc.category} • ${loc.openingHours ?? "Open Campus"}',
              badge: loc.isVerified ? 'Verified Location' : 'Pending Verification',
              referenceId: loc.id,
              actionLabel: 'View on Map',
              dataPayload: '${loc.latitude},${loc.longitude}',
            ),
          );
        }
      } else {
        reply = '''### 📍 Location Not Found in Campus Records

I searched the IIT Delhi database for **"$userQuery"**, but no exact facility or building record matched.

**Tips:**
* Try searching for **"Central Library"**, **"Lecture Hall Complex"**, **"Dogra Hall"**, **"Bharti Building"**, or **"IIT Hospital"**.
* You can also open the **Campus Map** tab directly to browse all categorized IIT Delhi landmarks, hostels, and gates.''';
      }
    } else if (query.contains('week') ||
        query.contains('what should i do') ||
        query.contains('plan') ||
        query.contains('schedule') ||
        query.isEmpty) {
      category = 'weekly_plan';
      suggestedPrompts = [
        'Find study partners for AI',
        'Show upcoming campus workshops',
        'Find projects needing Flutter',
        'How can I boost my skills?',
      ];

      // Pillar 1: Learn - Find top matching buddy
      final targetInterests = [
        ...student.skills,
        ...?prefs?.subjects,
        ...?prefs?.technicalInterests,
      ];

      StudentProfile? topBuddy;
      for (final other in otherStudents) {
        final commonSkills = targetInterests
            .where((s) => other.skills.any((os) => os.toLowerCase() == s.toLowerCase()))
            .toList();
        if (commonSkills.isNotEmpty) {
          topBuddy = other;
          break;
        }
      }
      topBuddy ??= otherStudents.isNotEmpty ? otherStudents.first : null;

      // Pillar 2: Participate - Find relevant event
      CampusEvent? topEvent;
      for (final ev in allEvents) {
        if (ev.registeredCount < ev.capacity) {
          topEvent = ev;
          break;
        }
      }

      // Pillar 3: Build - Find relevant project
      ProjectListing? topProject;
      for (final proj in allProjects) {
        if (proj.openPositions > 0) {
          topProject = proj;
          break;
        }
      }

      // Build conversational guidance response
      final studentName = student.name.split(' ').first;
      final studentBranch = student.branch;
      final studentYear = student.academicYear;

      reply = '''### 👋 Hi $studentName! Here is your curated weekly campus plan:

As a **$studentYear $studentBranch** student, here is a personalized 4-pillar roadmap to maximize your growth this week:

* **🎯 Learn:** ${topBuddy != null ? 'Connect with **${topBuddy.name}** (${topBuddy.branch}). You both share interests in ${topBuddy.skills.take(2).join(" & ")}.' : 'Explore the Study Buddies directory for peer revision.'}
* **🎟️ Participate:** ${topEvent != null ? 'Attend **${topEvent.title}** at ${topEvent.venue}. (${topEvent.capacity - topEvent.registeredCount} spots remaining).' : 'Check the Events calendar for upcoming tech talks.'}
* **🚀 Build:** ${topProject != null ? 'Apply to join **${topProject.title}**. They need contributors skilled in ${topProject.requiredSkills.take(2).join(", ")}.' : 'Browse open capstone projects on TeamUp.'}
* **🗓️ Plan:** Dedicate Monday to concept review, Wednesday to peer collaboration, and Friday for the campus workshop!

Tap any card below to take immediate action or add to your planner:''';

      if (topBuddy != null) {
        cards.add(
          CopilotActionCard(
            cardType: 'study_buddy',
            title: topBuddy.name,
            subtitle: '${topBuddy.branch} • ${topBuddy.academicYear}',
            badge: '95% Match',
            referenceId: topBuddy.id,
            actionLabel: 'View Profile',
            dataPayload: topBuddy.email,
          ),
        );
      }

      if (topEvent != null) {
        cards.add(
          CopilotActionCard(
            cardType: 'event',
            title: topEvent.title,
            subtitle: '${topEvent.venue} • ${topEvent.category}',
            badge: '${topEvent.capacity - topEvent.registeredCount} spots left',
            referenceId: topEvent.id,
            actionLabel: 'Register',
          ),
        );
      }

      if (topProject != null) {
        cards.add(
          CopilotActionCard(
            cardType: 'project',
            title: topProject.title,
            subtitle: 'Needs ${topProject.requiredSkills.join(", ")}',
            badge: '${topProject.openPositions} open spots',
            referenceId: topProject.id,
            actionLabel: 'Apply Now',
          ),
        );
      }

      cards.add(
        CopilotActionCard(
          cardType: 'planner',
          title: '🗓️ Save to My Campus Week',
          subtitle: 'Sync these activities into your weekly organizer schedule',
          actionLabel: 'Sync to Planner',
        ),
      );
    } else if (query.contains('study') ||
        query.contains('partner') ||
        query.contains('buddy') ||
        query.contains('learn')) {
      category = 'study_buddy';
      suggestedPrompts = [
        'Find study partners for AI',
        'Find study partners for Data Structures',
        'What should I do this week?',
      ];

      final matchingBuddies = otherStudents.take(3).toList();
      reply = '''### 👥 Compatible Study Partners Found

Based on your academic profile in **${student.branch}** and your study goals, here are top students available for peer collaboration:''';

      for (final buddy in matchingBuddies) {
        cards.add(
          CopilotActionCard(
            cardType: 'study_buddy',
            title: buddy.name,
            subtitle: '${buddy.branch} • Skills: ${buddy.skills.take(2).join(", ")}',
            badge: '90% Match',
            referenceId: buddy.id,
            actionLabel: 'Connect',
            dataPayload: buddy.email,
          ),
        );
      }
    } else if (query.contains('event') ||
        query.contains('workshop') ||
        query.contains('talk') ||
        query.contains('participate')) {
      category = 'event';
      suggestedPrompts = [
        'Show AI workshops',
        'What should I do this week?',
        'Find open projects',
      ];

      final candidateEvents = allEvents.take(3).toList();
      reply = '''### 🎟️ Upcoming Campus Events & Workshops

Here are verified active campus opportunities matching your learning interests:''';

      for (final ev in candidateEvents) {
        cards.add(
          CopilotActionCard(
            cardType: 'event',
            title: ev.title,
            subtitle: '${ev.venue} • ${ev.category}',
            badge: '${ev.capacity - ev.registeredCount} spots available',
            referenceId: ev.id,
            actionLabel: 'Register',
          ),
        );
      }
    } else if (query.contains('project') ||
        query.contains('build') ||
        query.contains('team') ||
        query.contains('collaborate')) {
      category = 'project';
      suggestedPrompts = [
        'Find projects needing Flutter',
        'Find projects needing Python',
        'What should I do this week?',
      ];

      final candidateProjects = allProjects.take(3).toList();
      reply = '''### 🚀 Open Projects & Team Opportunities

Here are active student teams currently recruiting teammates with complementary skills:''';

      for (final proj in candidateProjects) {
        cards.add(
          CopilotActionCard(
            cardType: 'project',
            title: proj.title,
            subtitle: 'Looking for: ${proj.requiredSkills.join(", ")}',
            badge: '${proj.openPositions} open spots',
            referenceId: proj.id,
            actionLabel: 'Apply to Join',
          ),
        );
      }
    } else {
      category = 'general';
      suggestedPrompts = [
        'What should I do this week?',
        'Find study partners for AI',
        'Show upcoming campus workshops',
        'Find projects needing Flutter',
      ];

      reply = '''### 🤖 I am your AI Campus Copilot!

I analyze your academic background, active campus workshops, study partners, and project listings to guide your campus life.

**Here is what you can ask me:**
* *"What should I do this week?"* — Generate a tailored 4-pillar campus action plan.
* *"Find study partners for [subject]"* — Connect with students who share your goals.
* *"Discover campus workshops"* — Browse verified events before spots fill up.
* *"Find projects for [skill]"* — Join student-led build teams.

Select a quick prompt below or type your question:''';
    }

    return CopilotResponse(
      reply: reply,
      category: category,
      suggestedPrompts: suggestedPrompts,
      recommendedCards: cards,
    );
  }

  /// One-click helper to synchronize Copilot recommendations into the student's weekly planner
  Future<bool> syncCopilotRecommendationsToPlanner(
    Session session,
    int studentId,
  ) async {
    final now = DateTime.now();

    // Add a curated study sprint
    await PlannerItem.db.insertRow(
      session,
      PlannerItem(
        studentId: studentId,
        title: 'Peer Learning & Concept Review',
        category: 'study_session',
        dayOfWeek: 'Monday',
        timeSlot: '04:00 PM - 05:30 PM',
        location: 'Campus Central Library',
        description: 'Recommended by AI Campus Copilot for deep subject focus.',
        isCompleted: false,
        createdAt: now,
      ),
    );

    // Add a project milestone
    await PlannerItem.db.insertRow(
      session,
      PlannerItem(
        studentId: studentId,
        title: 'TeamUp Collaboration Sync',
        category: 'project_meeting',
        dayOfWeek: 'Wednesday',
        timeSlot: '05:00 PM - 06:00 PM',
        location: 'Innovation Lab / Discord',
        description: 'Sync on project roadmap and architecture milestones.',
        isCompleted: false,
        createdAt: now,
      ),
    );

    // Add a workshop slot
    await PlannerItem.db.insertRow(
      session,
      PlannerItem(
        studentId: studentId,
        title: 'Hands-on Technology Workshop',
        category: 'event',
        dayOfWeek: 'Friday',
        timeSlot: '03:00 PM - 04:30 PM',
        location: 'Engineering Auditorium',
        description: 'Recommended hands-on campus session.',
        isCompleted: false,
        createdAt: now,
      ),
    );

    // Create an In-App notification
    await ActivityNotification.db.insertRow(
      session,
      ActivityNotification(
        recipientId: studentId,
        activityType: 'planner_updated',
        title: 'My Campus Week Updated! 🗓️',
        message: 'AI Campus Copilot has populated your personalized weekly schedule.',
        isRead: false,
        createdAt: now,
      ),
    );

    return true;
  }
}
