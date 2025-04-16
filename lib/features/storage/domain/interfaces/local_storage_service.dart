import 'package:fpdart/fpdart.dart';
import 'package:ksk_app/features/storage/domain/errors/storage_failure.dart';

/// Abstract interface for local storage operations
///
/// This interface provides a common abstraction for different local storage
/// implementations, allowing for dependency inversion and easier testing.
abstract class LocalStorageService {
  /// Retrieves a boolean value from local storage
  ///
  /// Returns the boolean value associated with [key] or null if not found
  /// Returns Left with StorageFailure on error.
  Future<Either<StorageFailure, bool?>> getBool(String key);

  /// Stores a boolean value in local storage
  ///
  /// Associates [key] with [value] in the local storage
  Future<Either<StorageFailure, bool>> setBool(
    String key, {
    required bool value,
  });

  /// Checks if a key exists in local storage
  ///
  /// Returns true if [key] exists in the local storage
  Future<Either<StorageFailure, bool>> containsKey(String key);

  /// Removes a value from local storage
  ///
  /// Removes the value associated with [key] from local storage
  Future<Either<StorageFailure, bool>> remove(String key);

  /// Clears all values from local storage
  ///
  /// Removes all key-value pairs from local storage
  Future<Either<StorageFailure, bool>> clear();
}
