import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:campusconnect_client/campusconnect_client.dart';
import '../../client.dart';
import '../../core/services/session_service.dart';
import '../../core/theme/app_colors.dart';
import '../../core/widgets/app_badge.dart';
import '../../core/widgets/app_button.dart';
import '../../core/widgets/state_views.dart';
import 'create_event_dialog.dart';
import 'event_details_screen.dart';
import 'my_registrations_sheet.dart';

class EventsScreen extends StatefulWidget {
  const EventsScreen({super.key});

  @override
  State<EventsScreen> createState() => _EventsScreenState();
}

class _EventsScreenState extends State<EventsScreen> {
  List<CampusEvent> _events = [];
  Set<int> _bookmarkedIds = {};
  Set<int> _registeredIds = {};
  bool _isLoading = true;
  String? _error;

  String _searchQuery = '';
  String _selectedCategory = 'All';

  final _categories = [
    'All',
    'Workshops',
    'Competitions',
    'Seminars',
    'Tech Showcase',
    'Placement Prep',
    'Cultural',
    'Society Recruitment',
  ];

  @override
  void initState() {
    super.initState();
    _loadEvents();
    SessionService.instance.addListener(_onSessionChange);
  }

  @override
  void dispose() {
    SessionService.instance.removeListener(_onSessionChange);
    super.dispose();
  }

  void _onSessionChange() {
    _loadEvents();
  }

  Future<void> _loadEvents() async {
    final studentId = SessionService.instance.currentStudent?.id;

    setState(() => _isLoading = true);

    try {
      final events = await client.event.getEvents(
        category: _selectedCategory == 'All' ? null : _selectedCategory,
        search: _searchQuery.isEmpty ? null : _searchQuery,
      );

      Set<int> bookmarks = {};
      Set<int> regs = {};

      if (studentId != null) {
        final bList = await client.event.getBookmarkedEventIds(studentId);
        bookmarks = bList.toSet();

        final rList = await client.eventRegistration.getMyRegistrations(
          studentId,
        );
        regs = rList.map((r) => r.eventId).toSet();
      }

      if (mounted) {
        setState(() {
          _events = events;
          _bookmarkedIds = bookmarks;
          _registeredIds = regs;
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

  Future<void> _toggleBookmark(int eventId) async {
    final studentId = SessionService.instance.currentStudent?.id;
    if (studentId == null) return;

    // Optimistic UI update
    setState(() {
      if (_bookmarkedIds.contains(eventId)) {
        _bookmarkedIds.remove(eventId);
      } else {
        _bookmarkedIds.add(eventId);
      }
    });

    try {
      await client.event.toggleBookmark(studentId, eventId);
    } catch (_) {
      // Revert if error
      _loadEvents();
    }
  }

  @override
  Widget build(BuildContext context) {
    final currentStudent = SessionService.instance.currentStudent;
    final isOrganizer = currentStudent?.isOrganizer ?? false;

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
                              'Campus Events',
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w800,
                                color: AppColors.textPrimary,
                              ),
                            ),
                            SizedBox(height: 2),
                            Text(
                              'Explore workshops, showcases & tech competitions',
                              style: TextStyle(
                                fontSize: 12,
                                color: AppColors.textSecondary,
                              ),
                            ),
                          ],
                        ),
                      ),
                      // My Tickets Button
                      IconButton(
                        icon: const Icon(
                          Icons.confirmation_number_outlined,
                          color: AppColors.secondaryPurple,
                        ),
                        tooltip: 'My Tickets',
                        onPressed: () {
                          MyRegistrationsSheet.show(
                            context,
                            onUpdated: _loadEvents,
                          );
                        },
                      ),
                      // Create Event Button (for organizers)
                      if (isOrganizer)
                        IconButton(
                          icon: const Icon(
                            Icons.add_circle_outline_rounded,
                            color: AppColors.primaryNavy,
                          ),
                          tooltip: 'Create Event (Organizer)',
                          onPressed: () {
                            CreateEventDialog.show(
                              context,
                              onCreated: _loadEvents,
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
                      _loadEvents();
                    },
                    style: const TextStyle(fontSize: 14),
                    decoration: InputDecoration(
                      hintText: 'Search events, topics, or venues...',
                      prefixIcon: const Icon(
                        Icons.search_rounded,
                        color: AppColors.textMuted,
                      ),
                      suffixIcon: _searchQuery.isNotEmpty
                          ? IconButton(
                              icon: const Icon(Icons.clear_rounded, size: 18),
                              onPressed: () {
                                setState(() => _searchQuery = '');
                                _loadEvents();
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
                                _loadEvents();
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
            ? const LoadingView(message: 'Loading campus events...')
            : _error != null
            ? ErrorView(message: _error!, onRetry: _loadEvents)
            : _events.isEmpty
            ? const EmptyStateView(
                icon: Icons.event_busy_rounded,
                title: 'No Events Found',
                description:
                    'No events match your current filter. Try resetting search.',
              )
            : RefreshIndicator(
                onRefresh: _loadEvents,
                color: AppColors.secondaryPurple,
                child: ListView.separated(
                  padding: const EdgeInsets.all(16),
                  itemCount: _events.length,
                  separatorBuilder: (context, index) =>
                      const SizedBox(height: 14),
                  itemBuilder: (context, index) {
                    final event = _events[index];
                    return _buildEventCard(event);
                  },
                ),
              ),
      ),
    );
  }

  Widget _buildEventCard(CampusEvent event) {
    final isBookmarked = _bookmarkedIds.contains(event.id);
    final isRegistered = _registeredIds.contains(event.id);
    final isFull =
        event.capacity > 0 && event.registeredCount >= event.capacity;
    final capacityRatio = event.capacity > 0
        ? (event.registeredCount / event.capacity).clamp(0.0, 1.0)
        : 0.0;

    return Card(
      child: InkWell(
        onTap: () async {
          await Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => EventDetailsScreen(event: event),
            ),
          );
          _loadEvents();
        },
        borderRadius: BorderRadius.circular(16),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Top Row: Category, Bookmark, Registered badge
              Row(
                children: [
                  CategoryBadge(category: event.category),
                  const Spacer(),
                  if (isRegistered)
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 3,
                      ),
                      margin: const EdgeInsets.only(right: 8),
                      decoration: BoxDecoration(
                        color: AppColors.successLight,
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: const Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            Icons.check_circle_rounded,
                            size: 12,
                            color: AppColors.success,
                          ),
                          SizedBox(width: 4),
                          Text(
                            'CONFIRMED',
                            style: TextStyle(
                              fontSize: 10,
                              fontWeight: FontWeight.w700,
                              color: AppColors.success,
                            ),
                          ),
                        ],
                      ),
                    ),
                  IconButton(
                    icon: Icon(
                      isBookmarked
                          ? Icons.bookmark_rounded
                          : Icons.bookmark_border_rounded,
                      color: isBookmarked
                          ? AppColors.secondaryPurple
                          : AppColors.textMuted,
                      size: 22,
                    ),
                    padding: EdgeInsets.zero,
                    constraints: const BoxConstraints(),
                    onPressed: () {
                      if (event.id != null) _toggleBookmark(event.id!);
                    },
                  ),
                ],
              ),
              const SizedBox(height: 12),

