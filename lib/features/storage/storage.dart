/// Storage feature module
///
/// This module provides persistent storage capabilities for the application
/// using SharedPreferences as the underlying implementation.
library;

// Domain layer exports
export 'domain/errors/storage_failure.dart';
export 'domain/interfaces/local_storage_service.dart';

// Infrastructure layer exports
export 'infrastructure/services/shared_preferences_storage_service.dart';
