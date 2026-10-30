import 'package:flutter/material.dart';
import 'package:campusconnect_client/campusconnect_client.dart';
import '../../client.dart';
import '../../core/services/session_service.dart';
import '../../core/theme/app_colors.dart';
import '../../core/widgets/app_badge.dart';
import '../../core/widgets/state_views.dart';
import 'widgets/add_task_dialog.dart';

class CampusWeekScreen extends StatefulWidget {
  const CampusWeekScreen({super.key});

  @override
  State<CampusWeekScreen> createState() => _CampusWeekScreenState();
}

class _CampusWeekScreenState extends State<CampusWeekScreen> {
  WeeklyPlannerSummary? _summary;
  bool _isLoading = true;
  String? _error;
  String _selectedDay = 'Monday';

  static const List<String> _days = [
    'Monday',
    'Tuesday',
    'Wednesday',
    'Thursday',
    'Friday',
    'Saturday',
    'Sunday',
  ];

  @override
  void initState() {
    super.initState();
    _setInitialDay();
    _loadWeekPlan();
    SessionService.instance.addListener(_onSessionChange);
  }

  @override
  void dispose() {
    SessionService.instance.removeListener(_onSessionChange);
    super.dispose();
  }

  void _onSessionChange() {
    _loadWeekPlan();
  }

  void _setInitialDay() {
    final now = DateTime.now();
    switch (now.weekday) {
      case DateTime.monday:
        _selectedDay = 'Monday';
        break;
      case DateTime.tuesday:
        _selectedDay = 'Tuesday';
        break;
      case DateTime.wednesday:
        _selectedDay = 'Wednesday';
        break;
      case DateTime.thursday:
        _selectedDay = 'Thursday';
        break;
      case DateTime.friday:
        _selectedDay = 'Friday';
        break;
      case DateTime.saturday:
        _selectedDay = 'Saturday';
        break;
      case DateTime.sunday:
        _selectedDay = 'Sunday';
        break;
    }
  }

