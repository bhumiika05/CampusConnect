import 'package:serverpod/serverpod.dart';
import '../services/seed_data_service.dart';

class SeedEndpoint extends Endpoint {
  /// Seeds initial campus community data if database is empty or force is true.
  Future<bool> seedInitialData(Session session, {bool force = false}) async {
    return await SeedDataService.seedIfEmpty(session, force: force);
  }
}
