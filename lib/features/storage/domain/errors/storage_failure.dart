import 'package:freezed_annotation/freezed_annotation.dart';

part 'storage_failure.freezed.dart';

/// Represents failures that can occur during storage operations
@freezed
class StorageFailure with _$StorageFailure {
  /// General storage error with optional message
  const factory StorageFailure.storageError([String? message]) = _StorageError;

  /// Error when key not found in storage
  const factory StorageFailure.keyNotFound(String key) = _KeyNotFound;

  /// Error when there's a type mismatch in storage
  const factory StorageFailure.typeMismatch(String key) = _TypeMismatch;
}
