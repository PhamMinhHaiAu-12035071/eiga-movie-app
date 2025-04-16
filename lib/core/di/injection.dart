// lib/core/di/injection.dart

import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import 'package:ksk_app/core/di/injection.config.dart';
import 'package:shared_preferences/shared_preferences.dart';

final getIt = GetIt.instance;

@InjectableInit(
  initializerName: 'init', // default
  preferRelativeImports: true, // default
  asExtension: true, // default
)
Future<void> configureDependencies() async {
  await getIt.init();
}

/// Register module for dependencies
@module
abstract class RegisterModule {
  /// Register SharedPreferences instance
  @preResolve
  Future<SharedPreferences> get prefs => SharedPreferences.getInstance();
}
