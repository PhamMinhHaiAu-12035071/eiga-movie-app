import 'package:flutter_test/flutter_test.dart';
import 'package:ksk_app/features/storage/domain/errors/storage_failure.dart';

void main() {
  group('StorageFailure', () {
    test(
        'storageError should create StorageFailure with the right type and '
        'message', () {
      // When message is provided
      const failure = StorageFailure.storageError('test error');
      expect(failure, isA<StorageFailure>());

      // Test toString output which contains the type and message
      expect(failure.toString(), contains('StorageFailure.storageError'));
      expect(failure.toString(), contains('test error'));

      // When message is null
      const nullMsgFailure = StorageFailure.storageError();
      expect(
        nullMsgFailure.toString(),
        contains('StorageFailure.storageError'),
      );
      expect(nullMsgFailure.toString(), contains('message: null'));
    });

    test(
        'keyNotFound should create StorageFailure with the right type and '
        'key', () {
      const failure = StorageFailure.keyNotFound('testKey');
      expect(failure, isA<StorageFailure>());

      // Test toString output which contains the type and key
      expect(failure.toString(), contains('StorageFailure.keyNotFound'));
      expect(failure.toString(), contains('testKey'));
    });

    test(
        'typeMismatch should create StorageFailure with the right type and '
        'key', () {
      const failure = StorageFailure.typeMismatch('testKey');
      expect(failure, isA<StorageFailure>());

      // Test toString output which contains the type and key
      expect(failure.toString(), contains('StorageFailure.typeMismatch'));
      expect(failure.toString(), contains('testKey'));
    });

    test('equality should work correctly', () {
      const error1 = StorageFailure.storageError('test');
      const error2 = StorageFailure.storageError('test');
      const error3 = StorageFailure.storageError('different');
      const keyError = StorageFailure.keyNotFound('test');

      expect(error1 == error2, isTrue);
      expect(error1 == error3, isFalse);
      expect(error1 == keyError, isFalse);
    });

    test('hashCode should be consistent with equality', () {
      const error1 = StorageFailure.storageError('test');
      const error2 = StorageFailure.storageError('test');
      const error3 = StorageFailure.storageError('different');

      expect(error1.hashCode == error2.hashCode, isTrue);
      expect(error1.hashCode == error3.hashCode, isFalse);
    });
  });
}
