import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// Module for registering local storage dependencies
@module
abstract class LocalStorageModule {
  /// Register SharedPreferences instance
  @preResolve
  Future<SharedPreferences> get prefs => SharedPreferences.getInstance();
}
