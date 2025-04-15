/// Abstract interface for local storage operations
///
/// This interface provides a common abstraction for different local storage
/// implementations, allowing for dependency inversion and easier testing.
abstract class LocalStorageService {
  /// Retrieves a boolean value from local storage
  ///
  /// Returns the boolean value associated with [key], or [defaultValue]
  /// if not found
  Future<bool> getBool(String key, {bool defaultValue = false});

  /// Stores a boolean value in local storage
  ///
  /// Associates [key] with [value] in the local storage
  Future<bool> setBool(String key, {required bool value});

  /// Checks if a key exists in local storage
  ///
  /// Returns true if [key] exists in the local storage
  Future<bool> containsKey(String key);

  /// Removes a value from local storage
  ///
  /// Removes the value associated with [key] from local storage
  Future<bool> remove(String key);

  /// Clears all values from local storage
  ///
  /// Removes all key-value pairs from local storage
  Future<bool> clear();
}
