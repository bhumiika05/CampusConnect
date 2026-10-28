import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:campusconnect_client/campusconnect_client.dart';
import '../../client.dart';
import '../../core/services/session_service.dart';
import '../../core/theme/app_colors.dart';
import '../../core/widgets/app_badge.dart';
import '../../core/widgets/app_button.dart';
import '../../core/widgets/state_views.dart';
import 'collab_requests_sheet.dart';
import 'create_project_dialog.dart';
import 'project_details_sheet.dart';

class TeamUpScreen extends StatefulWidget {
  const TeamUpScreen({super.key});

  @override
  State<TeamUpScreen> createState() => _TeamUpScreenState();
}

class _TeamUpScreenState extends State<TeamUpScreen> {
  List<ProjectListing> _projects = [];
  bool _isLoading = true;
  String? _error;

  String _searchQuery = '';
  String _selectedCategory = 'All';

  final _categories = [
    'All',
    'Artificial Intelligence',
    'Web Development',
    'Mobile Development',
    'Data Analytics',
    'Cybersecurity',
    'IoT',
    'Social Impact',
  ];

  @override
  void initState() {
    super.initState();
    _loadProjects();
    SessionService.instance.addListener(_onSessionChange);
  }

  @override
  void dispose() {
    SessionService.instance.removeListener(_onSessionChange);
    super.dispose();
  }

  void _onSessionChange() {
    _loadProjects();
  }

