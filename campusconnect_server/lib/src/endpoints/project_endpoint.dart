import 'package:serverpod/serverpod.dart';
import '../generated/protocol.dart';

class ProjectEndpoint extends Endpoint {
  /// Create a new project listing.
  Future<ProjectListing> createProject(
    Session session,
    ProjectListing project,
    int creatorId,
  ) async {
    final creator = await StudentProfile.db.findById(session, creatorId);
    if (creator == null) {
      throw Exception('Creator student profile not found.');
    }

    final now = DateTime.now();
    final toInsert = project.copyWith(
      creatorId: creatorId,
      creatorName: creator.name,
      creatorBranch: creator.branch,
      openPositions: project.totalPositions,
      status: 'open',
      createdAt: now,
    );

    return await ProjectListing.db.insertRow(session, toInsert);
  }

  /// Discover open projects with optional category and search filters.
  Future<List<ProjectListing>> getProjects(
    Session session, {
    String? category,
    String? search,
  }) async {
    final projects = await ProjectListing.db.find(
      session,
      orderBy: (t) => t.createdAt,
    );
    projects.sort((a, b) => b.createdAt.compareTo(a.createdAt));

    return projects.where((p) {
      if (category != null && category.isNotEmpty && category != 'All') {
        if (p.category.toLowerCase() != category.toLowerCase()) return false;
      }
      if (search != null && search.trim().isNotEmpty) {
        final query = search.toLowerCase().trim();
        final matchTitle = p.title.toLowerCase().contains(query);
        final matchDesc = p.description.toLowerCase().contains(query);
        final matchSkills = p.requiredSkills.any(
          (s) => s.toLowerCase().contains(query),
        );
        final matchTech = p.techStack.any(
          (s) => s.toLowerCase().contains(query),
        );
        if (!matchTitle && !matchDesc && !matchSkills && !matchTech) {
          return false;
        }
      }
      return true;
    }).toList();
  }

  /// Get details of a single project listing.
  Future<ProjectListing?> getProjectById(Session session, int id) async {
    return await ProjectListing.db.findById(session, id);
  }

  /// List projects created by a specific student.
  Future<List<ProjectListing>> getMyProjects(
    Session session,
    int creatorId,
  ) async {
    final projects = await ProjectListing.db.find(
      session,
      where: (t) => t.creatorId.equals(creatorId),
      orderBy: (t) => t.createdAt,
    );
    projects.sort((a, b) => b.createdAt.compareTo(a.createdAt));
    return projects;
  }

  /// Update the status of a project (e.g. open, in_progress, completed).
  Future<ProjectListing> updateProjectStatus(
    Session session,
    int projectId,
    int creatorId,
    String status,
  ) async {
    final project = await ProjectListing.db.findById(session, projectId);
    if (project == null) {
      throw Exception('Project not found.');
    }

    if (project.creatorId != creatorId) {
      throw Exception(
        'Only the project creator can update the project status.',
      );
    }

    final updated = project.copyWith(status: status);
    return await ProjectListing.db.updateRow(session, updated);
  }
}
