import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:campusconnect_client/campusconnect_client.dart';
import '../../client.dart';
import '../../core/services/session_service.dart';
import '../../core/theme/app_colors.dart';
import '../../core/widgets/app_badge.dart';
import '../../core/widgets/app_button.dart';
import '../map/campus_map_screen.dart';

class EventDetailsScreen extends StatefulWidget {
  final CampusEvent event;

  const EventDetailsScreen({super.key, required this.event});

  @override
  State<EventDetailsScreen> createState() => _EventDetailsScreenState();
}

class _EventDetailsScreenState extends State<EventDetailsScreen> {
  late CampusEvent _event;
  bool _isRegistered = false;
  bool _isBookmarked = false;
  bool _isLoading = false;
  String? _actionError;

  @override
  void initState() {
    super.initState();
    _event = widget.event;
    _checkStatus();
  }

  Future<void> _checkStatus() async {
    final studentId = SessionService.instance.currentStudent?.id;
    if (studentId == null || _event.id == null) return;

    try {
      final regs = await client.eventRegistration.getMyRegistrations(studentId);
      final isReg = regs.any((r) => r.eventId == _event.id);

      final bookmarks = await client.event.getBookmarkedEventIds(studentId);
      final isBook = bookmarks.contains(_event.id!);

      if (mounted) {
        setState(() {
          _isRegistered = isReg;
          _isBookmarked = isBook;
        });
      }
    } catch (_) {}
  }