  Future<void> _loadProjects() async {
    setState(() => _isLoading = true);

    try {
      final list = await client.project.getProjects(
        category: _selectedCategory == 'All' ? null : _selectedCategory,
        search: _searchQuery.isEmpty ? null : _searchQuery,
      );

      if (mounted) {
        setState(() {
          _projects = list;
          _isLoading = false;
          _error = null;
        });
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          _error = e.toString();
          _isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: NestedScrollView(
        headerSliverBuilder: (context, innerBoxIsScrolled) => [
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(16, 12, 16, 8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      const Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'TeamUp Collaboration',
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w800,
                                color: AppColors.textPrimary,
                              ),
                            ),
                            SizedBox(height: 2),
                            Text(
                              'Find teammates for academic projects & technical competitions',
                              style: TextStyle(
                                fontSize: 12,
                                color: AppColors.textSecondary,
                              ),
                            ),
                          ],
                        ),
                      ),
                      // Manage Collaborations Action
                      IconButton(
                        icon: const Icon(
                          Icons.people_outline_rounded,
                          color: AppColors.secondaryPurple,
                        ),
                        tooltip: 'Manage Collaborations',
                        onPressed: () {
                          CollabRequestsSheet.show(
                            context,
                            onUpdated: _loadProjects,
                          );
                        },
                      ),
                      // Post Project Action
                      IconButton(
                        icon: const Icon(
                          Icons.add_circle_outline_rounded,
                          color: AppColors.primaryNavy,
                        ),
                        tooltip: 'Start a Project',
                        onPressed: () {
                          CreateProjectDialog.show(
                            context,
                            onCreated: _loadProjects,
                          );
                        },
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  // Search Bar
                  TextField(
                    onChanged: (v) {
                      _searchQuery = v;
                      _loadProjects();
                    },
                    style: const TextStyle(fontSize: 14),
                    decoration: InputDecoration(
                      hintText:
                          'Search by skill (Flutter, PyTorch...), project name...',
                      prefixIcon: const Icon(
                        Icons.search_rounded,
                        color: AppColors.textMuted,
                      ),
                      suffixIcon: _searchQuery.isNotEmpty
                          ? IconButton(
                              icon: const Icon(Icons.clear_rounded, size: 18),
                              onPressed: () {
                                setState(() => _searchQuery = '');
                                _loadProjects();
                              },
                            )
                          : null,
                    ),
                  ),
                  const SizedBox(height: 12),
                  // Category Filter Chips
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: _categories.map((cat) {
                        final isSelected = _selectedCategory == cat;
                        return Padding(
                          padding: const EdgeInsets.only(right: 8),
                          child: ChoiceChip(
                            label: Text(cat),
                            selected: isSelected,
                            selectedColor: AppColors.secondaryPurpleSoft,
                            onSelected: (val) {
                              if (val) {
                                setState(() => _selectedCategory = cat);
                                _loadProjects();
                              }
                            },
                          ),
                        );
                      }).toList(),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
        body: _isLoading
            ? const LoadingView(message: 'Loading open projects...')
            : _error != null
            ? ErrorView(message: _error!, onRetry: _loadProjects)
            : _projects.isEmpty
            ? const EmptyStateView(
                icon: Icons.rocket_outlined,
                title: 'No Projects Found',
                description:
                    'Be the first to post a collaboration opportunity or adjust your search filter!',
              )
            : RefreshIndicator(
                onRefresh: _loadProjects,
                color: AppColors.secondaryPurple,
                child: ListView.separated(
                  padding: const EdgeInsets.all(16),
                  itemCount: _projects.length,
                  separatorBuilder: (context, index) =>
                      const SizedBox(height: 14),
                  itemBuilder: (context, index) {
                    final proj = _projects[index];
                    return _buildProjectCard(proj);
                  },
                ),
              ),
      ),
    );
  }

  Widget _buildProjectCard(ProjectListing proj) {
    final isFull = proj.openPositions <= 0;

    return Card(
      child: InkWell(
        onTap: () {
          ProjectDetailsSheet.show(
            context,
            project: proj,
            onApplied: _loadProjects,
          );
        },
        borderRadius: BorderRadius.circular(16),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Top Row: Category, Open Positions Badge
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CategoryBadge(category: proj.category),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 3,
                    ),
                    decoration: BoxDecoration(
                      color: isFull
                          ? AppColors.dangerLight
                          : AppColors.successLight,
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: Text(
                      isFull ? 'FILLED' : '${proj.openPositions} SPOTS OPEN',
                      style: TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.w700,
                        color: isFull ? AppColors.danger : AppColors.success,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),

              // Title
              Text(
                proj.title,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                  color: AppColors.textPrimary,
                ),
              ),
              const SizedBox(height: 4),

              // Creator & date
              Text(
                'By ${proj.creatorName} (${proj.creatorBranch}) • ${DateFormat('MMM d').format(proj.createdAt)}',
                style: const TextStyle(
                  fontSize: 12,
                  color: AppColors.textSecondary,
                ),
              ),
              const SizedBox(height: 10),

              // Description
              Text(
                proj.description,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  fontSize: 13,
                  color: AppColors.textPrimary,
                  height: 1.3,
                ),
              ),
              const SizedBox(height: 12),

              // Required Skills
              if (proj.requiredSkills.isNotEmpty) ...[
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Needs: ',
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: AppColors.textSecondary,
                      ),
                    ),
                    Expanded(
                      child: Wrap(
                        spacing: 6,
                        runSpacing: 4,
                        children: proj.requiredSkills.map((s) {
                          return Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 7,
                              vertical: 2,
                            ),
                            decoration: BoxDecoration(
                              color: AppColors.surfaceAlt,
                              borderRadius: BorderRadius.circular(6),
                            ),
                            child: Text(
                              s,
                              style: const TextStyle(
                                fontSize: 11,
                                color: AppColors.textPrimary,
                              ),
                            ),
                          );
                        }).toList(),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 14),
              ],

              // Actions
              Row(
                children: [
                  Expanded(
                    child: AppButton(
                      label: 'View Details',
                      variant: AppButtonVariant.outline,
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      onPressed: () {
                        ProjectDetailsSheet.show(
                          context,
                          project: proj,
                          onApplied: _loadProjects,
                        );
                      },
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: AppButton(
                      label: isFull ? 'Positions Filled' : 'Request to Join',
                      icon: Icons.group_add_rounded,
                      variant: AppButtonVariant.gradient,
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      onPressed: isFull
                          ? null
                          : () {
                              ProjectDetailsSheet.show(
                                context,
                                project: proj,
                                onApplied: _loadProjects,
                              );
                            },
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
