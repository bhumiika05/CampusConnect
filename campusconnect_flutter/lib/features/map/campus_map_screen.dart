import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:campusconnect_client/campusconnect_client.dart';
import '../../client.dart';
import '../../core/theme/app_colors.dart';
import 'widgets/location_details_sheet.dart';

class CampusMapScreen extends StatefulWidget {
  final int? initialLocationId;
  final String? initialSearchQuery;
  final String? initialCategory;

  const CampusMapScreen({
    super.key,
    this.initialLocationId,
    this.initialSearchQuery,
    this.initialCategory,
  });

  @override
  State<CampusMapScreen> createState() => _CampusMapScreenState();
}

class _CampusMapScreenState extends State<CampusMapScreen>
    with SingleTickerProviderStateMixin {
  // IIT Delhi, Hauz Khas verified campus center coordinates
  static const LatLng _iitDelhiCenter = LatLng(28.5450, 77.1926);
  static const double _defaultZoom = 16.0;

  final MapController _mapController = MapController();
  final TextEditingController _searchController = TextEditingController();
  final FocusNode _searchFocusNode = FocusNode();

  List<CampusLocation> _allLocations = [];
  List<CampusLocation> _filteredLocations = [];
  Map<int, List<CampusEvent>> _locationEventsMap = {};
  CampusLocation? _selectedLocation;

  String _selectedCategory = 'All';
  bool _showEventsOnly = false;
  bool _isLoading = true;
  String? _errorMessage;
  bool _showSearchResultsOverlay = false;

  final List<String> _categories = [
    'All',
    'Academics',
    'Library',
    'Auditorium',
    'Food',
    'Hostels',
    'Sports',
    'Administration',
    'Gates',
  ];

  @override
  void initState() {
    super.initState();
    if (widget.initialSearchQuery != null) {
      _searchController.text = widget.initialSearchQuery!;
    }
    if (widget.initialCategory != null) {
      _selectedCategory = widget.initialCategory!;
    }
    _searchController.addListener(_onSearchChanged);
    _loadLocations();
  }

  @override
  void dispose() {
    _searchController.removeListener(_onSearchChanged);
    _searchController.dispose();
    _searchFocusNode.dispose();
    _mapController.dispose();
    super.dispose();
  }

  Future<void> _loadLocations() async {
    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    try {
      final list = await client.location.getLocations();
      final events = await client.event.getEvents();

      // Map events to location IDs
      final locEvents = <int, List<CampusEvent>>{};
      for (final ev in events) {
        if (ev.locationId != null) {
          locEvents.putIfAbsent(ev.locationId!, () => []).add(ev);
        }
      }

      if (mounted) {
        setState(() {
          _allLocations = list;
          _locationEventsMap = locEvents;
          _applyFilters();
          _isLoading = false;
        });

        // If an initial location ID was passed, focus on it
        if (widget.initialLocationId != null) {
          _focusLocationById(widget.initialLocationId!);
        } else if (widget.initialSearchQuery != null &&
            widget.initialSearchQuery!.isNotEmpty) {
          _findAndFocusByQuery(widget.initialSearchQuery!);
        }
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          _errorMessage = e.toString();
          _isLoading = false;
        });
      }
    }
  }

  void _onSearchChanged() {
    setState(() {
      _showSearchResultsOverlay = _searchController.text.trim().isNotEmpty &&
          _searchFocusNode.hasFocus;
      _applyFilters();
    });
  }

  void _applyFilters() {
    final query = _searchController.text.trim().toLowerCase();

    _filteredLocations = _allLocations.where((loc) {
      // Category filter
      if (_selectedCategory != 'All') {
        final cat = loc.category.toLowerCase();
        final selected = _selectedCategory.toLowerCase();
        bool matchesCat = false;

        if (selected == 'academics') {
          matchesCat = cat.contains('academic') ||
              cat.contains('lecture') ||
              cat.contains('building');
        } else if (selected == 'library') {
          matchesCat = cat.contains('library');
        } else if (selected == 'auditorium') {
          matchesCat = cat.contains('auditorium') || cat.contains('seminar');
        } else if (selected == 'food') {
          matchesCat = cat.contains('cafeteria') || cat.contains('food');
        } else if (selected == 'hostels') {
          matchesCat = cat.contains('hostel');
        } else if (selected == 'sports') {
          matchesCat = cat.contains('sports');
        } else if (selected == 'administration') {
          matchesCat = cat.contains('main') || cat.contains('admin');
        } else if (selected == 'gates') {
          matchesCat = cat.contains('gate');
        } else {
          matchesCat = cat.contains(selected);
        }

        if (!matchesCat) return false;
      }

      // Show events only filter
      if (_showEventsOnly) {
        final hasEvents = _locationEventsMap[loc.id]?.isNotEmpty ?? false;
        if (!hasEvents) return false;
      }

      // Search query filter
      if (query.isNotEmpty) {
        final nameMatch = loc.name.toLowerCase().contains(query);
        final descMatch = loc.shortDescription.toLowerCase().contains(query);
        final blockMatch =
            loc.buildingBlock?.toLowerCase().contains(query) ?? false;
        final tagsMatch =
            loc.tags?.any((t) => t.toLowerCase().contains(query)) ?? false;

        return nameMatch || descMatch || blockMatch || tagsMatch;
      }

      return true;
    }).toList();
  }

  void _focusLocationById(int id) {
    try {
      final loc = _allLocations.firstWhere((l) => l.id == id);
      _selectAndCenterLocation(loc);
    } catch (_) {}
  }

  void _findAndFocusByQuery(String query) {
    final q = query.toLowerCase();
    try {
      final match = _allLocations.firstWhere(
        (l) =>
            l.name.toLowerCase().contains(q) ||
            (l.buildingBlock != null &&
                l.buildingBlock!.toLowerCase().contains(q)),
      );
      _selectAndCenterLocation(match);
    } catch (_) {}
  }

  void _selectAndCenterLocation(CampusLocation loc) {
    setState(() {
      _selectedLocation = loc;
      _showSearchResultsOverlay = false;
    });
    _searchFocusNode.unfocus();

    final target = LatLng(loc.latitude, loc.longitude);
    _mapController.move(target, 17.5);

    // Show details sheet
    LocationDetailsSheet.show(
      context,
      location: loc,
      onFocusOnMap: () {
        _mapController.move(target, 18.0);
      },
    );
  }

  void _resetMapCenter() {
    _mapController.move(_iitDelhiCenter, _defaultZoom);
    setState(() {
      _selectedLocation = null;
    });
  }

  void _zoomIn() {
    final current = _mapController.camera.zoom;
    _mapController.move(_mapController.camera.center, current + 0.75);
  }

  void _zoomOut() {
    final current = _mapController.camera.zoom;
    _mapController.move(_mapController.camera.center, current - 0.75);
  }

  IconData _getMarkerIcon(String category) {
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

  Color _getMarkerColor(String category) {
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
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        titleSpacing: 0,
        title: const Row(
          children: [
            Icon(
              Icons.explore_rounded,
              size: 22,
              color: AppColors.secondaryPurple,
            ),
            SizedBox(width: 8),
            Text(
              'IIT Delhi Campus Map',
              style: TextStyle(
                fontWeight: FontWeight.w800,
                fontSize: 17,
                color: AppColors.textPrimary,
              ),
            ),
          ],
        ),
        actions: [
          // Verified badge indicator
          Container(
            margin: const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
            decoration: BoxDecoration(
              color: AppColors.successLight,
              borderRadius: BorderRadius.circular(14),
              border: Border.all(
                color: AppColors.success.withValues(alpha: 0.3),
              ),
            ),
            child: const Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.verified_rounded, size: 13, color: AppColors.success),
                SizedBox(width: 4),
                Text(
                  'Hauz Khas, New Delhi',
                  style: TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.w700,
                    color: AppColors.success,
                  ),
                ),
              ],
            ),
          ),
          IconButton(
            icon: const Icon(Icons.refresh_rounded),
            tooltip: 'Refresh Locations',
            onPressed: _loadLocations,
          ),
        ],
      ),
      body: Stack(
        children: [
          // 1. The Interactive FlutterMap Layer
          FlutterMap(
            mapController: _mapController,
            options: MapOptions(
              initialCenter: _iitDelhiCenter,
              initialZoom: _defaultZoom,
              minZoom: 13.0,
              maxZoom: 18.5,
              onTap: (tapPosition, point) {
                if (_searchFocusNode.hasFocus) {
                  _searchFocusNode.unfocus();
                }
                setState(() {
                  _showSearchResultsOverlay = false;
                });
              },
            ),
            children: [
              TileLayer(
                urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                userAgentPackageName: 'com.campusconnect.app',
                maxZoom: 19,
              ),
              RichAttributionWidget(
                attributions: [
                  TextSourceAttribution(
                    '© OpenStreetMap contributors',
                    onTap: () {},
                  ),
                ],
              ),
              MarkerLayer(
                markers: _filteredLocations.map((loc) {
                  final isSelected = _selectedLocation?.id == loc.id;
                  final hasEvents =
                      _locationEventsMap[loc.id]?.isNotEmpty ?? false;
                  final markerColor = _getMarkerColor(loc.category);
                  final markerIcon = _getMarkerIcon(loc.category);

                  return Marker(
                    point: LatLng(loc.latitude, loc.longitude),
                    width: isSelected ? 52 : 42,
                    height: isSelected ? 52 : 42,
                    child: GestureDetector(
                      onTap: () => _selectAndCenterLocation(loc),
                      child: Stack(
                        clipBehavior: Clip.none,
                        alignment: Alignment.center,
                        children: [
                          // Outer glow or shadow
                          AnimatedContainer(
                            duration: const Duration(milliseconds: 250),
                            width: isSelected ? 50 : 38,
                            height: isSelected ? 50 : 38,
                            decoration: BoxDecoration(
                              color: markerColor,
                              shape: BoxShape.circle,
                              border: Border.all(
                                color: Colors.white,
                                width: isSelected ? 3.5 : 2.5,
                              ),
                              boxShadow: [
                                BoxShadow(
                                  color: markerColor.withValues(
                                    alpha: isSelected ? 0.6 : 0.35,
                                  ),
                                  blurRadius: isSelected ? 12 : 6,
                                  offset: const Offset(0, 3),
                                ),
                              ],
                            ),
                            child: Icon(
                              markerIcon,
                              color: Colors.white,
                              size: isSelected ? 24 : 18,
                            ),
                          ),
                          // Event badge indicator if events happen here
                          if (hasEvents)
                            Positioned(
                              top: -4,
                              right: -4,
                              child: Container(
                                padding: const EdgeInsets.all(3),
                                decoration: const BoxDecoration(
                                  color: Color(0xFFE11D48),
                                  shape: BoxShape.circle,
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black26,
                                      blurRadius: 4,
                                    ),
                                  ],
                                ),
                                child: const Icon(
                                  Icons.celebration_rounded,
                                  color: Colors.white,
                                  size: 11,
                                ),
                              ),
                            ),
                        ],
                      ),
                    ),
                  );
                }).toList(),
              ),
            ],
          ),

          // 2. Top Floating Controls (Search Bar + Category Filters)
          Positioned(
            top: 12,
            left: 12,
            right: 12,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Search TextField
                Container(
                  decoration: BoxDecoration(
                    color: AppColors.surface,
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(color: AppColors.border),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.12),
                        blurRadius: 16,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: TextField(
                    controller: _searchController,
                    focusNode: _searchFocusNode,
                    decoration: InputDecoration(
                      hintText:
                          'Search IIT Delhi buildings, labs, hostels, LHC...',
                      hintStyle: const TextStyle(
                        fontSize: 13,
                        color: AppColors.textMuted,
                      ),
                      prefixIcon: const Icon(
                        Icons.search_rounded,
                        color: AppColors.secondaryPurple,
                        size: 20,
                      ),
                      suffixIcon: _searchController.text.isNotEmpty
                          ? IconButton(
                              icon: const Icon(Icons.clear_rounded, size: 18),
                              onPressed: () {
                                _searchController.clear();
                                setState(() {
                                  _showSearchResultsOverlay = false;
                                  _applyFilters();
                                });
                              },
                            )
                          : null,
                      border: InputBorder.none,
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 14,
                        vertical: 12,
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 8),

                // Category Filter Chips Carousel
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      // Active Events Spotlight Pill
                      FilterChip(
                        selected: _showEventsOnly,
                        label: const Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              Icons.celebration_rounded,
                              size: 14,
                              color: Color(0xFFE11D48),
                            ),
                            SizedBox(width: 4),
                            Text(
                              'Events Only',
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ],
                        ),
                        selectedColor: const Color(0xFFFEE2E2),
                        checkmarkColor: const Color(0xFFE11D48),
                        backgroundColor: AppColors.surface,
                        elevation: 2,
                        shadowColor: Colors.black12,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                          side: BorderSide(
                            color: _showEventsOnly
                                ? const Color(0xFFE11D48)
                                : AppColors.border,
                          ),
                        ),
                        onSelected: (selected) {
                          setState(() {
                            _showEventsOnly = selected;
                            _applyFilters();
                          });
                        },
                      ),
                      const SizedBox(width: 8),
                      // Standard Categories
                      ..._categories.map((cat) {
                        final isSelected = _selectedCategory == cat;
                        return Padding(
                          padding: const EdgeInsets.only(right: 6),
                          child: FilterChip(
                            selected: isSelected,
                            label: Text(
                              cat,
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: isSelected
                                    ? FontWeight.w700
                                    : FontWeight.w600,
                                color: isSelected
                                    ? Colors.white
                                    : AppColors.textPrimary,
                              ),
                            ),
                            selectedColor: AppColors.secondaryPurple,
                            backgroundColor: AppColors.surface,
                            elevation: isSelected ? 4 : 2,
                            shadowColor: Colors.black12,
                            showCheckmark: false,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                              side: BorderSide(
                                color: isSelected
                                    ? AppColors.secondaryPurple
                                    : AppColors.border,
                              ),
                            ),
                            onSelected: (selected) {
                              setState(() {
                                _selectedCategory = cat;
                                _applyFilters();
                              });
                            },
                          ),
                        );
                      }),
                    ],
                  ),
                ),
              ],
            ),
          ),

          // 3. Floating Search Suggestions Dropdown Overlay
          if (_showSearchResultsOverlay && _filteredLocations.isNotEmpty)
            Positioned(
              top: 72,
              left: 12,
              right: 12,
              child: Material(
                elevation: 8,
                borderRadius: BorderRadius.circular(16),
                color: AppColors.surface,
                child: Container(
                  constraints: const BoxConstraints(maxHeight: 280),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(color: AppColors.border),
                  ),
                  child: ListView.separated(
                    shrinkWrap: true,
                    padding: const EdgeInsets.symmetric(vertical: 6),
                    itemCount: _filteredLocations.length.clamp(0, 8),
                    separatorBuilder: (context, i) =>
                        const Divider(height: 1, color: AppColors.border),
                    itemBuilder: (context, i) {
                      final loc = _filteredLocations[i];
                      final catIcon = _getMarkerIcon(loc.category);
                      final catColor = _getMarkerColor(loc.category);

                      return ListTile(
                        dense: true,
                        leading: Container(
                          padding: const EdgeInsets.all(6),
                          decoration: BoxDecoration(
                            color: catColor.withValues(alpha: 0.12),
                            shape: BoxShape.circle,
                          ),
                          child: Icon(catIcon, color: catColor, size: 16),
                        ),
                        title: Text(
                          loc.name,
                          style: const TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w700,
                            color: AppColors.textPrimary,
                          ),
                        ),
                        subtitle: Text(
                          loc.buildingBlock ?? loc.category,
                          style: const TextStyle(
                            fontSize: 11,
                            color: AppColors.textSecondary,
                          ),
                        ),
                        trailing: const Icon(
                          Icons.arrow_forward_ios_rounded,
                          size: 12,
                          color: AppColors.textMuted,
                        ),
                        onTap: () => _selectAndCenterLocation(loc),
                      );
                    },
                  ),
                ),
              ),
            ),

          // 4. Floating Action Controls (Right side: Zoom +, Zoom -, Center IIT Delhi)
          Positioned(
            right: 16,
            bottom: _selectedLocation != null ? 140 : 28,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                _buildMapFloatingButton(
                  icon: Icons.add_rounded,
                  tooltip: 'Zoom In',
                  onTap: _zoomIn,
                ),
                const SizedBox(height: 8),
                _buildMapFloatingButton(
                  icon: Icons.remove_rounded,
                  tooltip: 'Zoom Out',
                  onTap: _zoomOut,
                ),
                const SizedBox(height: 12),
                _buildMapFloatingButton(
                  icon: Icons.my_location_rounded,
                  tooltip: 'Center IIT Delhi (Hauz Khas)',
                  highlighted: true,
                  onTap: _resetMapCenter,
                ),
              ],
            ),
          ),

          // 5. Selected Location Mini Preview Card at Bottom
          if (_selectedLocation != null)
            Positioned(
              left: 16,
              right: 16,
              bottom: 20,
              child: _buildLocationPreviewCard(_selectedLocation!),
            ),

          // 6. Loading Indicator
          if (_isLoading)
            Positioned.fill(
              child: Container(
                color: Colors.white.withValues(alpha: 0.65),
                child: const Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      CircularProgressIndicator(
                        color: AppColors.secondaryPurple,
                      ),
                      SizedBox(height: 12),
                      Text(
                        'Loading verified IIT Delhi landmarks...',
                        style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w600,
                          color: AppColors.primaryNavy,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),

          // 7. Error Banner
          if (_errorMessage != null)
            Positioned(
              top: 140,
              left: 20,
              right: 20,
              child: Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: AppColors.dangerLight,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: AppColors.danger.withValues(alpha: 0.4),
                  ),
                ),
                child: Row(
                  children: [
                    const Icon(Icons.error_outline_rounded,
                        color: AppColors.danger, size: 20),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        'Could not load campus map data: $_errorMessage',
                        style: const TextStyle(
                          fontSize: 12,
                          color: AppColors.danger,
                        ),
                      ),
                    ),
                    TextButton(
                      onPressed: _loadLocations,
                      child: const Text('Retry'),
                    ),
                  ],
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildMapFloatingButton({
    required IconData icon,
    required String tooltip,
    required VoidCallback onTap,
    bool highlighted = false,
  }) {
    return Material(
      color: highlighted ? AppColors.secondaryPurple : AppColors.surface,
      elevation: 4,
      borderRadius: BorderRadius.circular(14),
      shadowColor: Colors.black26,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(14),
        child: Container(
          width: 44,
          height: 44,
          alignment: Alignment.center,
          child: Icon(
            icon,
            size: 22,
            color: highlighted ? Colors.white : AppColors.primaryNavy,
          ),
        ),
      ),
    );
  }

  Widget _buildLocationPreviewCard(CampusLocation loc) {
    final catColor = _getMarkerColor(loc.category);
    final catIcon = _getMarkerIcon(loc.category);
    final eventsCount = _locationEventsMap[loc.id]?.length ?? 0;

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: AppColors.border),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.15),
            blurRadius: 18,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: catColor.withValues(alpha: 0.12),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(catIcon, color: catColor, size: 20),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      loc.name,
                      style: const TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w800,
                        color: AppColors.textPrimary,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 2),
                    Text(
                      loc.buildingBlock ?? loc.category,
                      style: const TextStyle(
                        fontSize: 12,
                        color: AppColors.textSecondary,
                      ),
                    ),
                  ],
                ),
              ),
              IconButton(
                icon: const Icon(Icons.close_rounded, size: 18),
                color: AppColors.textMuted,
                onPressed: () {
                  setState(() => _selectedLocation = null);
                },
              ),
            ],
          ),
          const SizedBox(height: 10),
          Row(
            children: [
              if (loc.isVerified)
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                  decoration: BoxDecoration(
                    color: AppColors.successLight,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: const Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.verified_rounded,
                          size: 12, color: AppColors.success),
                      SizedBox(width: 4),
                      Text(
                        'Verified Landmark',
                        style: TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.w700,
                          color: AppColors.success,
                        ),
                      ),
                    ],
                  ),
                ),
              if (eventsCount > 0) ...[
                const SizedBox(width: 8),
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                  decoration: BoxDecoration(
                    color: const Color(0xFFFEE2E2),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(Icons.celebration_rounded,
                          size: 12, color: Color(0xFFE11D48)),
                      const SizedBox(width: 4),
                      Text(
                        '$eventsCount Active Events',
                        style: const TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.w700,
                          color: Color(0xFFE11D48),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
              const Spacer(),
              ElevatedButton.icon(
                onPressed: () {
                  LocationDetailsSheet.show(
                    context,
                    location: loc,
                    onFocusOnMap: () {
                      _mapController.move(
                        LatLng(loc.latitude, loc.longitude),
                        18.0,
                      );
                    },
                  );
                },
                icon: const Icon(Icons.info_outline_rounded, size: 14),
                label: const Text('View Details'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.secondaryPurple,
                  foregroundColor: Colors.white,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  textStyle: const TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.w700,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
