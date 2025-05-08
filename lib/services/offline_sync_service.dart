import 'package:offline_sync/offline_sync.dart';

class OfflineSyncService {
  static final OfflineSync _offlineSync = OfflineSync();

  static Future<void> initialize() async {
    await _offlineSync.initialize();
    _offlineSync.setApiEndpoint('https://your-custom-api.com'); // Replace with your actual API
  }

  static Future<void> setAuthToken(String token) async {
    await _offlineSync.setAuthToken(token);
  }

  static Future<void> saveUserData(String id, Map<String, dynamic> data) async {
    await _offlineSync.saveLocalData(id, data);
  }

  static Future<Map<String, dynamic>?> getUserData(String id) async {
    return await _offlineSync.readLocalData(id);
  }

  static Future<void> sync() async {
    try {
      await _offlineSync.updateFromServer();
    } catch (e) {
      print('Sync failed: $e');
    }
  }

  static Future<Map<String, dynamic>?> getUserDataByEmail(String email) async {
    final all = await _offlineSync.readAllLocalData(); // Assuming 'readAllLocalData' is the correct method
    for (final data in all) {
      if (data is Map && data['email'] == email) {
        return data.cast<String, dynamic>();
      }
    }
    return null;
  }
}