  Future<void> _toggleRegister() async {
    final studentId = SessionService.instance.currentStudent?.id;
    if (studentId == null || _event.id == null) return;

    setState(() {
      _isLoading = true;
      _actionError = null;
    });

    try {
      if (_isRegistered) {
        await client.eventRegistration.cancelRegistration(
          studentId,
          _event.id!,
        );
        final updated = await client.event.getEventById(_event.id!);
        if (mounted) {
          setState(() {
            _isRegistered = false;
            if (updated != null) _event = updated;
            _isLoading = false;
          });
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Registration cancelled.'),
              behavior: SnackBarBehavior.floating,
            ),
          );
        }
      } else {
        await client.eventRegistration.registerForEvent(studentId, _event.id!);
        final updated = await client.event.getEventById(_event.id!);
        await SessionService.instance.refreshUnreadCount();
        if (mounted) {
          setState(() {
            _isRegistered = true;
            if (updated != null) _event = updated;
            _isLoading = false;
          });
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text(
                'Registration confirmed! Ticket saved to your account. 🎟️',
              ),
              backgroundColor: AppColors.success,
              behavior: SnackBarBehavior.floating,
            ),
          );
        }
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          _actionError = e.toString().replaceAll('Exception: ', '');
          _isLoading = false;
        });
      }
    }
  }

  Future<void> _toggleBookmark() async {
    final studentId = SessionService.instance.currentStudent?.id;
    if (studentId == null || _event.id == null) return;

    try {
      final status = await client.event.toggleBookmark(studentId, _event.id!);
      if (mounted) setState(() => _isBookmarked = status);
    } catch (_) {}
  }

  @override
  Widget build(BuildContext context) {
    final isFull =
        _event.capacity > 0 && _event.registeredCount >= _event.capacity;
    final capacityRatio = _event.capacity > 0
        ? (_event.registeredCount / _event.capacity).clamp(0.0, 1.0)
        : 0.0;

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Text('Event Details'),
        actions: [
          IconButton(
            icon: Icon(
              _isBookmarked
                  ? Icons.bookmark_rounded
                  : Icons.bookmark_border_rounded,
              color: _isBookmarked
                  ? AppColors.secondaryPurple
                  : AppColors.textSecondary,
            ),
            tooltip: _isBookmarked ? 'Remove Bookmark' : 'Bookmark Event',
            onPressed: _toggleBookmark,
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Category & Status
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CategoryBadge(category: _event.category),
                if (_isRegistered)
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: AppColors.successLight,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: const Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          Icons.check_circle_rounded,
                          size: 14,
                          color: AppColors.success,
                        ),
                        SizedBox(width: 4),
                        Text(
                          'REGISTERED',
                          style: TextStyle(
                            fontSize: 11,
                            fontWeight: FontWeight.w700,
                            color: AppColors.success,
                          ),
                        ),
                      ],
                    ),
                  )
                else if (isFull)
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: AppColors.dangerLight,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: const Text(
                      'CAPACITY FULL',
                      style: TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.w700,
                        color: AppColors.danger,
                      ),
                    ),
                  ),
              ],
            ),
            const SizedBox(height: 14),

            // Event Title
            Text(
              _event.title,
              style: const TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.w800,
                color: AppColors.textPrimary,
                height: 1.25,
              ),
            ),
            const SizedBox(height: 16),

            // Organizer Card
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: AppColors.surface,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: AppColors.border),
              ),
              child: Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: const BoxDecoration(
                      color: AppColors.secondaryPurpleSoft,
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.corporate_fare_rounded,
                      size: 18,
                      color: AppColors.secondaryPurple,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'ORGANIZED BY',
                          style: TextStyle(
                            fontSize: 10,
                            fontWeight: FontWeight.w700,
                            color: AppColors.textMuted,
                          ),
                        ),
                        Text(
                          _event.organizer,
                          style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w700,
                            color: AppColors.textPrimary,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),

            // Schedule & Venue Card
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    Row(
                      children: [
                        const Icon(
                          Icons.calendar_today_rounded,
                          size: 18,
                          color: AppColors.secondaryPurple,
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                DateFormat(
                                  'EEEE, MMMM d, yyyy',
                                ).format(_event.startTime),
                                style: const TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w700,
                                  color: AppColors.textPrimary,
                                ),
                              ),
                              Text(
                                '${DateFormat('h:mm a').format(_event.startTime)} - ${DateFormat('h:mm a').format(_event.endTime)}',
                                style: const TextStyle(
                                  fontSize: 12,
                                  color: AppColors.textSecondary,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const Divider(height: 24, color: AppColors.border),
                    Row(
                      children: [
                        const Icon(
                          Icons.location_on_rounded,
                          size: 18,
                          color: AppColors.accentLightBlue,
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                'Venue',
                                style: TextStyle(
                                  fontSize: 11,
                                  fontWeight: FontWeight.w600,
                                  color: AppColors.textMuted,
                                ),
                              ),
                              Text(
                                _event.venue,
                                style: const TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w700,
                                  color: AppColors.textPrimary,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(width: 8),
                        InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => CampusMapScreen(
                                  initialLocationId: _event.locationId,
                                  initialSearchQuery: _event.venue,
                                ),
                              ),
                            );
                          },
                          borderRadius: BorderRadius.circular(10),
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 10,
                              vertical: 6,
                            ),
                            decoration: BoxDecoration(
                              color: AppColors.secondaryPurpleSoft,
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(
                                color: AppColors.secondaryPurple.withValues(
                                  alpha: 0.25,
                                ),
                              ),
                            ),
                            child: const Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(
                                  Icons.map_rounded,
                                  size: 14,
                                  color: AppColors.secondaryPurple,
                                ),
                                SizedBox(width: 4),
                                Text(
                                  'View on Map',
                                  style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w700,
                                    color: AppColors.secondaryPurple,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),

            // Capacity & Registration Stats
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Registration Status',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w700,
                            color: AppColors.textPrimary,
                          ),
                        ),
                        Text(
                          '${_event.registeredCount} / ${_event.capacity} Registered',
                          style: const TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w600,
                            color: AppColors.secondaryPurple,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(6),
                      child: LinearProgressIndicator(
                        value: capacityRatio,
                        minHeight: 8,
                        backgroundColor: AppColors.surfaceAlt,
                        valueColor: AlwaysStoppedAnimation<Color>(
                          capacityRatio >= 0.9
                              ? AppColors.danger
                              : AppColors.secondaryPurple,
                        ),
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      isFull
                          ? 'All slots filled'
                          : '${_event.capacity - _event.registeredCount} spots remaining',
                      style: TextStyle(
                        fontSize: 11,
                        color: isFull
                            ? AppColors.danger
                            : AppColors.textSecondary,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),

            // Description
            const Text(
              'About This Event',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w700,
                color: AppColors.textPrimary,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              _event.description,
              style: const TextStyle(
                fontSize: 14,
                color: AppColors.textPrimary,
                height: 1.5,
              ),
            ),
            const SizedBox(height: 24),

            if (_actionError != null) ...[
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: AppColors.dangerLight,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Text(
                  _actionError!,
                  style: const TextStyle(color: AppColors.danger, fontSize: 13),
                ),
              ),
              const SizedBox(height: 16),
            ],

            // Action Button
            if (_isRegistered)
              AppButton(
                label: 'Cancel My Registration',
                variant: AppButtonVariant.danger,
                width: double.infinity,
                isLoading: _isLoading,
                onPressed: _toggleRegister,
              )
            else
              AppButton(
                label: isFull ? 'Event Full' : 'Register for Event',
                variant: AppButtonVariant.gradient,
                width: double.infinity,
                isLoading: _isLoading,
                onPressed: isFull ? null : _toggleRegister,
              ),
          ],
        ),
      ),
    );
  }
}
