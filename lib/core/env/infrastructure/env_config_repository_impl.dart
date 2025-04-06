// lib/core/env/infrastructure/env_config_repository_impl.dart

import 'package:injectable/injectable.dart';
import 'package:ksk_app/core/env/domain/env_config_repository.dart'
    show EnvConfigRepository;
import 'package:ksk_app/core/env/env_development.dart';

/// Implementation of the [EnvConfigRepository] interface for
/// accessing environment configuration variables.
///
/// This class implements the repository pattern for environment access,
/// leveraging the development environment configuration from [EnvDev].
/// It is registered with the dependency injection container as a lazy singleton
/// to ensure consistent access throughout the application lifecycle.
@LazySingleton(as: EnvConfigRepository)
class EnvConfigRepositoryImpl implements EnvConfigRepository {
  /// Retrieves the API URL from the development environment configuration.
  ///
  /// This URL is used as the base endpoint for all API requests.
  @override
  String get apiUrl => EnvDev.apiUrl;

  /// Retrieves the application name from the development environment
  /// configuration.
  ///
  /// This name is used for display and identification purposes.
  @override
  String get appName => EnvDev.appName;

  /// Retrieves the environment name from the development environment
  /// configuration.
  ///
  /// This is used for logging and debugging to identify the current environment
  @override
  String get environmentName => EnvDev.environmentName;
}
