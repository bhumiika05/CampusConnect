import 'package:flutter/foundation.dart';
import 'package:campusconnect_client/campusconnect_client.dart';
import '../../client.dart';

class SessionService extends ChangeNotifier {
  static final SessionService instance = SessionService._();
  SessionService._();

  StudentProfile? _currentStudent;
  StudyPreferences? _currentPreferences;
  int _unreadNotifications = 0;
  bool _isLoading = false;

  StudentProfile? get currentStudent => _currentStudent;
  StudyPreferences? get currentPreferences => _currentPreferences;
  int get unreadNotifications => _unreadNotifications;
  bool get isLoading => _isLoading;
  bool get isAuthenticated => _currentStudent != null;

  /// Initialize session: seeds initial data on backend if empty, and loads the primary student
  Future<void> initSession() async {
    _isLoading = true;
    notifyListeners();

    try {
      // Trigger seed data check on server
      await client.seed.seedInitialData(force: false);

      // Load all students and default to the first student (Aarav Sharma)
      final all = await client.profile.getAllStudents();
      if (all.isNotEmpty) {
        _currentStudent = all.first;
        if (_currentStudent?.id != null) {
          _currentPreferences = await client.studyBuddy.getPreferences(
            _currentStudent!.id!,
          );
        }
      }
      await refreshUnreadCount();
    } catch (e) {
      debugPrint('Error initializing session: $e');
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  /// Switch the active student profile (great for judging & multi-user testing)
  Future<void> switchStudent(StudentProfile student) async {
    _isLoading = true;
    notifyListeners();

    _currentStudent = student;
    try {
      if (student.id != null) {
        _currentPreferences = await client.studyBuddy.getPreferences(
          student.id!,
        );
      }
      await refreshUnreadCount();
    } catch (e) {
      debugPrint('Error switching student: $e');
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  /// Log in with email
  Future<bool> loginWithEmail(String email) async {
    _isLoading = true;
    notifyListeners();

    try {
      final profile = await client.profile.getMyProfile(email);
      if (profile != null) {
        _currentStudent = profile;
        if (profile.id != null) {
          _currentPreferences = await client.studyBuddy.getPreferences(
            profile.id!,
          );
        }
        await refreshUnreadCount();
        _isLoading = false;
        notifyListeners();
        return true;
      }
    } catch (e) {
      debugPrint('Login error: $e');
    }

    _isLoading = false;
    notifyListeners();
    return false;
  }

  /// Register new student
  Future<StudentProfile?> registerStudent({
    required String name,
    required String email,
    required String branch,
    required String academicYear,
    required String bio,
    required List<String> skills,
    required List<String> interests,
  }) async {
    _isLoading = true;
    notifyListeners();

    try {
      final now = DateTime.now();
      final newProfile = StudentProfile(
        name: name,
        email: email,
        branch: branch,
        academicYear: academicYear,
        bio: bio,
        avatarUrl: null,
        skills: skills,
        interests: interests,
        isOrganizer: false,
        createdAt: now,
        updatedAt: now,
      );

      final created = await client.profile.createOrUpdateProfile(newProfile);
      _currentStudent = created;

      // Create default study preferences
      final defaultPrefs = StudyPreferences(
        studentId: created.id!,
        subjects: ['Operating Systems', 'Data Structures'],
        technicalInterests: skills,
        preferredTimings: ['Evening (6PM - 9PM)'],
        studyMode: 'Hybrid',
        learningGoals: ['Exam Prep', 'Skill Building'],
        skillLevel: 'Intermediate',
        updatedAt: now,
      );
      _currentPreferences = await client.studyBuddy.updatePreferences(
        defaultPrefs,
      );

      _isLoading = false;
      notifyListeners();
      return created;
    } catch (e) {
      debugPrint('Registration error: $e');
      _isLoading = false;
      notifyListeners();
      return null;
    }
  }

  /// Update current student profile
  Future<void> updateProfile(StudentProfile profile) async {
    try {
      final updated = await client.profile.createOrUpdateProfile(profile);
      _currentStudent = updated;
      notifyListeners();
    } catch (e) {
      debugPrint('Update profile error: $e');
    }
  }

  /// Update current study preferences
  Future<void> updatePreferences(StudyPreferences preferences) async {
    try {
      final updated = await client.studyBuddy.updatePreferences(preferences);
      _currentPreferences = updated;
      notifyListeners();
    } catch (e) {
      debugPrint('Update preferences error: $e');
    }
  }

  /// Refresh unread notification badge count
  Future<void> refreshUnreadCount() async {
    if (_currentStudent?.id == null) return;
    try {
      final activities = await client.activity.getMyActivities(
        _currentStudent!.id!,
      );
      _unreadNotifications = activities.where((a) => !a.isRead).length;
      notifyListeners();
    } catch (e) {
      debugPrint('Refresh unread count error: $e');
    }
  }

  /// Sign out
  void signOut() {
    _currentStudent = null;
    _currentPreferences = null;
    _unreadNotifications = 0;
    notifyListeners();
  }
}
