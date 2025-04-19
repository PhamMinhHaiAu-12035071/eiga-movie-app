import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:logger/logger.dart';

/// Module for registering API-related dependencies
@module
abstract class ApiModule {
  /// Provides a configured Dio instance with logging and auth interceptors
  @lazySingleton
  Dio provideDio() {
    final dio = Dio(
      BaseOptions(
        connectTimeout: const Duration(seconds: 30),
        receiveTimeout: const Duration(seconds: 30),
        sendTimeout: const Duration(seconds: 30),
      ),
    );

    // Add logging interceptor
    dio.interceptors.add(
      LogInterceptor(
        requestBody: true,
        responseBody: true,
        logPrint: (object) {
          Logger().d(object.toString());
        },
      ),
    );

    // Add auth interceptor - will be implemented later
    // when auth feature is added
    // dio.interceptors.add(AuthInterceptor());

    return dio;
  }
}
