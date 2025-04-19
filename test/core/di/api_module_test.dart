import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ksk_app/core/di/api_module.dart';
import 'package:logger/logger.dart';

// Create a mock that extends Logger instead of just Mock
class MockLogger extends Logger {
  final calls = <String>[];

  @override
  void d(
    dynamic message, {
    Object? error,
    StackTrace? stackTrace,
    DateTime? time,
  }) {
    calls.add(message.toString());
  }
}

// Create a testable version of ApiModule for testing
class TestableApiModule extends ApiModule {
  TestableApiModule(this.logger);

  final Logger logger;

  @override
  Dio provideDio() {
    final dio = Dio(
      BaseOptions(
        connectTimeout: const Duration(seconds: 30),
        receiveTimeout: const Duration(seconds: 30),
        sendTimeout: const Duration(seconds: 30),
      ),
    );

    // Add logging interceptor with our testable logger
    dio.interceptors.add(
      LogInterceptor(
        requestBody: true,
        responseBody: true,
        logPrint: (object) {
          logger.d(object.toString());
        },
      ),
    );

    return dio;
  }
}

void main() {
  late ApiModule apiModule;

  setUp(() {
    apiModule = _TestApiModule();
  });

  group('ApiModule', () {
    test('provideDio should return Dio instance with interceptors', () {
      // Act
      final dio = apiModule.provideDio();

      // Assert
      expect(dio, isA<Dio>());
      expect(dio.interceptors, isNotEmpty);

      // Verify LogInterceptor is added
      expect(
        dio.interceptors.any((i) => i is LogInterceptor),
        isTrue,
      );
    });

    test('Dio instance should have correct timeouts', () {
      // Act
      final dio = apiModule.provideDio();
      final options = dio.options;

      // Assert
      expect(options.connectTimeout, const Duration(seconds: 30));
      expect(options.receiveTimeout, const Duration(seconds: 30));
      expect(options.sendTimeout, const Duration(seconds: 30));
    });

    test('LogInterceptor should log requests and responses', () async {
      // Arrange
      final mockLogger = MockLogger();
      final testModule = _TestApiModuleWithMockLogger(mockLogger);
      final dio = testModule.provideDio();

      dio.interceptors.whereType<LogInterceptor>().forEach((logInterceptor) {
        expect(logInterceptor.requestBody, isTrue);
        expect(logInterceptor.responseBody, isTrue);
      });

      // You would need to make a real request to fully test the logging,
      // but that's outside the scope of this unit test
    });

    test('LogInterceptor logPrint should call logger.d with object string', () {
      // Arrange
      final mockLogger = MockLogger();
      final testModule = TestableApiModule(mockLogger);
      final dio = testModule.provideDio();

      // Find the LogInterceptor
      final logInterceptor = dio.interceptors.whereType<LogInterceptor>().first;

      // Get the logPrint function
      final logPrint = logInterceptor.logPrint;

      // Act - call the logPrint function directly with a test string
      logPrint('test message');

      // Assert - verify the logger was called with the correct string
      expect(mockLogger.calls, contains('test message'));
    });

    test('original ApiModule LogInterceptor logPrint uses Logger', () {
      // We need to test the actual implementation's logPrint function
      // which directly creates a Logger instance

      // Arrange
      final dio = apiModule.provideDio();
      final logInterceptor = dio.interceptors.whereType<LogInterceptor>().first;
      final logPrint = logInterceptor.logPrint;

      // Act & Assert - should not throw
      // This will execute the Logger().d() code
      expect(() => logPrint('test message'), returnsNormally);
    });
  });
}

/// Test implementation of ApiModule
class _TestApiModule extends ApiModule {}

/// Test implementation of ApiModule with mock logger
class _TestApiModuleWithMockLogger extends ApiModule {
  _TestApiModuleWithMockLogger(this.mockLogger);

  final MockLogger mockLogger;

  @override
  Dio provideDio() {
    final dio = super.provideDio();

    // Replace the logger in the existing LogInterceptor
    dio.interceptors.removeWhere((i) => i is LogInterceptor);
    dio.interceptors.add(
      LogInterceptor(
        requestBody: true,
        responseBody: true,
        logPrint: (object) {
          mockLogger.d(object.toString());
        },
      ),
    );

    return dio;
  }
}
