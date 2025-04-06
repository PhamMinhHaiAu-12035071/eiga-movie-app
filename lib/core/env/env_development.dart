import 'package:envied/envied.dart';
import 'package:ksk_app/core/env/domain/env_config_repository.dart'
    show EnvConfigRepository;

part 'env_development.g.dart';

/// Environment configuration for development environment.
/// This class serves as an interface to access environment variables
/// securely using the envied package with obfuscation enabled.ss
///
/// The implementation uses the `.env.dev` file for development-specific
/// configuration values. Never access these values directly in features.
/// Instead, inject the [EnvConfigRepository] through DI.
@Envied(path: 'lib/core/env/.env.dev', obfuscate: true)
abstract class EnvDev {
  /// Base API URL for backend communication.
  /// This is the primary endpoint for all API requests.
  @EnviedField(varName: 'API_URL')
  static String apiUrl = _EnvDev.apiUrl;

  /// Application name used for display and identification.
  @EnviedField(varName: 'APP_NAME')
  static String appName = _EnvDev.appName;

  /// Environment identifier, used for debugging and logging.
  @EnviedField(varName: 'ENVIRONMENT_NAME')
  static String environmentName = _EnvDev.environmentName;
}