  Future<void> _loadWeekPlan() async {
    final student = SessionService.instance.currentStudent;
    if (student?.id == null) {
      if (mounted) setState(() => _isLoading = false);
      return;
    }

    try {
      final summary = await client.planner.getWeekPlan(student!.id!);
      if (mounted) {
        setState(() {
          _summary = summary;
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

  Future<void> _toggleItem(PlannerItem item) async {
    if (item.id == null) return;
    final student = SessionService.instance.currentStudent;
    if (student?.id == null) return;

    try {
      await client.planner.toggleItemCompleted(item.id!, student!.id!);
      _loadWeekPlan();
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error updating task: $e')),
        );
      }
    }
  }

  Future<void> _deleteItem(PlannerItem item) async {
    if (item.id == null) return;
    final student = SessionService.instance.currentStudent;
    if (student?.id == null) return;

    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Delete Activity?'),
        content: Text('Are you sure you want to remove "${item.title}"?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () => Navigator.pop(context, true),
            style: ElevatedButton.styleFrom(backgroundColor: AppColors.danger),
            child: const Text('Delete', style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );

    if (confirmed == true) {
      try {
        await client.planner.deletePlannerItem(item.id!, student!.id!);
        _loadWeekPlan();
      } catch (e) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Error deleting task: $e')),
          );
        }
      }
    }
  }

  Future<void> _addNewTask() async {
    final student = SessionService.instance.currentStudent;
    if (student?.id == null) return;

    final result = await AddTaskDialog.show(
      context,
      studentId: student!.id!,
      initialDay: _selectedDay,
    );

    if (result != null) {
      try {
        await client.planner.addPlannerItem(result);
        _loadWeekPlan();
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Activity added to your Campus Week! 🗓️'),
              backgroundColor: AppColors.success,
            ),
          );
        }
      } catch (e) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Failed to add task: $e')),
          );
        }
      }
    }
  }

  Future<void> _addRecommendedItem(PlannerItem rec) async {
    final student = SessionService.instance.currentStudent;
    if (student?.id == null) return;

    try {
      await client.planner.addPlannerItem(rec);
      _loadWeekPlan();
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Added "${rec.title}" to ${rec.dayOfWeek}! 🎯'),
            backgroundColor: AppColors.secondaryPurple,
          ),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to add recommendation: $e')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return const LoadingView(message: 'Loading your Campus Week...');
    }

    if (_error != null) {
      return ErrorView(
        message: 'Could not load planner.',
        onRetry: () {
          setState(() => _isLoading = true);
          _loadWeekPlan();
        },
      );
    }

    final summary = _summary;
    final allItems = summary?.items ?? [];
    final dayItems = allItems.where((i) => i.dayOfWeek == _selectedDay).toList();
    final total = summary?.totalTasks ?? 0;
    final completed = summary?.completedTasks ?? 0;
    final progress = total > 0 ? (completed / total) : 0.0;
    final recommendations = summary?.recommendedItems ?? [];

    return Scaffold(
      backgroundColor: AppColors.background,
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _addNewTask,
        backgroundColor: AppColors.secondaryPurple,
        foregroundColor: Colors.white,
        icon: const Icon(Icons.add_task_rounded),
        label: const Text('Add Activity'),
      ),
      body: RefreshIndicator(
        onRefresh: _loadWeekPlan,
        color: AppColors.secondaryPurple,
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Hero Week Progress Banner
              _buildProgressCard(total, completed, progress),
              const SizedBox(height: 16),

              // Horizontal Day Selector
              _buildDaySelector(allItems),
              const SizedBox(height: 16),

              // Section Header
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '$_selectedDay\'s Schedule',
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w800,
                      color: AppColors.textPrimary,
                    ),
                  ),
                  Text(
                    '${dayItems.length} planned',
                    style: const TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                      color: AppColors.textSecondary,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),

              // Activity Cards for selected day
              if (dayItems.isEmpty)
                _buildEmptyDayView()
              else
                ...dayItems.map(_buildActivityCard),

              const SizedBox(height: 24),

              // Smart Recommendations Section
              if (recommendations.isNotEmpty) ...[
                Row(
                  children: [
                    const Icon(
                      Icons.auto_awesome_rounded,
                      color: AppColors.secondaryPurple,
                      size: 20,
                    ),
                    const SizedBox(width: 8),
                    const Text(
                      'Smart Recommendations for Your Week',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                        color: AppColors.textPrimary,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 6),
                const Text(
                  'Tailored opportunities based on your subjects, available days, and campus events:',
                  style: TextStyle(
                    fontSize: 12,
                    color: AppColors.textSecondary,
                  ),
                ),
                const SizedBox(height: 12),
                ...recommendations.map(_buildRecommendationCard),
              ],

              const SizedBox(height: 60),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildProgressCard(int total, int completed, double progress) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        gradient: AppColors.heroGradient,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: AppColors.primaryNavy.withValues(alpha: 0.2),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: Colors.white.withValues(alpha: 0.15),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: const Icon(
                      Icons.calendar_month_rounded,
                      color: Colors.white,
                      size: 22,
                    ),
                  ),
                  const SizedBox(width: 12),
                  const Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'My Campus Week',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.w800,
                          letterSpacing: -0.3,
                        ),
                      ),
                      Text(
                        'One organized view for your campus life',
                        style: TextStyle(
                          color: Colors.white70,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.2),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  '$completed/$total Done',
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w700,
                    fontSize: 12,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: LinearProgressIndicator(
              value: progress,
              minHeight: 8,
              backgroundColor: Colors.white.withValues(alpha: 0.2),
              valueColor: const AlwaysStoppedAnimation<Color>(AppColors.accentCyan),
            ),
          ),
          const SizedBox(height: 10),
          Text(
            total == 0
                ? 'No activities scheduled yet. Tap "Add Activity" to plan your week!'
                : progress == 1.0
                    ? '🎉 Amazing! You have completed all planned activities this week!'
                    : '${(progress * 100).toInt()}% of your weekly goals accomplished. Keep it up!',
            style: const TextStyle(
              color: Colors.white70,
              fontSize: 12,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDaySelector(List<PlannerItem> allItems) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: _days.map((day) {
          final isSelected = day == _selectedDay;
          final count = allItems.where((i) => i.dayOfWeek == day).length;
          final shortDay = day.substring(0, 3);

          return Padding(
            padding: const EdgeInsets.only(right: 8),
            child: InkWell(
              onTap: () => setState(() => _selectedDay = day),
              borderRadius: BorderRadius.circular(16),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
                decoration: BoxDecoration(
                  color: isSelected ? AppColors.secondaryPurple : AppColors.surface,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(
                    color: isSelected ? AppColors.secondaryPurple : AppColors.border,
                  ),
                  boxShadow: isSelected
                      ? [
                          BoxShadow(
                            color: AppColors.secondaryPurple.withValues(alpha: 0.3),
                            blurRadius: 8,
                            offset: const Offset(0, 3),
                          ),
                        ]
                      : [],
                ),
                child: Column(
                  children: [
                    Text(
                      shortDay,
                      style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w700,
                        color: isSelected ? Colors.white : AppColors.textPrimary,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                      decoration: BoxDecoration(
                        color: isSelected
                            ? Colors.white.withValues(alpha: 0.25)
                            : AppColors.surfaceAlt,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(
                        '$count',
                        style: TextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.w700,
                          color: isSelected ? Colors.white : AppColors.textSecondary,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }

  Widget _buildActivityCard(PlannerItem item) {
    final isDone = item.isCompleted;
    final categoryDetails = _getCategoryDetails(item.category);

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: isDone ? AppColors.border : categoryDetails.color.withValues(alpha: 0.3),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.03),
            blurRadius: 6,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(14),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Checkbox
            Transform.scale(
              scale: 1.1,
              child: Checkbox(
                value: isDone,
                onChanged: (val) => _toggleItem(item),
                activeColor: AppColors.success,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(6),
                ),
              ),
            ),
            const SizedBox(width: 8),

            // Main Info
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                        decoration: BoxDecoration(
                          color: categoryDetails.color.withValues(alpha: 0.12),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(categoryDetails.icon, size: 12, color: categoryDetails.color),
                            const SizedBox(width: 4),
                            Text(
                              categoryDetails.label,
                              style: TextStyle(
                                fontSize: 11,
                                fontWeight: FontWeight.w700,
                                color: categoryDetails.color,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const Spacer(),
                      if (item.referenceId == null)
                        PopupMenuButton<String>(
                          padding: EdgeInsets.zero,
                          icon: const Icon(
                            Icons.more_vert_rounded,
                            size: 18,
                            color: AppColors.textMuted,
                          ),
                          onSelected: (val) {
                            if (val == 'delete') _deleteItem(item);
                          },
                          itemBuilder: (context) => [
                            const PopupMenuItem(
                              value: 'delete',
                              child: Row(
                                children: [
                                  Icon(Icons.delete_outline_rounded,
                                      color: AppColors.danger, size: 18),
                                  SizedBox(width: 8),
                                  Text('Delete',
                                      style: TextStyle(color: AppColors.danger)),
                                ],
                              ),
                            ),
                          ],
                        ),
                    ],
                  ),
                  const SizedBox(height: 6),
                  Text(
                    item.title,
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w700,
                      color: isDone ? AppColors.textMuted : AppColors.textPrimary,
                      decoration: isDone ? TextDecoration.lineThrough : null,
                    ),
                  ),
                  if (item.timeSlot.isNotEmpty) ...[
                    const SizedBox(height: 6),
                    Row(
                      children: [
                        const Icon(
                          Icons.access_time_rounded,
                          size: 14,
                          color: AppColors.textSecondary,
                        ),
                        const SizedBox(width: 6),
                        Text(
                          item.timeSlot,
                          style: const TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                            color: AppColors.textSecondary,
                          ),
                        ),
                      ],
                    ),
                  ],
                  if (item.location != null && item.location!.isNotEmpty) ...[
                    const SizedBox(height: 4),
                    Row(
                      children: [
                        const Icon(
                          Icons.location_on_outlined,
                          size: 14,
                          color: AppColors.textSecondary,
                        ),
                        const SizedBox(width: 6),
                        Expanded(
                          child: Text(
                            item.location!,
                            style: const TextStyle(
                              fontSize: 12,
                              color: AppColors.textSecondary,
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                  ],
                  if (item.description != null && item.description!.isNotEmpty) ...[
                    const SizedBox(height: 6),
                    Text(
                      item.description!,
                      style: const TextStyle(
                        fontSize: 12,
                        color: AppColors.textSecondary,
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                  ],
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRecommendationCard(PlannerItem rec) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.accentLightBlue.withValues(alpha: 0.3)),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: AppColors.accentSkyLight,
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Icon(
              Icons.lightbulb_outline_rounded,
              color: AppColors.accentLightBlue,
              size: 20,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    AppBadge(
                      text: rec.dayOfWeek,
                      backgroundColor: AppColors.secondaryPurpleSoft,
                      textColor: AppColors.secondaryPurple,
                    ),
                    const SizedBox(width: 6),
                    Text(
                      rec.timeSlot,
                      style: const TextStyle(
                        fontSize: 11,
                        color: AppColors.textSecondary,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 4),
                Text(
                  rec.title,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                    color: AppColors.textPrimary,
                  ),
                ),
                if (rec.location != null)
                  Text(
                    rec.location!,
                    style: const TextStyle(
                      fontSize: 11,
                      color: AppColors.textSecondary,
                    ),
                  ),
              ],
            ),
          ),
          const SizedBox(width: 8),
          ElevatedButton(
            onPressed: () => _addRecommendedItem(rec),
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.accentLightBlue,
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            child: const Text('Add', style: TextStyle(fontSize: 12)),
          ),
        ],
      ),
    );
  }

  Widget _buildEmptyDayView() {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 20),
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.border),
      ),
      child: Column(
        children: [
          Icon(
            Icons.event_available_rounded,
            size: 48,
            color: AppColors.textMuted.withValues(alpha: 0.5),
          ),
          const SizedBox(height: 12),
          Text(
            'No activities planned for $_selectedDay',
            style: const TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w700,
              color: AppColors.textPrimary,
            ),
          ),
          const SizedBox(height: 6),
          const Text(
            'Enjoy your free time, or tap "Add Activity" to plan a study session or task!',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 12,
              color: AppColors.textSecondary,
            ),
          ),
        ],
      ),
    );
  }

  _CategoryDetails _getCategoryDetails(String category) {
    switch (category) {
      case 'event':
        return _CategoryDetails(
          label: 'Campus Event',
          color: const Color(0xFFF97316),
          icon: Icons.confirmation_number_outlined,
        );
      case 'study_session':
        return _CategoryDetails(
          label: 'Study Session',
          color: AppColors.accentLightBlue,
          icon: Icons.menu_book_rounded,
        );
      case 'project_meeting':
        return _CategoryDetails(
          label: 'Team Meeting',
          color: AppColors.secondaryPurple,
          icon: Icons.rocket_launch_outlined,
        );
      case 'deadline':
        return _CategoryDetails(
          label: 'Deadline',
          color: AppColors.danger,
          icon: Icons.hourglass_top_rounded,
        );
      case 'personal_task':
      default:
        return _CategoryDetails(
          label: 'Personal Task',
          color: AppColors.primaryNavySoft,
          icon: Icons.check_circle_outline_rounded,
        );
    }
  }
}

class _CategoryDetails {
  final String label;
  final Color color;
  final IconData icon;

  _CategoryDetails({
    required this.label,
    required this.color,
    required this.icon,
  });
}
