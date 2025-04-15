import 'package:injectable/injectable.dart';
import 'package:ksk_app/core/services/local_storage_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// Implementation of [LocalStorageService] using SharedPreferences
@LazySingleton(as: LocalStorageService)
class SharedPreferencesStorageService implements LocalStorageService {
  /// Constructor with dependency injection
  SharedPreferencesStorageService(this._preferences);

  /// SharedPreferences instance for data storage
  final SharedPreferences _preferences;

  @override
  Future<bool> getBool(String key, {bool defaultValue = false}) async {
    return _preferences.getBool(key) ?? defaultValue;
  }

  @override
  Future<bool> setBool(String key, {required bool value}) async {
    return _preferences.setBool(key, value);
  }

  @override
  Future<bool> containsKey(String key) async {
    return _preferences.containsKey(key);
  }

  @override
  Future<bool> remove(String key) async {
    return _preferences.remove(key);
  }

  @override
  Future<bool> clear() async {
    return _preferences.clear();
  }
}
