import 'package:serverpod/serverpod.dart';
import '../generated/protocol.dart';

class LocationEndpoint extends Endpoint {
  /// Retrieves campus locations filtered by category and/or search query.
  Future<List<CampusLocation>> getLocations(
    Session session, {
    String? category,
    String? query,
  }) async {
    final lowerQuery = query?.trim().toLowerCase();
    final lowerCategory = category?.trim().toLowerCase();

    final allLocations = await CampusLocation.db.find(
      session,
      orderBy: (t) => t.name,
    );

    return allLocations.where((loc) {
      if (lowerCategory != null &&
          lowerCategory.isNotEmpty &&
          lowerCategory != 'all') {
        if (loc.category.toLowerCase() != lowerCategory) {
          return false;
        }
      }

      if (lowerQuery != null && lowerQuery.isNotEmpty) {
        final nameMatch = loc.name.toLowerCase().contains(lowerQuery);
        final descMatch = loc.shortDescription.toLowerCase().contains(lowerQuery);
        final categoryMatch = loc.category.toLowerCase().contains(lowerQuery);
        final blockMatch = loc.buildingBlock?.toLowerCase().contains(lowerQuery) ?? false;
        final tagsMatch = loc.tags?.any((t) => t.toLowerCase().contains(lowerQuery)) ?? false;

        if (!nameMatch && !descMatch && !categoryMatch && !blockMatch && !tagsMatch) {
          return false;
        }
      }

      return true;
    }).toList();
  }

  /// Retrieves a specific location by its database ID.
  Future<CampusLocation?> getLocationById(Session session, int id) async {
    return await CampusLocation.db.findById(session, id);
  }

  /// Retrieves confirmed events happening at the specified location ID or matching venue name.
  Future<List<CampusEvent>> getEventsForLocation(
    Session session,
    int locationId,
  ) async {
    final location = await CampusLocation.db.findById(session, locationId);
    if (location == null) return [];

    final events = await CampusEvent.db.find(
      session,
      where: (t) =>
          t.locationId.equals(locationId) |
          t.venue.ilike('%${location.name}%') |
          t.venue.ilike('%${location.buildingBlock ?? ''}%'),
      orderBy: (t) => t.startTime,
    );

    return events;
  }
}
