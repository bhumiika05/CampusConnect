import 'package:serverpod/serverpod.dart';
import '../generated/protocol.dart';

class SeedDataService {
  static Future<bool> seedIfEmpty(Session session, {bool force = false}) async {
    // Ensure verified IIT Delhi locations are always populated
    final locationCount = await CampusLocation.db.count(session);
    if (locationCount == 0 && !force) {
      session.log('Locations table is empty, seeding verified IIT Delhi landmarks...');
      await _seedLocations(session);
    }

    final profileCount = await StudentProfile.db.count(session);
    if (profileCount > 0 && !force) {
      session.log(
        'Database already has $profileCount profiles, skipping profile/event seed.',
      );
      return false;
    }

    if (force) {
      session.log('Force re-seeding database...');
      // Clear existing records in logical order
      await PlannerItem.db.deleteWhere(
        session,
        where: (t) => t.id.notEquals(-1),
      );
      await ActivityNotification.db.deleteWhere(
        session,
        where: (t) => t.id.notEquals(-1),
      );
      await CollaborationRequest.db.deleteWhere(
        session,
        where: (t) => t.id.notEquals(-1),
      );
      await EventRegistration.db.deleteWhere(
        session,
        where: (t) => t.id.notEquals(-1),
      );
      await EventBookmark.db.deleteWhere(
        session,
        where: (t) => t.id.notEquals(-1),
      );
      await StudyRequest.db.deleteWhere(
        session,
        where: (t) => t.id.notEquals(-1),
      );
      await ProjectListing.db.deleteWhere(
        session,
        where: (t) => t.id.notEquals(-1),
      );
      await CampusEvent.db.deleteWhere(
        session,
        where: (t) => t.id.notEquals(-1),
      );
      await StudyPreferences.db.deleteWhere(
        session,
        where: (t) => t.id.notEquals(-1),
      );
      await CampusLocation.db.deleteWhere(
        session,
        where: (t) => t.id.notEquals(-1),
      );
      await StudentProfile.db.deleteWhere(
        session,
        where: (t) => t.id.notEquals(-1),
      );
    }

    session.log('Seeding student profiles...');
    final now = DateTime.now();

    // 10 diverse, realistic student profiles
    final rawProfiles = [
      StudentProfile(
        name: 'Aarav Sharma',
        email: 'aarav.sharma@campus.edu',
        branch: 'Computer Science',
        academicYear: '3rd Year',
        bio:
            'Passionate about distributed systems, cloud computing, and competitive algorithms. Looking for study partners for Advanced OS and Cloud Architecture.',
        avatarUrl:
            'https://images.unsplash.com/photo-1535713875002-d1d0cf377fde?w=200&h=200&fit=crop&crop=faces',
        skills: ['Dart', 'Flutter', 'Go', 'Docker', 'PostgreSQL'],
        interests: [
          'Distributed Systems',
          'Open Source',
          'Badminton',
          'Tech Podcasting',
        ],
        isOrganizer: true,
        createdAt: now,
        updatedAt: now,
      ),
      StudentProfile(
        name: 'Priya Patel',
        email: 'priya.patel@campus.edu',
        branch: 'Artificial Intelligence & DS',
        academicYear: '3rd Year',
        bio:
            'Deep learning researcher & computer vision enthusiast. Currently prepping for upcoming AI project submissions and Machine Learning exams.',
        avatarUrl:
            'https://images.unsplash.com/photo-1494790108377-be9c29b29330?w=200&h=200&fit=crop&crop=faces',
        skills: [
          'Python',
          'PyTorch',
          'TensorFlow',
          'FastAPI',
          'Data Visualization',
        ],
        interests: ['Neural Networks', 'Robotics', 'Debating', 'Digital Art'],
        isOrganizer: true,
        createdAt: now,
        updatedAt: now,
      ),
      StudentProfile(
        name: 'Rohan Verma',
        email: 'rohan.verma@campus.edu',
        branch: 'Information Technology',
        academicYear: '2nd Year',
        bio:
            'Full-stack mobile dev builder. Crafting modern Flutter UI/UX and learning Dart Serverpod for scalable backends.',
        avatarUrl:
            'https://images.unsplash.com/photo-1570295999919-56ceb5ecca61?w=200&h=200&fit=crop&crop=faces',
        skills: ['Flutter', 'Dart', 'React', 'Node.js', 'UI/UX Design'],
        interests: [
          'Mobile Development',
          'Frontend Architecture',
          'Guitar',
          'Chess',
        ],
        isOrganizer: false,
        createdAt: now,
        updatedAt: now,
      ),
      StudentProfile(
        name: 'Ananya Iyer',
        email: 'ananya.iyer@campus.edu',
        branch: 'Electronics & Communication',
        academicYear: '4th Year',
        bio:
            'Embedded IoT developer & VLSI student. Preparing for core engineering placements and hardware design projects.',
        avatarUrl:
            'https://images.unsplash.com/photo-1580489944761-15a19d654956?w=200&h=200&fit=crop&crop=faces',
        skills: ['C++', 'Embedded C', 'Verilog', 'MATLAB', 'Circuit Design'],
        interests: ['IoT', 'Microcontrollers', 'Classical Dance', 'Reading'],
        isOrganizer: true,
        createdAt: now,
        updatedAt: now,
      ),
      StudentProfile(
        name: 'Kabir Mehta',
        email: 'kabir.mehta@campus.edu',
        branch: 'Computer Science',
        academicYear: '2nd Year',
        bio:
            'Cybersecurity enthusiast & bug hunter. Studying Cryptography, Computer Networks, and reverse engineering.',
        avatarUrl:
            'https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?w=200&h=200&fit=crop&crop=faces',
        skills: ['Linux', 'Python', 'Wireshark', 'Bash', 'Network Security'],
        interests: [
          'Ethical Hacking',
          'Capture The Flag',
          'Gaming',
          'Table Tennis',
        ],
        isOrganizer: false,
        createdAt: now,
        updatedAt: now,
      ),
      StudentProfile(
        name: 'Sneha Kulkarni',
        email: 'sneha.kulkarni@campus.edu',
        branch: 'Data Science',
        academicYear: '3rd Year',
        bio:
            'Statistics nerd who loves turning messy datasets into beautiful business insights and predictive ML models.',
        avatarUrl:
            'https://images.unsplash.com/photo-1534528741775-53994a69daeb?w=200&h=200&fit=crop&crop=faces',
        skills: ['R', 'Python', 'SQL', 'Tableau', 'Scikit-Learn'],
        interests: [
          'Predictive Analytics',
          'Bioinformatics',
          'Yoga',
          'Photography',
        ],
        isOrganizer: false,
        createdAt: now,
        updatedAt: now,
      ),
      StudentProfile(
        name: 'Devansh Nair',
        email: 'devansh.nair@campus.edu',
        branch: 'Mechanical & Automation',
        academicYear: '3rd Year',
        bio:
            'CAD designer transitioning into Mechatronics & Autonomous Driving. Excited to collaborate on interdisciplinary engineering builds.',
        avatarUrl:
            'https://images.unsplash.com/photo-1500648767791-00dcc994a43e?w=200&h=200&fit=crop&crop=faces',
        skills: ['SolidWorks', 'ROS', 'Python', 'Automation', '3D Printing'],
        interests: ['Robotics', 'Formula Student', 'Cycling', 'Astronomy'],
        isOrganizer: false,
        createdAt: now,
        updatedAt: now,
      ),
      StudentProfile(
        name: 'Tanvi Sen',
        email: 'tanvi.sen@campus.edu',
        branch: 'Computer Science',
        academicYear: '4th Year',
        bio:
            'Graduating senior focused on algorithms, software system design, and placement interview coaching.',
        avatarUrl:
            'https://images.unsplash.com/photo-1517841905240-472988babdf9?w=200&h=200&fit=crop&crop=faces',
        skills: ['Java', 'C++', 'System Design', 'Algorithms', 'Spring Boot'],
        interests: [
          'Placement Prep',
          'Competitive Coding',
          'Singing',
          'Blogging',
        ],
        isOrganizer: true,
        createdAt: now,
        updatedAt: now,
      ),
      StudentProfile(
        name: 'Ishaan Gupta',
        email: 'ishaan.gupta@campus.edu',
        branch: 'Electrical Engineering',
        academicYear: '2nd Year',
        bio:
            'Curious about power electronics and smart grids. Looking for a study buddy for Control Systems and Circuit Analysis.',
        avatarUrl:
            'https://images.unsplash.com/photo-1522075469751-3a6694fb2f61?w=200&h=200&fit=crop&crop=faces',
        skills: ['MATLAB', 'Simulink', 'C', 'Arduino', 'Power Systems'],
        interests: ['Renewable Energy', 'Smart Grids', 'Football', 'Cooking'],
        isOrganizer: false,
        createdAt: now,
        updatedAt: now,
      ),
      StudentProfile(
        name: 'Meera Rao',
        email: 'meera.rao@campus.edu',
        branch: 'Information Technology',
        academicYear: '1st Year',
        bio:
            'First-year explorer enthusiastic about learning web dev, data structures, and joining student societies.',
        avatarUrl:
            'https://images.unsplash.com/photo-1544005313-94ddf0286df2?w=200&h=200&fit=crop&crop=faces',
        skills: ['HTML/CSS', 'JavaScript', 'C', 'Git'],
        interests: ['Web Development', 'Student Societies', 'Drama', 'Writing'],
        isOrganizer: false,
        createdAt: now,
        updatedAt: now,
      ),
    ];

    final insertedProfiles = <StudentProfile>[];
    for (final p in rawProfiles) {
      insertedProfiles.add(await StudentProfile.db.insertRow(session, p));
    }

    session.log('Seeding study preferences...');
    final rawPreferences = [
      // Aarav (id: 1)
      StudyPreferences(
        studentId: insertedProfiles[0].id!,
        subjects: [
          'Operating Systems',
          'Cloud Architecture',
          'Computer Networks',
          'Database Systems',
        ],
        technicalInterests: [
          'Serverpod',
          'Distributed Systems',
          'Cloud',
          'Microservices',
        ],
        preferredTimings: ['Evening (6PM - 9PM)', 'Late Night (9PM - 12AM)'],
        studyMode: 'Hybrid',
        learningGoals: ['Exam Prep', 'Skill Building', 'Project Development'],
        skillLevel: 'Advanced',
        updatedAt: now,
      ),
      // Priya (id: 2)
      StudyPreferences(
        studentId: insertedProfiles[1].id!,
        subjects: [
          'Machine Learning',
          'Computer Vision',
          'Deep Learning',
          'Data Structures',
        ],
        technicalInterests: [
          'PyTorch',
          'Computer Vision',
          'Generative AI',
          'NLP',
        ],
        preferredTimings: ['Morning (9AM - 12PM)', 'Afternoon (2PM - 5PM)'],
        studyMode: 'Online',
        learningGoals: [
          'Skill Building',
          'Research Project',
          'Coursework Mastery',
        ],
        skillLevel: 'Advanced',
        updatedAt: now,
      ),
      // Rohan (id: 3)
      StudyPreferences(
        studentId: insertedProfiles[2].id!,
        subjects: [
          'Mobile App Development',
          'Operating Systems',
          'Database Systems',
          'Software Engineering',
        ],
        technicalInterests: [
          'Flutter',
          'Dart',
          'Full-Stack Mobile',
          'Clean Architecture',
        ],
        preferredTimings: ['Evening (6PM - 9PM)', 'Late Night (9PM - 12AM)'],
        studyMode: 'Hybrid',
        learningGoals: ['Project Development', 'Skill Building', 'Exam Prep'],
        skillLevel: 'Intermediate',
        updatedAt: now,
      ),
      // Ananya (id: 4)
      StudyPreferences(
        studentId: insertedProfiles[3].id!,
        subjects: [
          'Embedded Systems',
          'Digital Signal Processing',
          'Computer Networks',
          'VLSI Design',
        ],
        technicalInterests: [
          'IoT',
          'Hardware Prototyping',
          'Verilog',
          'Sensors',
        ],
        preferredTimings: ['Morning (9AM - 12PM)', 'Evening (6PM - 9PM)'],
        studyMode: 'Offline',
        learningGoals: ['Placement Prep', 'Exam Prep', 'Coursework Mastery'],
        skillLevel: 'Advanced',
        updatedAt: now,
      ),
      // Kabir (id: 5)
      StudyPreferences(
        studentId: insertedProfiles[4].id!,
        subjects: [
          'Cryptography',
          'Computer Networks',
          'Operating Systems',
          'Network Security',
        ],
        technicalInterests: [
          'Cybersecurity',
          'Penetration Testing',
          'Linux',
          'Cryptography',
        ],
        preferredTimings: ['Late Night (9PM - 12AM)', 'Evening (6PM - 9PM)'],
        studyMode: 'Online',
        learningGoals: ['Skill Building', 'Project Development'],
        skillLevel: 'Intermediate',
        updatedAt: now,
      ),
      // Sneha (id: 6)
      StudyPreferences(
        studentId: insertedProfiles[5].id!,
        subjects: [
          'Machine Learning',
          'Probability & Statistics',
          'Database Systems',
          'Data Analytics',
        ],
        technicalInterests: [
          'Data Science',
          'Predictive Modeling',
          'Tableau',
          'Feature Engineering',
        ],
        preferredTimings: ['Afternoon (2PM - 5PM)', 'Evening (6PM - 9PM)'],
        studyMode: 'Hybrid',
        learningGoals: ['Skill Building', 'Coursework Mastery', 'Exam Prep'],
        skillLevel: 'Intermediate',
        updatedAt: now,
      ),
      // Devansh (id: 7)
      StudyPreferences(
        studentId: insertedProfiles[6].id!,
        subjects: [
          'Mechatronics',
          'Robotics & Control',
          'Embedded Systems',
          'Engineering Mechanics',
        ],
        technicalInterests: [
          'ROS',
          'Autonomous Systems',
          '3D Prototyping',
          'Automation',
        ],
        preferredTimings: ['Evening (6PM - 9PM)', 'Morning (9AM - 12PM)'],
        studyMode: 'Offline',
        learningGoals: ['Project Development', 'Skill Building'],
        skillLevel: 'Intermediate',
        updatedAt: now,
      ),
      // Tanvi (id: 8)
      StudyPreferences(
        studentId: insertedProfiles[7].id!,
        subjects: [
          'Data Structures & Algorithms',
          'System Design',
          'Operating Systems',
          'Database Systems',
        ],
        technicalInterests: [
          'LeetCode',
          'High Level Design',
          'Distributed Systems',
          'Spring Boot',
        ],
        preferredTimings: ['Morning (9AM - 12PM)', 'Late Night (9PM - 12AM)'],
        studyMode: 'Hybrid',
        learningGoals: ['Placement Prep', 'Exam Prep', 'Skill Building'],
        skillLevel: 'Advanced',
        updatedAt: now,
      ),
      // Ishaan (id: 9)
      StudyPreferences(
        studentId: insertedProfiles[8].id!,
        subjects: [
          'Control Systems',
          'Circuit Analysis',
          'Power Systems',
          'Signals & Systems',
        ],
        technicalInterests: [
          'Smart Grids',
          'MATLAB',
          'Renewable Energy',
          'Automation',
        ],
        preferredTimings: ['Afternoon (2PM - 5PM)', 'Evening (6PM - 9PM)'],
        studyMode: 'Offline',
        learningGoals: ['Exam Prep', 'Coursework Mastery'],
        skillLevel: 'Beginner',
        updatedAt: now,
      ),
      // Meera (id: 10)
      StudyPreferences(
        studentId: insertedProfiles[9].id!,
        subjects: [
          'Data Structures',
          'Web Development Fundamentals',
          'Discrete Mathematics',
          'C Programming',
        ],
        technicalInterests: [
          'HTML/CSS',
          'JavaScript',
          'Frontend Dev',
          'Algorithms',
        ],
        preferredTimings: ['Evening (6PM - 9PM)', 'Morning (9AM - 12PM)'],
        studyMode: 'Online',
        learningGoals: ['Coursework Mastery', 'Skill Building'],
        skillLevel: 'Beginner',
        updatedAt: now,
      ),
    ];

    for (final pref in rawPreferences) {
      await StudyPreferences.db.insertRow(session, pref);
    }

    session.log('Seeding IIT Delhi campus locations...');
    final insertedLocations = await _seedLocations(session);

    final dograHall = insertedLocations.firstWhere((l) => l.name.contains('Dogra Hall'));
    final bhartiBuilding = insertedLocations.firstWhere((l) => l.name.contains('Bharti'));
    final lhc = insertedLocations.firstWhere((l) => l.name.contains('Lecture Hall'));
    final mainBuilding = insertedLocations.firstWhere((l) => l.name.contains('Main Building'));
    final library = insertedLocations.firstWhere((l) => l.name.contains('Library'));
    final sac = insertedLocations.firstWhere((l) => l.name.contains('Amphitheatre'));

    session.log('Seeding campus events...');
    // 7 rich, vibrant campus events across diverse categories (NO FORBIDDEN WORDS)
    final events = [
      CampusEvent(
        title: 'Campus CodeSprint & Project Showcase',
        description:
            'A 24-hour collaborative sprint where student teams design, build, and showcase innovative software and hardware prototypes. Mentors, prizes, and industry judges included!',
        category: 'Competitions',
        venue: 'Dogra Hall & Innovation Lab',
        locationId: dograHall.id,
        startTime: now.add(const Duration(days: 3, hours: 9)),
        endTime: now.add(const Duration(days: 4, hours: 18)),
        organizer: 'Google Developer Student Club',
        organizerId: insertedProfiles[0].id,
        isPublished: true,
        capacity: 120,
        registeredCount: 84,
        bannerColor: '0xFF4338CA', // Indigo
        createdAt: now,
      ),
      CampusEvent(
        title: 'Generative AI & Deep Learning Masterclass',
        description:
            'Hands-on workshop building multimodal AI agents, LLM pipelines, and vision models with PyTorch. Laptops required.',
        category: 'Workshops',
        venue: 'Bharti Building Lab 201',
        locationId: bhartiBuilding.id,
        startTime: now.add(const Duration(days: 5, hours: 14)),
        endTime: now.add(const Duration(days: 5, hours: 17)),
        organizer: 'AI Research Society',
        organizerId: insertedProfiles[1].id,
        isPublished: true,
        capacity: 80,
        registeredCount: 65,
        bannerColor: '0xFF7C3AED', // Purple
        createdAt: now,
      ),
      CampusEvent(
        title: 'Full-Stack Flutter & Serverpod Bootcamp',
        description:
            'Learn modern full-stack Dart development from scratch! Build real-time reactive mobile apps backed by PostgreSQL and Serverpod cloud architecture.',
        category: 'Workshops',
        venue: 'Lecture Hall Complex (LHC) Hall 101',
        locationId: lhc.id,
        startTime: now.add(const Duration(days: 7, hours: 10)),
        endTime: now.add(const Duration(days: 7, hours: 15)),
        organizer: 'CampusConnect Developer Community',
        organizerId: insertedProfiles[2].id,
        isPublished: true,
        capacity: 60,
        registeredCount: 42,
        bannerColor: '0xFF0284C7', // Sky Blue
        createdAt: now,
      ),
      CampusEvent(
        title: 'Annual TechFest: Innovation Expo & Robot Wars',
        description:
            'The pinnacle celebration of engineering creativity! Featuring battle bots, autonomous rover demonstrations, drone racing, and guest lectures from space scientists.',
        category: 'Tech Showcase',
        venue: 'Main Building Quadrangle',
        locationId: mainBuilding.id,
        startTime: now.add(const Duration(days: 12, hours: 10)),
        endTime: now.add(const Duration(days: 14, hours: 20)),
        organizer: 'Robotics & Automation Club',
        organizerId: insertedProfiles[3].id,
        isPublished: true,
        capacity: 500,
        registeredCount: 310,
        bannerColor: '0xFFD97706', // Amber
        createdAt: now,
      ),
      CampusEvent(
        title: 'Tech Placement & Internship Roadmap Session',
        description:
            'Final-year students and alumni share concrete strategies for tackling tech company interviews, resume building, and system design rounds.',
        category: 'Placement Prep',
        venue: 'Lecture Hall Complex (LHC) Hall 102',
        locationId: lhc.id,
        startTime: now.add(const Duration(days: 2, hours: 18)),
        endTime: now.add(const Duration(days: 2, hours: 20)),
        organizer: 'Training & Placement Cell',
        organizerId: insertedProfiles[7].id,
        isPublished: true,
        capacity: 250,
        registeredCount: 198,
        bannerColor: '0xFF059669', // Emerald
        createdAt: now,
      ),
      CampusEvent(
        title: 'Open Source Day: Git, GitHub & Global Contributions',
        description:
            'Interactive clinic guiding beginners through their first pull request on major open source repositories, bug triaging, and documentation writing.',
        category: 'Seminars',
        venue: 'Central Library Conference Hall',
        locationId: library.id,
        startTime: now.add(const Duration(days: 9, hours: 11)),
        endTime: now.add(const Duration(days: 9, hours: 13)),
        organizer: 'Open Source Coalition',
        organizerId: insertedProfiles[0].id,
        isPublished: true,
        capacity: 90,
        registeredCount: 45,
        bannerColor: '0xFF2563EB', // Blue
        createdAt: now,
      ),
      CampusEvent(
        title: 'Cultural Night: Symphony & Campus Beats',
        description:
            'Unwind after midterm exams with live acoustic bands, street dance battles, food trucks, and open mic performances by talented campus musicians.',
        category: 'Cultural',
        venue: 'Student Activity Center (SAC) Amphitheatre',
        locationId: sac.id,
        startTime: now.add(const Duration(days: 16, hours: 18)),
        endTime: now.add(const Duration(days: 16, hours: 22)),
        organizer: 'Student Cultural Committee',
        organizerId: insertedProfiles[9].id,
        isPublished: true,
        capacity: 600,
        registeredCount: 412,
        bannerColor: '0xFFDC2626', // Crimson
        createdAt: now,
      ),
    ];

    final insertedEvents = <CampusEvent>[];
    for (final e in events) {
      insertedEvents.add(await CampusEvent.db.insertRow(session, e));
    }

    session.log('Seeding project listings...');
    // 4 high-impact academic and showcase project listings
    final projects = [
      ProjectListing(
        title: 'EcoRoute: Campus Smart Shuttle & Transit Tracker',
        description:
            'Real-time GPS tracker and crowd-density forecasting app for campus transit buses. Looking for a frontend Flutter designer and a Go backend collaborator.',
        creatorId: insertedProfiles[0].id!,
        creatorName: insertedProfiles[0].name,
        creatorBranch: insertedProfiles[0].branch,
        techStack: ['Flutter', 'Serverpod', 'PostgreSQL', 'Google Maps API'],
        requiredSkills: ['Flutter', 'REST APIs', 'UI/UX Design', 'Dart'],
        category: 'Mobile Development',
        totalPositions: 3,
        openPositions: 2,
        status: 'open',
        createdAt: now.subtract(const Duration(days: 2)),
      ),
      ProjectListing(
        title: 'VisionPulse: Automated Exam Proctoring & Attention Analysis',
        description:
            'Edge-AI model detecting student distraction and eye-gaze tracking during online examinations using lightweight computer vision techniques.',
        creatorId: insertedProfiles[1].id!,
        creatorName: insertedProfiles[1].name,
        creatorBranch: insertedProfiles[1].branch,
        techStack: ['Python', 'OpenCV', 'PyTorch', 'FastAPI'],
        requiredSkills: [
          'Computer Vision',
          'PyTorch',
          'Data Preprocessing',
          'FastAPI',
        ],
        category: 'Artificial Intelligence',
        totalPositions: 2,
        openPositions: 1,
        status: 'open',
        createdAt: now.subtract(const Duration(days: 4)),
      ),
      ProjectListing(
        title: 'CampusShield: Decentralized Student Credential Verification',
        description:
            'Building a cryptographic digital wallet verifying student club achievements, academic degrees, and event attendance certificates securely.',
        creatorId: insertedProfiles[4].id!,
        creatorName: insertedProfiles[4].name,
        creatorBranch: insertedProfiles[4].branch,
        techStack: ['Solidity', 'Dart', 'Node.js', 'Cryptography'],
        requiredSkills: ['Cryptography', 'Dart', 'Security Auditing', 'Web3'],
        category: 'Cybersecurity',
        totalPositions: 3,
        openPositions: 3,
        status: 'open',
        createdAt: now.subtract(const Duration(days: 1)),
      ),
      ProjectListing(
        title: 'SmartHydro: IoT Greenhouse Irrigation Automation',
        description:
            'Sensor-driven hydroponic monitoring system using ESP32 microcontrollers, moisture probes, and cloud telemetry dashboard for sustainable urban farming.',
        creatorId: insertedProfiles[3].id!,
        creatorName: insertedProfiles[3].name,
        creatorBranch: insertedProfiles[3].branch,
        techStack: ['C++', 'MQTT', 'Node-RED', 'React Native'],
        requiredSkills: ['Embedded Systems', 'IoT', 'Microcontrollers', 'C++'],
        category: 'IoT',
        totalPositions: 2,
        openPositions: 1,
        status: 'open',
        createdAt: now.subtract(const Duration(days: 3)),
      ),
    ];

    final insertedProjects = <ProjectListing>[];
    for (final proj in projects) {
      insertedProjects.add(await ProjectListing.db.insertRow(session, proj));
    }

    session.log('Seeding sample study requests...');
    // Rohan -> Aarav
    await StudyRequest.db.insertRow(
      session,
      StudyRequest(
        senderId: insertedProfiles[2].id!,
        senderName: insertedProfiles[2].name,
        senderBranch: insertedProfiles[2].branch,
        senderAvatarUrl: insertedProfiles[2].avatarUrl,
        recipientId: insertedProfiles[0].id!,
        recipientName: insertedProfiles[0].name,
        message:
            'Hey Aarav! Saw you are studying Operating Systems and Cloud Architecture. I would love to team up for our weekly lab prep!',
        status: 'accepted',
        createdAt: now.subtract(const Duration(days: 1)),
        updatedAt: now.subtract(const Duration(hours: 12)),
      ),
    );

    // Kabir -> Aarav
    await StudyRequest.db.insertRow(
      session,
      StudyRequest(
        senderId: insertedProfiles[4].id!,
        senderName: insertedProfiles[4].name,
        senderBranch: insertedProfiles[4].branch,
        senderAvatarUrl: insertedProfiles[4].avatarUrl,
        recipientId: insertedProfiles[0].id!,
        recipientName: insertedProfiles[0].name,
        message:
            'Hi Aarav, looking for a study buddy for Computer Networks midterms. Let me know if you are free on weekends!',
        status: 'pending',
        createdAt: now.subtract(const Duration(hours: 4)),
        updatedAt: now.subtract(const Duration(hours: 4)),
      ),
    );

    // Sneha -> Priya
    await StudyRequest.db.insertRow(
      session,
      StudyRequest(
        senderId: insertedProfiles[5].id!,
        senderName: insertedProfiles[5].name,
        senderBranch: insertedProfiles[5].branch,
        senderAvatarUrl: insertedProfiles[5].avatarUrl,
        recipientId: insertedProfiles[1].id!,
        recipientName: insertedProfiles[1].name,
        message:
            'Hi Priya! Would love to collaborate on the Machine Learning assignments.',
        status: 'accepted',
        createdAt: now.subtract(const Duration(days: 2)),
        updatedAt: now.subtract(const Duration(days: 1)),
      ),
    );

    session.log('Seeding initial event registrations...');
    // Aarav registered for Flutter Bootcamp
    await EventRegistration.db.insertRow(
      session,
      EventRegistration(
        studentId: insertedProfiles[0].id!,
        studentName: insertedProfiles[0].name,
        studentEmail: insertedProfiles[0].email,
        eventId: insertedEvents[2].id!,
        eventTitle: insertedEvents[2].title,
        status: 'confirmed',
        createdAt: now.subtract(const Duration(days: 1)),
      ),
    );

    // Aarav registered for Placement Roadmap
    await EventRegistration.db.insertRow(
      session,
      EventRegistration(
        studentId: insertedProfiles[0].id!,
        studentName: insertedProfiles[0].name,
        studentEmail: insertedProfiles[0].email,
        eventId: insertedEvents[4].id!,
        eventTitle: insertedEvents[4].title,
        status: 'confirmed',
        createdAt: now.subtract(const Duration(hours: 8)),
      ),
    );

    session.log('Seeding collaboration requests...');
    // Rohan -> EcoRoute
    await CollaborationRequest.db.insertRow(
      session,
      CollaborationRequest(
        projectId: insertedProjects[0].id!,
        projectTitle: insertedProjects[0].title,
        projectCreatorId: insertedProjects[0].creatorId,
        studentId: insertedProfiles[2].id!,
        studentName: insertedProfiles[2].name,
        studentBranch: insertedProfiles[2].branch,
        studentSkills: insertedProfiles[2].skills,
        message:
            'I have built Flutter mobile apps before and would love to design the live transit UI for EcoRoute!',
        status: 'accepted',
        createdAt: now.subtract(const Duration(days: 1)),
      ),
    );

    // Sneha -> VisionPulse
    await CollaborationRequest.db.insertRow(
      session,
      CollaborationRequest(
        projectId: insertedProjects[1].id!,
        projectTitle: insertedProjects[1].title,
        projectCreatorId: insertedProjects[1].creatorId,
        studentId: insertedProfiles[5].id!,
        studentName: insertedProfiles[5].name,
        studentBranch: insertedProfiles[5].branch,
        studentSkills: insertedProfiles[5].skills,
        message:
            'I have experience in Python and data analytics. Can assist in dataset labeling and evaluation curves!',
        status: 'accepted',
        createdAt: now.subtract(const Duration(days: 2)),
      ),
    );

    // Devansh -> EcoRoute
    await CollaborationRequest.db.insertRow(
      session,
      CollaborationRequest(
        projectId: insertedProjects[0].id!,
        projectTitle: insertedProjects[0].title,
        projectCreatorId: insertedProjects[0].creatorId,
        studentId: insertedProfiles[6].id!,
        studentName: insertedProfiles[6].name,
        studentBranch: insertedProfiles[6].branch,
        studentSkills: insertedProfiles[6].skills,
        message:
            'I can help integrate hardware GPS tracking units on test campus shuttles!',
        status: 'pending',
        createdAt: now.subtract(const Duration(hours: 6)),
      ),
    );

    session.log('Seeding in-app activity notifications...');
    // Notifications for Aarav (id: 1)
    await ActivityNotification.db.insertRow(
      session,
      ActivityNotification(
        recipientId: insertedProfiles[0].id!,
        activityType: 'study_request',
        title: 'New Study Request 📚',
        message:
            'Kabir Mehta sent you a study buddy request for Computer Networks.',
        isRead: false,
        createdAt: now.subtract(const Duration(hours: 4)),
      ),
    );

    await ActivityNotification.db.insertRow(
      session,
      ActivityNotification(
        recipientId: insertedProfiles[0].id!,
        activityType: 'collab_request',
        title: 'New TeamUp Request 🚀',
        message: 'Devansh Nair wants to join "EcoRoute: Campus Smart Shuttle".',
        isRead: false,
        createdAt: now.subtract(const Duration(hours: 6)),
      ),
    );

    await ActivityNotification.db.insertRow(
      session,
      ActivityNotification(
        recipientId: insertedProfiles[0].id!,
        activityType: 'event_registered',
        title: 'Registration Confirmed! 🎟️',
        message:
            'You have a confirmed ticket for "Tech Placement & Internship Roadmap Session".',
        isRead: true,
        createdAt: now.subtract(const Duration(hours: 8)),
      ),
    );

    await ActivityNotification.db.insertRow(
      session,
      ActivityNotification(
        recipientId: insertedProfiles[0].id!,
        activityType: 'study_accepted',
        title: 'Study Request Accepted! 🎉',
        message:
            'Rohan Verma accepted your study connection request for Operating Systems.',
        isRead: true,
        createdAt: now.subtract(const Duration(hours: 12)),
      ),
    );

    session.log('Seeding initial weekly planner items...');
    final aaravId = insertedProfiles[0].id!;
    final initialPlannerItems = [
      PlannerItem(
        studentId: aaravId,
        title: 'Data Structures Study Session',
        category: 'study_session',
        dayOfWeek: 'Monday',
        timeSlot: '10:00 AM - 11:30 AM',
        location: 'Library 3rd Floor - Study Pod B',
        description: 'Review trees, graphs, and dynamic programming patterns.',
        isCompleted: true,
        createdAt: now.subtract(const Duration(days: 3)),
      ),
      PlannerItem(
        studentId: aaravId,
        title: 'AI & Machine Learning Workshop',
        category: 'event',
        dayOfWeek: 'Tuesday',
        timeSlot: '02:00 PM - 04:00 PM',
        location: 'Main Tech Auditorium',
        description: 'Hands-on session on neural networks and model deployment.',
        isCompleted: true,
        createdAt: now.subtract(const Duration(days: 2)),
      ),
      PlannerItem(
        studentId: aaravId,
        title: 'Team Project Architecture Meeting',
        category: 'project_meeting',
        dayOfWeek: 'Wednesday',
        timeSlot: '04:30 PM - 06:00 PM',
        location: 'Innovation Hub Room 204',
        description: 'Finalize API schema, Serverpod models, and task breakdown.',
        isCompleted: false,
        createdAt: now.subtract(const Duration(days: 1)),
      ),
      PlannerItem(
        studentId: aaravId,
        title: 'Campus Build Sprint Preparation',
        category: 'personal_task',
        dayOfWeek: 'Thursday',
        timeSlot: '05:00 PM - 07:00 PM',
        location: 'Computer Lab 3',
        description: 'Setup repository template, review requirements, and coordinate roles.',
        isCompleted: false,
        createdAt: now,
      ),
      PlannerItem(
        studentId: aaravId,
        title: 'Peer-Learning & Code Review Session',
        category: 'study_session',
        dayOfWeek: 'Friday',
        timeSlot: '03:00 PM - 04:30 PM',
        location: 'Student Lounge / Discord',
        description: 'Weekly peer review of Dart code and design principles.',
        isCompleted: false,
        createdAt: now,
      ),
    ];

    for (final item in initialPlannerItems) {
      await PlannerItem.db.insertRow(session, item);
    }

    session.log('Database seeding successfully completed!');
    return true;
  }

