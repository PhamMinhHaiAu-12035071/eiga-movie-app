import 'package:fpdart/fpdart.dart';
import 'package:injectable/injectable.dart';
import 'package:ksk_app/features/storage/domain/errors/storage_failure.dart';
import 'package:ksk_app/features/storage/domain/interfaces/local_storage_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// Implementation of [LocalStorageService] using SharedPreferences
@LazySingleton(as: LocalStorageService)
class SharedPreferencesStorageService implements LocalStorageService {
  /// Constructor with dependency injection
  SharedPreferencesStorageService(this._preferences);

  /// SharedPreferences instance for data storage
  final SharedPreferences _preferences;

  @override
  Future<Either<StorageFailure, bool?>> getBool(String key) async {
    try {
      final value = _preferences.getBool(key);
      return right(value);
    } on Exception catch (e) {
      return left(
        StorageFailure.storageError(
          'Error getting bool for key $key: $e',
        ),
      );
    }
  }

  @override
  Future<Either<StorageFailure, bool>> setBool(
    String key, {
    required bool value,
  }) async {
    try {
      final result = await _preferences.setBool(key, value);
      return right(result);
    } on Exception catch (e) {
      return left(
        StorageFailure.storageError(
          'Error setting bool for key $key: $e',
        ),
      );
    }
  }

  @override
  Future<Either<StorageFailure, bool>> containsKey(String key) async {
    try {
      final result = _preferences.containsKey(key);
      return right(result);
    } on Exception catch (e) {
      return left(
        StorageFailure.storageError(
          'Error checking if key $key exists: $e',
        ),
      );
    }
  }

  @override
  Future<Either<StorageFailure, bool>> remove(String key) async {
    try {
      final result = await _preferences.remove(key);
      return right(result);
    } on Exception catch (e) {
      return left(
        StorageFailure.storageError(
          'Error removing key $key: $e',
        ),
      );
    }
  }

  @override
  Future<Either<StorageFailure, bool>> clear() async {
    try {
      final result = await _preferences.clear();
      return right(result);
    } on Exception catch (e) {
      return left(
        StorageFailure.storageError(
          'Error clearing storage: $e',
        ),
      );
    }
  }
}
