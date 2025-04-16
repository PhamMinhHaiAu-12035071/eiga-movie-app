/// Repository interface for environment configuration.
///
/// This interface defines the contract for accessing environment configuration
/// values throughout the application. Following Clean Architecture principles,
/// this abstract class serves as a boundary between the domain layer and
/// infrastructure implementations.
///
/// This approach ensures:
/// - Consistent access to environment variables across the app
/// - Ability to switch environments without changing feature code
/// - Testability through mocking
/// - Proper separation of concerns
abstract class EnvConfigRepository {
  /// Returns the base API URL for all network requests.
  String get apiUrl;

  /// Returns the application name as defined in environment.
  String get appName;

  /// Returns the current environment name (e.g., "development", "production").
  String get environmentName;
}