  /// Seeds realistic, verified IIT Delhi campus locations (Hauz Khas, New Delhi)
  static Future<List<CampusLocation>> _seedLocations(Session session) async {
    final existing = await CampusLocation.db.find(session);
    if (existing.isNotEmpty) return existing;

    final rawLocations = [
      CampusLocation(
        name: 'Central Library',
        category: 'Central Library',
        shortDescription:
            'Three-story modern library housing over 300,000 volumes, e-resource labs, and quiet study zones.',
        latitude: 28.54462,
        longitude: 77.19278,
        buildingBlock: 'Central Library Building',
        openingHours: '8:00 AM - 2:00 AM (Daily)',
        contactInfo: '+91-11-2659-1445',
        website: 'https://library.iitd.ac.in',
        accessibilityInfo:
            'Wheelchair ramp at front entrance, elevators to 2nd & 3rd floors',
        isVerified: true,
        tags: [
          'books',
          'study',
          'journals',
          'reading room',
          'quiet',
          'research'
        ],
      ),
      CampusLocation(
        name: 'Main Building (Block IV / Administrative Complex)',
        category: 'Main Building',
        shortDescription:
            "Central administrative headquarters, director's office, and main academic corridor at IIT Delhi.",
        latitude: 28.54504,
        longitude: 77.19262,
        buildingBlock: 'Block IV',
        openingHours: '9:00 AM - 5:30 PM (Mon-Fri)',
        contactInfo: '+91-11-2659-1000',
        website: 'https://home.iitd.ac.in',
        accessibilityInfo: 'North ramp access, Braille signage, lifts available',
        isVerified: true,
        tags: ['administration', 'director', 'dean', 'registrar', 'office'],
      ),
      CampusLocation(
        name: 'Lecture Hall Complex (LHC)',
        category: 'Lecture Hall Complex',
        shortDescription:
            'Multi-tiered lecture theatres equipped with smart projection systems for foundational institute courses.',
        latitude: 28.54635,
        longitude: 77.19140,
        buildingBlock: 'North Campus LHC',
        openingHours: '8:00 AM - 8:00 PM (Class hours)',
        contactInfo: '+91-11-2659-1700',
        accessibilityInfo:
            'All ground theatres step-free; elevators for upper floors',
        isVerified: true,
        tags: ['lectures', 'classes', 'theatres', 'academics', 'exam', 'lhc'],
      ),
      CampusLocation(
        name: 'Dogra Hall (Main Auditorium)',
        category: 'Auditorium & Seminar Halls',
        shortDescription:
            'Iconic hyperbolic paraboloid auditorium host to institute convocations, guest lectures, and cultural fests.',
        latitude: 28.54528,
        longitude: 77.19245,
        buildingBlock: 'Main Building Forecourt',
        openingHours: 'During scheduled events & symposiums',
        contactInfo: '+91-11-2659-1720',
        accessibilityInfo: 'Step-free access from the academic corridor',
        isVerified: true,
        tags: [
          'auditorium',
          'convocation',
          'cultural',
          'guest lecture',
          'talk',
          'dogra hall'
        ],
      ),
      CampusLocation(
        name: 'Bharti Building (School of IT & CSE)',
        category: 'Academic Blocks',
        shortDescription:
            'Hub for Computer Science & Engineering, telecommunication, and high-performance computing labs.',
        latitude: 28.54572,
        longitude: 77.19183,
        buildingBlock: 'Bharti School',
        openingHours: '8:30 AM - 7:00 PM (Labs 24/7)',
        contactInfo: '+91-11-2659-6000',
        website: 'https://cse.iitd.ac.in',
        accessibilityInfo: 'Elevator access on all wings, accessible restrooms',
        isVerified: true,
        tags: [
          'cse',
          'computer science',
          'it',
          'telecom',
          'coding lab',
          'bharti'
        ],
      ),
      CampusLocation(
        name: 'Block II & III (Mechanical & Chemical Engineering)',
        category: 'Academic Blocks',
        shortDescription:
            'Academic blocks housing mechanical, chemical, and materials science departments with experimental labs.',
        latitude: 28.54430,
        longitude: 77.19150,
        buildingBlock: 'South Academic Corridor',
        openingHours: '8:30 AM - 6:00 PM',
        accessibilityInfo: 'Ground level ramps and service elevators',
        isVerified: true,
        tags: [
          'mechanical',
          'chemical',
          'workshops',
          'labs',
          'block 2',
          'block 3'
        ],
      ),
      CampusLocation(
        name: 'Student Activity Center (SAC)',
        category: 'Other Facilities',
        shortDescription:
            'Epicenter of student clubs, board rooms, indoor sports, music room, and open-air amphitheatre.',
        latitude: 28.54695,
        longitude: 77.19062,
        buildingBlock: 'SAC Complex',
        openingHours: '6:00 AM - 11:00 PM',
        contactInfo: '+91-11-2659-6900',
        accessibilityInfo:
            'Full ground level access to open amphitheatre and courts',
        isVerified: true,
        tags: [
          'clubs',
          'music',
          'dance',
          'indoor sports',
          'student lounge',
          'sac'
        ],
      ),
      CampusLocation(
        name: 'Nescafe & Central Food Plaza',
        category: 'Cafeteria & Food Outlets',
        shortDescription:
            'Popular student gathering spot serving hot coffee, snacks, sandwiches, and refreshments.',
        latitude: 28.54480,
        longitude: 77.19325,
        buildingBlock: 'Library Lawns',
        openingHours: '8:00 AM - 1:00 AM',
        contactInfo: '+91-11-2659-1800',
        accessibilityInfo: 'Open outdoor seating with ground level access',
        isVerified: true,
        tags: ['coffee', 'snacks', 'food', 'maggi', 'canteen', 'nescafe'],
      ),
      CampusLocation(
        name: 'Staff Canteen / Main Cafeteria',
        category: 'Cafeteria & Food Outlets',
        shortDescription:
            'Multi-cuisine cafeteria offering affordable meals, thalis, and south Indian breakfast.',
        latitude: 28.54415,
        longitude: 77.19210,
        buildingBlock: 'Near Block IV',
        openingHours: '8:30 AM - 9:30 PM',
        contactInfo: '+91-11-2659-1810',
        accessibilityInfo: 'Wheelchair accessible ground floor dining hall',
        isVerified: true,
        tags: ['lunch', 'thali', 'breakfast', 'canteen', 'dining', 'cafeteria'],
      ),
      CampusLocation(
        name: 'Nilgiri Hostel',
        category: 'Student Hostels',
        shortDescription:
            'Senior undergraduate student residence hall with mess, common room, and reading hall.',
        latitude: 28.54755,
        longitude: 77.18950,
        buildingBlock: 'West Hostel Sector',
        openingHours: '24/7 for residents',
        contactInfo: '+91-11-2659-6801',
        accessibilityInfo: 'Ground floor rooms with ramp entrance',
        isVerified: true,
        tags: ['hostel', 'residence', 'boys hostel', 'nilgiri'],
      ),
      CampusLocation(
        name: 'Kumaon Hostel',
        category: 'Student Hostels',
        shortDescription:
            'Student residence hall featuring recreational facilities, courtyard, and solar-assisted heating.',
        latitude: 28.54812,
        longitude: 77.18885,
        buildingBlock: 'West Hostel Sector',
        openingHours: '24/7 for residents',
        contactInfo: '+91-11-2659-6802',
        accessibilityInfo: 'Ground floor accessible mess and common hall',
        isVerified: true,
        tags: ['hostel', 'residence', 'boys hostel', 'kumaon'],
      ),
      CampusLocation(
        name: 'Girnar Hostel',
        category: 'Student Hostels',
        shortDescription:
            'Modern multistory student hostel with study rooms, high-speed Wi-Fi, and mess hall.',
        latitude: 28.54780,
        longitude: 77.18780,
        buildingBlock: 'West Hostel Sector',
        openingHours: '24/7 for residents',
        contactInfo: '+91-11-2659-6803',
        accessibilityInfo: 'Elevator access to all residential wings',
        isVerified: true,
        tags: ['hostel', 'residence', 'girnar', 'new hostel'],
      ),
      CampusLocation(
        name: 'Kailash Hostel',
        category: 'Student Hostels',
        shortDescription:
            "Women's residence hall situated near the east campus with dedicated sports facilities.",
        latitude: 28.54350,
        longitude: 77.19455,
        buildingBlock: 'East Hostel Sector',
        openingHours: '24/7 for residents',
        contactInfo: '+91-11-2659-6810',
        accessibilityInfo: 'Ramp access at main gate and mess hall',
        isVerified: true,
        tags: ['hostel', 'girls hostel', 'residence', 'kailash'],
      ),
      CampusLocation(
        name: 'IIT Hospital & Emergency Unit',
        category: 'Other Facilities',
        shortDescription:
            'Full-service on-campus healthcare center with 24/7 emergency unit, pharmacy, and OPD.',
        latitude: 28.54390,
        longitude: 77.19520,
        buildingBlock: 'Hospital Complex',
        openingHours: '24/7 Emergency; OPD 8:30 AM - 6:00 PM',
        contactInfo: '+91-11-2659-1500',
        accessibilityInfo:
            'Wheelchair accessible ambulance bay, ramps, elevator',
        isVerified: true,
        tags: [
          'hospital',
          'health',
          'doctor',
          'medicine',
          'emergency',
          'opd',
          'medical'
        ],
      ),
      CampusLocation(
        name: 'Main Sports Grounds & Swimming Pool',
        category: 'Sports Facilities',
        shortDescription:
            'Cricket and football grounds, 400m synthetic track, Olympic-sized swimming pool, and tennis courts.',
        latitude: 28.54605,
        longitude: 77.18920,
        buildingBlock: 'Sports Complex',
        openingHours: '6:00 AM - 9:30 AM & 4:30 PM - 8:30 PM',
        contactInfo: '+91-11-2659-6950',
        accessibilityInfo:
            'Ground-level path connecting cricket pavilion and synthetic track',
        isVerified: true,
        tags: [
          'sports',
          'cricket',
          'football',
          'swimming',
          'tennis',
          'gym',
          'ground'
        ],
      ),
      CampusLocation(
        name: 'Gate 1 (Main Gate - Hauz Khas)',
        category: 'Campus Gates',
        shortDescription:
            'Primary institute entrance connecting IIT Delhi to Outer Ring Road and Hauz Khas Metro station.',
        latitude: 28.54305,
        longitude: 77.19355,
        buildingBlock: 'South Campus Perimeter',
        openingHours: '24/7 Security Checkpoint',
        contactInfo: '+91-11-2659-1001',
        accessibilityInfo: 'Wide pedestrian walkway and boom barrier vehicle lane',
        isVerified: true,
        tags: [
          'gate',
          'entry',
          'exit',
          'metro',
          'hauz khas',
          'auto',
          'gate 1'
        ],
      ),
      CampusLocation(
        name: 'Gate 2 (SDA Market Side)',
        category: 'Campus Gates',
        shortDescription:
            'Northern gate providing convenient access towards Safdarjung Development Area and market.',
        latitude: 28.54885,
        longitude: 77.19505,
        buildingBlock: 'North Campus Perimeter',
        openingHours: '6:00 AM - 11:00 PM',
        contactInfo: '+91-11-2659-1002',
        accessibilityInfo: 'Pedestrian entrance with paved pathway',
        isVerified: true,
        tags: ['gate', 'sda', 'market', 'entry', 'north gate', 'gate 2'],
      ),
      CampusLocation(
        name: 'Research & Innovation Park (Technopark)',
        category: 'Academic Blocks',
        shortDescription:
            'State-of-the-art incubation and deep tech research park housing startup incubators and industry labs.',
        latitude: 28.54225,
        longitude: 77.19150,
        buildingBlock: 'Research Park Complex',
        openingHours: '8:00 AM - 8:00 PM',
        contactInfo: '+91-11-2659-7000',
        website: 'https://technopark.iitd.ac.in',
        accessibilityInfo:
            'Full universal accessibility with automatic elevators and ramps',
        isVerified: true,
        tags: [
          'incubator',
          'startup',
          'research park',
          'technopark',
          'industry',
          'innovation'
        ],
      ),
      CampusLocation(
        name: 'Amphitheatre (SAC)',
        category: 'Auditorium & Seminar Halls',
        shortDescription:
            'Open-air cultural amphitheatre hosting drama, acoustic performances, and student council meets.',
        latitude: 28.54705,
        longitude: 77.19045,
        buildingBlock: 'SAC Complex',
        openingHours: 'Open access; events as scheduled',
        accessibilityInfo: 'Tiered seating with ramp access from courtyard',
        isVerified: true,
        tags: ['amphitheatre', 'cultural', 'open air', 'performances', 'stage'],
      ),
    ];

    final inserted = <CampusLocation>[];
    for (final loc in rawLocations) {
      inserted.add(await CampusLocation.db.insertRow(session, loc));
    }
    return inserted;
  }
}