              // Title
              Text(
                event.title,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                  color: AppColors.textPrimary,
                ),
              ),
              const SizedBox(height: 6),

              // Short Description
              Text(
                event.description,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  fontSize: 13,
                  color: AppColors.textSecondary,
                  height: 1.3,
                ),
              ),
              const SizedBox(height: 14),

              // Date & Venue Details
              Row(
                children: [
                  const Icon(
                    Icons.access_time_rounded,
                    size: 14,
                    color: AppColors.textSecondary,
                  ),
                  const SizedBox(width: 5),
                  Text(
                    DateFormat('EEE, MMM d • h:mm a').format(event.startTime),
                    style: const TextStyle(
                      fontSize: 12,
                      color: AppColors.textSecondary,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(width: 14),
                  const Icon(
                    Icons.location_on_outlined,
                    size: 14,
                    color: AppColors.textSecondary,
                  ),
                  const SizedBox(width: 5),
                  Expanded(
                    child: Text(
                      event.venue,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontSize: 12,
                        color: AppColors.textSecondary,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 14),

              // Capacity Bar
              Row(
                children: [
                  Expanded(
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(4),
                      child: LinearProgressIndicator(
                        value: capacityRatio,
                        minHeight: 6,
                        backgroundColor: AppColors.surfaceAlt,
                        valueColor: AlwaysStoppedAnimation<Color>(
                          capacityRatio >= 0.9
                              ? AppColors.danger
                              : AppColors.secondaryPurple,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Text(
                    '${event.registeredCount}/${event.capacity} spots',
                    style: TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.w600,
                      color: isFull
                          ? AppColors.danger
                          : AppColors.textSecondary,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 14),

              // Action Buttons
              Row(
                children: [
                  Expanded(
                    child: AppButton(
                      label: 'View Details',
                      variant: AppButtonVariant.outline,
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      onPressed: () async {
                        await Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                EventDetailsScreen(event: event),
                          ),
                        );
                        _loadEvents();
                      },
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: isRegistered
                        ? AppButton(
                            label: 'View Ticket',
                            variant: AppButtonVariant.secondary,
                            icon: Icons.confirmation_number_rounded,
                            padding: const EdgeInsets.symmetric(vertical: 8),
                            onPressed: () {
                              MyRegistrationsSheet.show(
                                context,
                                onUpdated: _loadEvents,
                              );
                            },
                          )
                        : AppButton(
                            label: isFull ? 'Capacity Full' : 'Register',
                            variant: AppButtonVariant.gradient,
                            padding: const EdgeInsets.symmetric(vertical: 8),
                            onPressed: isFull
                                ? null
                                : () async {
                                    await Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            EventDetailsScreen(event: event),
                                      ),
                                    );
                                    _loadEvents();
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
