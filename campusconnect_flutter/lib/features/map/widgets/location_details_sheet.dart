import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:campusconnect_client/campusconnect_client.dart';
import '../../../client.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/widgets/app_badge.dart';
import '../../events/event_details_screen.dart';

class LocationDetailsSheet extends StatefulWidget {
  final CampusLocation location;
  final VoidCallback? onFocusOnMap;

  const LocationDetailsSheet({
    super.key,
    required this.location,
    this.onFocusOnMap,
  });

  static Future<void> show(
    BuildContext context, {
    required CampusLocation location,
    VoidCallback? onFocusOnMap,
  }) {
    return showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => LocationDetailsSheet(
        location: location,
        onFocusOnMap: onFocusOnMap,
      ),
    );
  }

  @override
  State<LocationDetailsSheet> createState() => _LocationDetailsSheetState();
}

class _LocationDetailsSheetState extends State<LocationDetailsSheet> {
  List<CampusEvent> _events = [];
  bool _isLoadingEvents = false;
  String? _eventsError;

  @override
  void initState() {
    super.initState();
    _loadEvents();
  }

  Future<void> _loadEvents() async {
    if (widget.location.id == null) return;
    setState(() {
      _isLoadingEvents = true;
      _eventsError = null;
    });

    try {
      final list = await client.location.getEventsForLocation(
        widget.location.id!,
      );
      if (mounted) {
        setState(() {
          _events = list;
          _isLoadingEvents = false;
        });
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          _eventsError = e.toString();
          _isLoadingEvents = false;
        });
      }
    }
  }

  IconData _getCategoryIcon(String category) {
    final lower = category.toLowerCase();
    if (lower.contains('library')) return Icons.local_library_rounded;
    if (lower.contains('main') || lower.contains('admin')) {
      return Icons.account_balance_rounded;
    }
    if (lower.contains('lecture') || lower.contains('hall')) {
      return Icons.co_present_rounded;
    }
    if (lower.contains('academic')) return Icons.school_rounded;
    if (lower.contains('auditorium')) return Icons.theater_comedy_rounded;
    if (lower.contains('food') || lower.contains('cafe')) {
      return Icons.restaurant_rounded;
    }
    if (lower.contains('hostel')) return Icons.hotel_rounded;
    if (lower.contains('sports')) return Icons.sports_basketball_rounded;
    if (lower.contains('gate')) return Icons.meeting_room_rounded;
    return Icons.place_rounded;
  }

  Color _getCategoryColor(String category) {
    final lower = category.toLowerCase();
    if (lower.contains('library')) return AppColors.accentLightBlue;
    if (lower.contains('main') || lower.contains('admin')) {
      return AppColors.primaryNavy;
    }
    if (lower.contains('lecture') || lower.contains('academic')) {
      return AppColors.secondaryPurple;
    }
    if (lower.contains('auditorium')) return const Color(0xFFE11D48);
    if (lower.contains('food') || lower.contains('cafe')) {
      return const Color(0xFF059669);
    }
    if (lower.contains('hostel')) return const Color(0xFFD97706);
    if (lower.contains('sports')) return const Color(0xFF2563EB);
    if (lower.contains('gate')) return const Color(0xFF0D9488);
    return AppColors.secondaryPurple;
  }

  @override
  Widget build(BuildContext context) {
    final loc = widget.location;
    final catColor = _getCategoryColor(loc.category);
    final catIcon = _getCategoryIcon(loc.category);

    return DraggableScrollableSheet(
      initialChildSize: 0.55,
      minChildSize: 0.35,
      maxChildSize: 0.90,
      builder: (context, scrollController) {
        return Container(
          decoration: const BoxDecoration(
            color: AppColors.surface,
            borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
            boxShadow: [
              BoxShadow(
                color: Colors.black26,
                blurRadius: 20,
                offset: Offset(0, -4),
              ),
            ],
          ),
          child: Column(
            children: [
              // Drag Handle
              Center(
                child: Container(
                  margin: const EdgeInsets.only(top: 12, bottom: 8),
                  width: 44,
                  height: 5,
                  decoration: BoxDecoration(
                    color: AppColors.border,
                    borderRadius: BorderRadius.circular(3),
                  ),
                ),
              ),

              // Scrollable Content
              Expanded(
                child: ListView(
                  controller: scrollController,
                  padding: const EdgeInsets.fromLTRB(20, 8, 20, 24),
                  children: [
                    // Header Row: Category Badge & Verification Status
                    Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 10,
                            vertical: 5,
                          ),
                          decoration: BoxDecoration(
                            color: catColor.withValues(alpha: 0.12),
                            borderRadius: BorderRadius.circular(16),
                            border: Border.all(
                              color: catColor.withValues(alpha: 0.25),
                            ),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(catIcon, size: 14, color: catColor),
                              const SizedBox(width: 5),
                              Text(
                                loc.category,
                                style: TextStyle(
                                  fontSize: 11,
                                  fontWeight: FontWeight.w700,
                                  color: catColor,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(width: 8),
                        if (loc.isVerified)
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 9,
                              vertical: 5,
                            ),
                            decoration: BoxDecoration(
                              color: AppColors.successLight,
                              borderRadius: BorderRadius.circular(16),
                              border: Border.all(
                                color: AppColors.success.withValues(alpha: 0.3),
                              ),
                            ),
                            child: const Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(
                                  Icons.verified_rounded,
                                  size: 13,
                                  color: AppColors.success,
                                ),
                                SizedBox(width: 4),
                                Text(
                                  'Verified Landmark',
                                  style: TextStyle(
                                    fontSize: 11,
                                    fontWeight: FontWeight.w700,
                                    color: AppColors.success,
                                  ),
                                ),
                              ],
                            ),
                          )
                        else
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 9,
                              vertical: 5,
                            ),
                            decoration: BoxDecoration(
                              color: AppColors.warningLight,
                              borderRadius: BorderRadius.circular(16),
                              border: Border.all(
                                color: AppColors.warning.withValues(alpha: 0.3),
                              ),
                            ),
                            child: const Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(
                                  Icons.help_outline_rounded,
                                  size: 13,
                                  color: AppColors.warning,
                                ),
                                SizedBox(width: 4),
                                Text(
                                  'Pending Verification',
                                  style: TextStyle(
                                    fontSize: 11,
                                    fontWeight: FontWeight.w700,
                                    color: AppColors.warning,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        const Spacer(),
                        IconButton(
                          icon: const Icon(Icons.close_rounded, size: 20),
                          color: AppColors.textSecondary,
                          onPressed: () => Navigator.pop(context),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),

                    // Title
                    Text(
                      loc.name,
                      style: const TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.w800,
                        color: AppColors.textPrimary,
                        letterSpacing: -0.3,
                      ),
                    ),

                    // Building / Block
                    if (loc.buildingBlock != null &&
                        loc.buildingBlock!.isNotEmpty) ...[
                      const SizedBox(height: 4),
                      Row(
                        children: [
                          const Icon(
                            Icons.business_rounded,
                            size: 14,
                            color: AppColors.textMuted,
                          ),
                          const SizedBox(width: 5),
                          Text(
                            loc.buildingBlock!,
                            style: const TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.w600,
                              color: AppColors.textSecondary,
                            ),
                          ),
                        ],
                      ),
                    ],

                    const SizedBox(height: 14),

                    // Short Description
                    Text(
                      loc.shortDescription,
                      style: const TextStyle(
                        fontSize: 14,
                        color: AppColors.textSecondary,
                        height: 1.45,
                      ),
                    ),

                    const SizedBox(height: 16),
                    const Divider(color: AppColors.border),
                    const SizedBox(height: 12),

                    // Key Information Cards
                    if (loc.openingHours != null &&
                        loc.openingHours!.isNotEmpty)
                      _buildInfoRow(
                        icon: Icons.access_time_rounded,
                        title: 'Hours of Operation',
                        value: loc.openingHours!,
                        color: AppColors.secondaryPurple,
                      ),

                    if (loc.accessibilityInfo != null &&
                        loc.accessibilityInfo!.isNotEmpty)
                      _buildInfoRow(
                        icon: Icons.accessible_rounded,
                        title: 'Campus Accessibility',
                        value: loc.accessibilityInfo!,
                        color: AppColors.accentLightBlue,
                      ),

                    if (loc.contactInfo != null && loc.contactInfo!.isNotEmpty)
                      _buildInfoRow(
                        icon: Icons.phone_outlined,
                        title: 'Contact Phone',
                        value: loc.contactInfo!,
                        color: const Color(0xFF059669),
                        trailing: IconButton(
                          icon: const Icon(Icons.copy_rounded, size: 16),
                          tooltip: 'Copy Phone',
                          color: AppColors.textSecondary,
                          onPressed: () {
                            Clipboard.setData(
                              ClipboardData(text: loc.contactInfo!),
                            );
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('Phone number copied!'),
                                behavior: SnackBarBehavior.floating,
                              ),
                            );
                          },
                        ),
                      ),

                    if (loc.website != null && loc.website!.isNotEmpty)
                      _buildInfoRow(
                        icon: Icons.language_rounded,
                        title: 'Official Portal',
                        value: loc.website!,
                        color: const Color(0xFF4338CA),
                        trailing: IconButton(
                          icon: const Icon(
                            Icons.open_in_new_rounded,
                            size: 16,
                          ),
                          tooltip: 'Copy Link',
                          color: AppColors.textSecondary,
                          onPressed: () {
                            Clipboard.setData(ClipboardData(text: loc.website!));
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('Website URL copied!'),
                                behavior: SnackBarBehavior.floating,
                              ),
                            );
                          },
                        ),
                      ),

                    // Coordinates & Location details
                    _buildInfoRow(
                      icon: Icons.my_location_rounded,
                      title: 'IIT Delhi Hauz Khas GPS Coordinates',
                      value:
                          '${loc.latitude.toStringAsFixed(5)}° N, ${loc.longitude.toStringAsFixed(5)}° E',
                      color: AppColors.primaryNavy,
                      trailing: IconButton(
                        icon: const Icon(Icons.copy_rounded, size: 16),
                        tooltip: 'Copy Coordinates',
                        color: AppColors.textSecondary,
                        onPressed: () {
                          Clipboard.setData(
                            ClipboardData(
                              text: '${loc.latitude}, ${loc.longitude}',
                            ),
                          );
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('GPS coordinates copied!'),
                              behavior: SnackBarBehavior.floating,
                            ),
                          );
                        },
                      ),
                    ),

                    // Tags
                    if (loc.tags != null && loc.tags!.isNotEmpty) ...[
                      const SizedBox(height: 12),
                      Wrap(
                        spacing: 6,
                        runSpacing: 6,
                        children: loc.tags!.map((tag) {
                          return Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 8,
                              vertical: 3,
                            ),
                            decoration: BoxDecoration(
                              color: AppColors.surfaceAlt,
                              borderRadius: BorderRadius.circular(8),
                              border: Border.all(color: AppColors.border),
                            ),
                            child: Text(
                              '#$tag',
                              style: const TextStyle(
                                fontSize: 11,
                                color: AppColors.textSecondary,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          );
                        }).toList(),
                      ),
                    ],

                    const SizedBox(height: 20),
                    const Divider(color: AppColors.border),
                    const SizedBox(height: 12),

                    // Upcoming Events Section
                    Row(
                      children: [
                        const Icon(
                          Icons.event_available_rounded,
                          size: 18,
                          color: AppColors.secondaryPurple,
                        ),
                        const SizedBox(width: 8),
                        const Text(
                          'Events at this Venue',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w800,
                            color: AppColors.textPrimary,
                          ),
                        ),
                        const Spacer(),
                        if (_isLoadingEvents)
                          const SizedBox(
                            width: 14,
                            height: 14,
                            child: CircularProgressIndicator(strokeWidth: 2),
                          )
                        else
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 8,
                              vertical: 2,
                            ),
                            decoration: BoxDecoration(
                              color: AppColors.secondaryPurpleSoft,
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Text(
                              '${_events.length} upcoming',
                              style: const TextStyle(
                                fontSize: 11,
                                fontWeight: FontWeight.w700,
                                color: AppColors.secondaryPurple,
                              ),
                            ),
                          ),
                      ],
                    ),
                    const SizedBox(height: 12),

                    if (_eventsError != null)
                      Text(
                        'Could not load events: $_eventsError',
                        style: const TextStyle(
                          fontSize: 12,
                          color: AppColors.danger,
                        ),
                      )
                    else if (!_isLoadingEvents && _events.isEmpty)
                      Container(
                        padding: const EdgeInsets.all(14),
                        decoration: BoxDecoration(
                          color: AppColors.surfaceAlt,
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(color: AppColors.border),
                        ),
                        child: const Row(
                          children: [
                            Icon(
                              Icons.info_outline_rounded,
                              size: 16,
                              color: AppColors.textMuted,
                            ),
                            SizedBox(width: 8),
                            Expanded(
                              child: Text(
                                'No scheduled events at this location right now.',
                                style: TextStyle(
                                  fontSize: 12,
                                  color: AppColors.textSecondary,
                                ),
                              ),
                            ),
                          ],
                        ),
                      )
                    else
                      ..._events.map((e) => _buildVenueEventCard(e)),

                    const SizedBox(height: 24),

                    // Action Button
                    Row(
                      children: [
                        if (widget.onFocusOnMap != null)
                          Expanded(
                            child: OutlinedButton.icon(
                              onPressed: () {
                                Navigator.pop(context);
                                widget.onFocusOnMap!();
                              },
                              icon: const Icon(
                                Icons.center_focus_strong_rounded,
                                size: 18,
                              ),
                              label: const Text('Center on Map'),
                              style: OutlinedButton.styleFrom(
                                padding: const EdgeInsets.symmetric(
                                  vertical: 14,
                                ),
                                side: const BorderSide(
                                  color: AppColors.secondaryPurple,
                                ),
                                foregroundColor: AppColors.secondaryPurple,
                                shape: RoundedRectangle6.create(),
                              ),
                            ),
                          ),
                        if (widget.onFocusOnMap != null)
                          const SizedBox(width: 12),
                        Expanded(
                          child: ElevatedButton.icon(
                            onPressed: () {
                              Clipboard.setData(
                                ClipboardData(
                                  text:
                                      '${loc.name}, IIT Delhi (Lat: ${loc.latitude}, Lng: ${loc.longitude})',
                                ),
                              );
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text(
                                    'Campus location link copied to clipboard! 📋',
                                  ),
                                  backgroundColor: AppColors.primaryNavy,
                                  behavior: SnackBarBehavior.floating,
                                ),
                              );
                            },
                            icon: const Icon(Icons.share_rounded, size: 18),
                            label: const Text('Share Location'),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppColors.primaryNavy,
                              foregroundColor: Colors.white,
                              padding: const EdgeInsets.symmetric(vertical: 14),
                              shape: RoundedRectangle6.create(),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildInfoRow({
    required IconData icon,
    required String title,
    required String value,
    required Color color,
    Widget? trailing,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: AppColors.surfaceAlt,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: AppColors.border),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.all(6),
              decoration: BoxDecoration(
                color: color.withValues(alpha: 0.12),
                shape: BoxShape.circle,
              ),
              child: Icon(icon, size: 16, color: color),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.w700,
                      color: AppColors.textMuted,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    value,
                    style: const TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                      color: AppColors.textPrimary,
                    ),
                  ),
                ],
              ),
            ),
            ?trailing,
          ],
        ),
      ),
    );
  }

  Widget _buildVenueEventCard(CampusEvent event) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.border),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.03),
            blurRadius: 6,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              CategoryBadge(category: event.category),
              const Spacer(),
              Text(
                DateFormat('EEE, MMM d • h:mm a').format(event.startTime),
                style: const TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.w600,
                  color: AppColors.textMuted,
                ),
              ),
            ],
          ),
          const SizedBox(height: 6),
          Text(
            event.title,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w700,
              color: AppColors.textPrimary,
            ),
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              Text(
                '${event.registeredCount} / ${event.capacity} registered',
                style: const TextStyle(
                  fontSize: 11,
                  color: AppColors.textSecondary,
                ),
              ),
              const Spacer(),
              InkWell(
                onTap: () {
                  Navigator.pop(context);
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => EventDetailsScreen(event: event),
                    ),
                  );
                },
                child: const Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      'View Details',
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w700,
                        color: AppColors.secondaryPurple,
                      ),
                    ),
                    Icon(
                      Icons.arrow_forward_ios_rounded,
                      size: 11,
                      color: AppColors.secondaryPurple,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class RoundedRectangle6 {
  static RoundedRectangleBorder create() {
    return RoundedRectangleBorder(borderRadius: BorderRadius.circular(12));
  }
}
