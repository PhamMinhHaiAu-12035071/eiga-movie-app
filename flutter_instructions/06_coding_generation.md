# Coding implementation

> **🧠 Note:** This guide provides concrete examples and conventions for implementing features according to the established **Flutter Clean Architecture (Rule 02)**. It integrates best practices for dependency injection, state management, testing, and utilizes recommended libraries (`injectable`, `result_type`, `logger`, `flutter_gen`, `slang`, `envied`, etc.). Always refer back to **Rule 02** for foundational principles and **Rule 04/05** for project planning context.

/* ========================================================================
   === 1. DOMAIN LAYER =====================================================
   ======================================================================== */

# Domain Layer Guidelines

## Directory Structure

```
lib/
  └── features/                 # Changed from feature_name for consistency with Rule 02
      └── [feature_name]/
          └── domain/
              ├── i_[feature_name]_repository.dart # Changed to Repository pattern
              ├── models/                     # Group models if complex
              │   └── [feature_name]_model.dart
              │   └── [related_]_model.dart
              └── errors/                     # Optional: Define feature-specific errors
                  └── [feature_name]_failure.dart
```

## Domain Layer Conventions

### Model Structure (Refer to Rule 03 for derivation from Figma)

1.  Models must:
    *   Be immutable.
    *   Use `freezed` annotation (`@freezed`).
    *   Have a factory constructor `_MyModel` for `freezed`.
    *   Have a const factory constructor for instantiation with default values.
    *   Represent core business entities.

2.  Model Properties:
    *   Use proper types (avoid `dynamic`). Use `nil` package utilities if needed (Rule 02).
    *   Include documentation (`///`).
    *   Consider value objects for complex types (e.g., EmailAddress, Password).

### Interface (Repository) Structure

1.  Interfaces (Abstract Classes) must:
    *   Define a clear contract for data operations related to the domain.
    *   Be prefixed with 'I' (e.g., `IAuthRepository`).
    *   Include method documentation (`///`).
    *   Define potential failure cases using a sealed class/enum (e.g., `AuthFailure`).
    *   Return `Future<Result<T, F>>` for operations that can fail (using `result_type` package, where `F` is the Failure type).

2.  Interface Methods:
    *   Should be asynchronous (`Future`).
    *   Have clear parameter names and types.
    *   Document possible failure types (`F`) in the doc comments.

## Naming Conventions

### Files

1.  Model files:
    *   Use `_model.dart` suffix.
    *   Use `snake_case`.
    *   Be descriptive of the model content (e.g., `user_profile_model.dart`).
2.  Interface (Repository) files:
    *   Use `i_` prefix.
    *   Use `_repository.dart` suffix.
    *   Use `snake_case` (e.g., `i_auth_repository.dart`).
3.  Failure files:
    *   Use `_failure.dart` suffix.
    *   Use `snake_case` (e.g., `auth_failure.dart`).

### Classes

1.  Model classes:
    *   Use `PascalCase`.
    *   End with 'Model' (or be descriptive, e.g., `UserProfile`).
    *   Match their file names (without suffix).
2.  Interface (Repository) classes:
    *   Use `PascalCase`.
    *   Start with 'I'.
    *   End with 'Repository'.
3.  Failure classes/enums:
    *   Use `PascalCase`.
    *   End with 'Failure'.

## Code Organization

1.  Models:
    *   One core model per file usually. Group related small models if logical.
    *   Place in `domain/models/` subdirectory if structure becomes complex.
2.  Interfaces (Repositories):
    *   One interface per file.
    *   Define clear method contracts.
    *   Specify failure types.
    *   Document all methods and failures.

## Best Practices

1.  Domain Models:
    *   Keep models focused on business logic, free from infrastructure details.
    *   Use value objects for validation and type safety where appropriate.
    *   Derive initial models by analyzing Figma designs (Rule 03).
2.  Interfaces (Repositories):
    *   Define contracts based on use cases, not specific data sources.
    *   Use `Result` type for clear success/failure handling.
    *   Keep methods focused on specific domain operations.

## Testing Guidelines (Domain)

1.  Directory Structure:
    ```
    test/
      └── features/
          └── [feature_name]/
              └── domain/
                  ├── models/
                  │   └── [feature_name]_model_test.dart
                  └── i_[feature_name]_repository_test.dart # Test interface contract if needed (rare)
    ```

2.  Model Testing:
    *   Test factory constructor defaults.
    *   Test `copyWith` methods.
    *   Test equality comparisons.
    *   Test any validation logic within value objects.
    *   (Aim for >99.99% coverage - Rule 02)

3.  Testing Conventions:
    *   Use `flutter_test` and `test`.
    *   Group tests logically using `group()`.
    *   Use meaningful test names (e.g., `test('should return default values when created with factory', ...)`).

## Code Example (Domain Layer)

```dart
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:result_type/result_type.dart';

part 'user_model.freezed.dart'; // Generated by freezed

/// Represents a user in the domain.
@freezed
class UserModel with _$UserModel {
  const factory UserModel({
    required String id, // Use required for non-nullable fields without defaults
    @Default('') String name,
    @Default('') String email,
    @Default(false) bool isActive,
  }) = _UserModel;

  // Private constructor needed for freezed
  const UserModel._();

  // Example of a simple computed property
  bool get isRegistered => id.isNotEmpty;
}

/// Defines possible failures for authentication operations.
@freezed
sealed class AuthFailure with _$AuthFailure {
  const factory AuthFailure.serverError({String? message}) = _ServerError;
  const factory AuthFailure.invalidCredentials() = _InvalidCredentials;
  const factory AuthFailure.emailInUse() = _EmailInUse;
  const factory AuthFailure.networkError() = _NetworkError;
}


/// Interface defining authentication operations.
abstract class IAuthRepository {
  /// Fetches user profile by ID.
  ///
  /// Returns [Result.success] with [UserModel] on success.
  /// Returns [Result.failure] with [AuthFailure.serverError] or [AuthFailure.networkError] on failure.
  Future<Result<UserModel, AuthFailure>> getUserProfile(String userId);

  /// Attempts to register a new user.
  ///
  /// Returns [Result.success] with [UserModel] on success.
  /// Returns [Result.failure] with [AuthFailure.emailInUse], [AuthFailure.serverError], or [AuthFailure.networkError].
  Future<Result<UserModel, AuthFailure>> register({
    required String name,
    required String email,
    required String password,
  });

  /// Attempts to log in a user.
  ///
  /// Returns [Result.success] with [UserModel] on success.
  /// Returns [Result.failure] with [AuthFailure.invalidCredentials], [AuthFailure.serverError], or [AuthFailure.networkError].
  Future<Result<UserModel, AuthFailure>> login({
    required String email,
    required String password,
  });
}
```

/* ========================================================================
   === 2. INFRASTRUCTURE LAYER =============================================
   ======================================================================== */

# Infrastructure Layer Guidelines

## Directory Structure

```
lib/
  └── features/
      └── [feature_name]/
          └── infrastructure/
              ├── repositories/                 # Implementation of domain repositories
              │   └── [feature_name]_repository.dart
              ├── dtos/                       # Data Transfer Objects
              │   └── [feature_name]_dto.dart
              ├── datasources/                # API clients, local DB access
              │   ├── remote/
              │   │   └── [feature_name]_api_service.dart # Or using Chopper/Dio
              │   └── local/
              │       └── [feature_name]_local_datasource.dart # Optional
              └── constants/                  # API keys, endpoints (Consider Rule 04/Envied)
                  └── [feature_name]_api_constants.dart
```

## Infrastructure Layer Conventions

### DTO Structure

1.  DTOs must:
    *   Be immutable.
    *   Use `freezed` annotation (`@freezed`).
    *   Include `fromJson` factory for parsing API responses.
    *   Include `toJson` method if sending data to API.
    *   Have a `toDomain()` method to convert to the corresponding Domain Model.
    *   Handle potential null values from the API gracefully (`@Default`, nullable types).
    *   Use `@JsonKey` for mapping API field names (e.g., `snake_case` API fields to `camelCase` DTO fields).

2.  DTO Properties:
    *   Match the structure of the API request/response.
    *   Use appropriate types.
    *   Include documentation (`///`).

### API Constants Structure (See Rule 04 for Envied Integration)

1.  API Constants should:
    *   Reside in a dedicated file (e.g., `_api_constants.dart`).
    *   Use `static const String` for base URLs, endpoints, keys.
    *   Group related constants.
    *   **Strongly Recommended:** Use `envied` (Rule 02) to manage API keys and base URLs securely per environment, injecting them via DI instead of hardcoding in constants files.

### Repository Implementation Structure

1.  Repositories must:
    *   Implement the corresponding Domain Interface (`I...Repository`).
    *   Depend on Datasource interfaces (e.g., `IApiService`, `ILocalDatasource`) injected via DI (`injectable`).
    *   Catch specific exceptions from datasources (e.g., `DioException`, `SocketException`, `HiveError`).
    *   Map caught exceptions to Domain Failures (e.g., `AuthFailure.networkError`).
    *   Call `toDomain()` on DTOs before returning `Result.success`.
    *   Return `Result.success(domainModel)` or `Result.failure(domainFailure)`.
    *   Utilize a `Logger` instance (Rule 02) for logging errors and important operations.

2.  Repository Methods:
    *   Contain the logic to coordinate data fetching/storing from different datasources (remote/local).
    *   Implement error handling and mapping logic.
    *   Convert DTOs to Domain Models.

### Datasource Structure (e.g., ApiService)

1.  Datasources should:
    *   Encapsulate the interaction with a specific data source (e.g., REST API, local database).
    *   Define methods corresponding to API calls or database operations.
    *   Throw specific exceptions on failure (e.g., `ApiException`, `DatabaseException`). Do NOT return `Result` here; let the Repository handle `Result`.
    *   Depend on HTTP clients (like `Dio`, `Chopper`), database clients (`Hive`, `sqflite`) injected via DI.
    *   Use DTOs for data transfer.

## Naming Conventions

### Files

1.  DTO files:
    *   Use `_dto.dart` suffix.
    *   Use `snake_case`.
    *   Often match API resource names (e.g., `user_profile_dto.dart`).
2.  Repository implementation files:
    *   Remove `i_` prefix from interface name.
    *   Use `_repository.dart` suffix.
    *   Use `snake_case` (e.g., `auth_repository.dart`).
3.  Datasource files:
    *   Use `_api_service.dart`, `_local_datasource.dart`, etc.
    *   Use `snake_case`.
4.  API Constants files:
    *   Use `_api_constants.dart` (if not using Envied).
    *   Use `snake_case`.

### Classes

1.  DTO classes:
    *   Use `PascalCase`.
    *   End with 'Dto'.
    *   Match their file names (without suffix).
2.  Repository implementation classes:
    *   Use `PascalCase`.
    *   Remove 'I' prefix from interface name.
    *   End with 'Repository'.
3.  Datasource classes:
    *   Use `PascalCase`.
    *   End with 'ApiService', 'LocalDatasource', etc.

## Code Organization

1.  DTOs:
    *   One DTO per file generally.
    *   Group in `infrastructure/dtos/`.
    *   Include JSON serialization (`fromJson`/`toJson`) and `toDomain()` conversion.
2.  Repositories:
    *   One repository implementation per file in `infrastructure/repositories/`.
    *   Clearly handle exceptions and map to domain failures.
    *   Inject dependencies via constructor (`@Injectable`).
3.  Datasources:
    *   Place in `infrastructure/datasources/remote/` or `infrastructure/datasources/local/`.
    *   Focus solely on data source interaction.
4.  Constants:
    *   Place in `infrastructure/constants/`. **Prefer `envied` injected config.**

## Best Practices

1.  DTOs:
    *   Strictly map to the external data structure (API, DB schema).
    *   Handle potential nulls/missing fields robustly.
    *   Ensure `toDomain()` correctly converts to the business model.
2.  Repositories:
    *   Act as the single source of truth for domain layer data.
    *   Abstract away the origin of data (API, cache, DB).
    *   Implement comprehensive error mapping to domain failures.
    *   Use `Logger` for observability.
3.  Datasources:
    *   Keep them simple, focused on communication.
    *   Throw specific, informative exceptions.

## Testing Guidelines (Infrastructure)

1.  Directory Structure:
    ```
    test/
      └── features/
          └── [feature_name]/
              └── infrastructure/
                  ├── repositories/
                  │   └── [feature_name]_repository_test.dart
                  ├── dtos/
                  │   └── [feature_name]_dto_test.dart
                  └── datasources/
                      └── remote/
                      │   └── [feature_name]_api_service_test.dart # If complex
                      └── local/
                          └── [feature_name]_local_datasource_test.dart # If complex
    ```
2.  DTO Testing:
    *   Test `fromJson` with valid and edge-case JSON data (nulls, missing keys).
    *   Test `toJson` if applicable.
    *   Test `toDomain()` conversion logic.
3.  Repository Testing:
    *   **Unit Tests are crucial here.**
    *   Use `mocktail` (Rule 02) to mock Datasource dependencies (`IApiService`, `ILocalDatasource`).
    *   Test success cases: verify correct domain model is returned (`Result.success`).
    *   Test failure cases: verify datasource exceptions are caught and mapped to correct domain failures (`Result.failure`).
    *   Verify datasource methods are called with expected parameters.
    *   Aim for >99.99% coverage (Rule 02).
4.  Datasource Testing:
    *   Unit test if logic is complex (e.g., data transformation before sending).
    *   Often covered by integration tests, but unit tests with mocked clients (`MockDioAdapter`, `MockHttpClient`) can be useful.

## Code Example (Infrastructure Layer - Auth Feature)

```dart
import 'package:dio/dio.dart'; // Example HTTP client
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart'; // For DI
import 'package:logger/logger.dart'; // For Logging (Rule 02)
import 'package:result_type/result_type.dart';

// Assume Domain Layer (UserModel, AuthFailure, IAuthRepository) is defined as above

part 'auth_dto.freezed.dart';
part 'auth_dto.g.dart'; // Generated by json_serializable

/// DTO for user data from the API.
@freezed
class UserDto with _$UserDto {
  const factory UserDto({
    required String id,
    @Default('') String name,
    @Default('') String email,
    @Default(false) @JsonKey(name: 'is_active') bool isActive, // Map API key
  }) = _UserDto;

  const UserDto._(); // Private constructor for methods

  factory UserDto.fromJson(Map<String, dynamic> json) =>
      _$UserDtoFromJson(json);

  /// Converts DTO to Domain Model.
  UserModel toDomain() => UserModel(
    id: id,
    name: name,
    email: email,
    isActive: isActive,
  );
}

// --- Datasource Example (Conceptual) ---

/// Interface for the Auth API service.
abstract class IAuthApiService {
  Future<UserDto> register(String name, String email, String password);
  Future<UserDto> login(String email, String password);
  // ... other methods
}

/// Concrete implementation using Dio (Example).
@LazySingleton(as: IAuthApiService) // Register with GetIt/Injectable
class AuthApiService implements IAuthApiService {
  final Dio _dio;
  // Inject EnvConfig (from Envied - Rule 04) instead of hardcoding base URL
  // final EnvConfigRepository _envConfig;

  // Constructor injection
  AuthApiService(this._dio /*, this._envConfig*/);

  @override
  Future<UserDto> register(String name, String email, String password) async {
    try {
      // Replace with actual endpoint from Envied/Constants
      final response = await _dio.post(
        '/auth/register', // Example endpoint
        data: {'name': name, 'email': email, 'password': password},
      );
      // Basic error handling, real implementation would be more robust
      if (response.statusCode == 201) {
        return UserDto.fromJson(response.data as Map<String, dynamic>);
      } else if (response.statusCode == 409) { // Conflict - Email in use
         throw DioException( // Throw specific exception for repository to catch
           requestOptions: response.requestOptions,
           response: response,
           type: DioExceptionType.badResponse,
           error: 'Email already in use',
         );
      } else {
         throw DioException( // Generic server error
           requestOptions: response.requestOptions,
           response: response,
           type: DioExceptionType.badResponse,
           error: 'Server error during registration',
         );
      }
    } on DioException catch (e) {
        // Rethrow DioException for the repository to handle network vs server errors
        throw e;
    } catch (e) {
      // Catch other potential errors
       throw Exception('Unexpected error during registration: $e');
    }
  }

  @override
  Future<UserDto> login(String email, String password) async {
     try {
      final response = await _dio.post(
        '/auth/login', // Example endpoint
        data: {'email': email, 'password': password},
      );
       if (response.statusCode == 200) {
         return UserDto.fromJson(response.data as Map<String, dynamic>);
       } else if (response.statusCode == 401) { // Unauthorized
          throw DioException(
            requestOptions: response.requestOptions,
            response: response,
            type: DioExceptionType.badResponse,
            error: 'Invalid credentials',
          );
       } else {
          throw DioException( // Generic server error
           requestOptions: response.requestOptions,
           response: response,
           type: DioExceptionType.badResponse,
           error: 'Server error during login',
         );
       }
     } on DioException catch (e) {
         throw e;
     } catch (e) {
        throw Exception('Unexpected error during login: $e');
     }
  }
  // ... implementations for other methods
}


// --- Repository Implementation ---

/// Concrete implementation of the Auth Repository.
@LazySingleton(as: IAuthRepository) // Register with GetIt/Injectable
class AuthRepository implements IAuthRepository {
  final IAuthApiService _apiService; // Inject datasource interface
  final Logger _logger; // Inject Logger (Rule 02)

  AuthRepository(this._apiService, this._logger); // Constructor injection

  @override
  Future<Result<UserModel, AuthFailure>> register({
    required String name,
    required String email,
    required String password,
  }) async {
    try {
      _logger.i('Attempting user registration for email: $email');
      final userDto = await _apiService.register(name, email, password);
      _logger.i('Registration successful for email: $email');
      return Result.success(userDto.toDomain()); // Use Result.success
    } on DioException catch (e) {
       _logger.e('Registration failed for email: $email', error: e, stackTrace: e.stackTrace);
       // Map Dio exceptions to Domain Failures
       if (e.response?.statusCode == 409) {
         return Result.failure(const AuthFailure.emailInUse());
       } else if (e.type == DioExceptionType.connectionTimeout ||
                  e.type == DioExceptionType.sendTimeout ||
                  e.type == DioExceptionType.receiveTimeout ||
                  e.type == DioExceptionType.connectionError) {
         return Result.failure(const AuthFailure.networkError());
       } else {
         // Generic server or bad response error
         return Result.failure(AuthFailure.serverError(message: e.message));
       }
    } catch (e, stackTrace) {
       _logger.e('Unexpected error during registration for email: $email', error: e, stackTrace: stackTrace);
       return Result.failure(AuthFailure.serverError(message: e.toString()));
    }
  }

  @override
  Future<Result<UserModel, AuthFailure>> login({
    required String email,
    required String password,
  }) async {
     try {
       _logger.i('Attempting login for email: $email');
       final userDto = await _apiService.login(email, password);
        _logger.i('Login successful for email: $email');
       return Result.success(userDto.toDomain());
     } on DioException catch (e) {
        _logger.e('Login failed for email: $email', error: e, stackTrace: e.stackTrace);
        if (e.response?.statusCode == 401) {
          return Result.failure(const AuthFailure.invalidCredentials());
        } else if (e.type == DioExceptionType.connectionTimeout ||
                   e.type == DioExceptionType.sendTimeout ||
                   e.type == DioExceptionType.receiveTimeout ||
                   e.type == DioExceptionType.connectionError) {
          return Result.failure(const AuthFailure.networkError());
        } else {
           return Result.failure(AuthFailure.serverError(message: e.message));
        }
     } catch (e, stackTrace) {
        _logger.e('Unexpected error during login for email: $email', error: e, stackTrace: stackTrace);
        return Result.failure(AuthFailure.serverError(message: e.toString()));
     }
  }

  @override
  Future<Result<UserModel, AuthFailure>> getUserProfile(String userId) async {
    // Implementation similar to register/login, calling appropriate ApiService method
    // and handling potential errors.
    try {
       _logger.i('Fetching profile for userId: $userId');
      // final userDto = await _apiService.getUserProfile(userId); // Assuming this method exists
      // _logger.i('Profile fetch successful for userId: $userId');
      // return Result.success(userDto.toDomain());
       await Future.delayed(const Duration(seconds: 1)); // Placeholder
       return Result.failure(const AuthFailure.serverError(message: "Not implemented")); // Placeholder
    } catch (e, stackTrace) {
        _logger.e('Profile fetch failed for userId: $userId', error: e, stackTrace: stackTrace);
       // Add proper error handling like above
       return Result.failure(const AuthFailure.serverError(message: "Fetch failed"));
    }
  }
}
```

/* ========================================================================
   === 3. APPLICATION LAYER (State Management) ============================
   ======================================================================== */

# Application Layer (State Management) Guidelines

## Directory Structure

```
lib/
  └── features/
      └── [feature_name]/
          └── application/          # Or presentation/bloc, presentation/cubit etc.
              ├── [feature_name]_cubit/ # Or bloc
              │   ├── [feature_name]_cubit.dart
              │   └── [feature_name]_state.dart
              └── usecases/           # Optional: If business logic is complex
                  └── [feature_use_case].dart
```
*Note: Some structures place state management within `presentation` as it directly serves the UI. Choose one structure and be consistent.*

## State Management Conventions (`flutter_bloc` / `Cubit`)

### State Class Structure (`freezed`)

1.  State classes must:
    *   Use `@freezed` annotation.
    *   Have a private `const constructor ._();`
    *   Have a `factory FeatureState.initial()` for the initial state.
    *   Be immutable.
    *   Represent the UI state clearly (loading, success, error, data).
    *   Include necessary data properties for the UI.
    *   **Recommended:** Use a dedicated `DataState<T>` or similar pattern for async operations status.

### Cubit/Bloc Class Structure

1.  Cubits/Blocs should:
    *   Have a single, clear responsibility (manage state for a specific feature/screen).
    *   Depend on Domain Repositories (or Use Cases) injected via DI (`injectable`).
    *   Extend `Cubit<FeatureState>` or `Bloc<FeatureEvent, FeatureState>`.
    *   Call repository methods and handle the `Result` (Success/Failure).
    *   Emit new states based on the operation outcome.
    *   Contain presentation-specific logic (transforming domain data if needed for UI).
    *   Use a `Logger` instance for logging state transitions and errors.

2.  Constructor:
    *   Accept required Repositories/Use Cases via parameters (`@Injectable` constructor).

### Use Case Structure (Optional)

1.  Use Cases encapsulate complex business logic involving one or more repositories.
2.  Should have a single public method (e.g., `call()`, `execute()`).
3.  Depend on Repository interfaces injected via DI.
4.  Return `Future<Result<T, F>>`.
5.  Keep Cubits/Blocs simpler by moving complex logic here.

## Naming Conventions

1.  Files:
    *   State file: `[feature_name]_state.dart`
    *   Cubit file: `[feature_name]_cubit.dart`
    *   Bloc file: `[feature_name]_bloc.dart`
    *   Event file (for Bloc): `[feature_name]_event.dart`
    *   Use Case file: `[use_case_name]_use_case.dart`
    *   Use `snake_case`.
2.  Classes:
    *   State class: `FeatureNameState`
    *   Cubit class: `FeatureNameCubit`
    *   Bloc class: `FeatureNameBloc`
    *   Event class: `FeatureNameEvent`
    *   Use Case class: `UseCaseNameUseCase`
    *   Use `PascalCase`.
3.  Methods (in Cubit/Bloc):
    *   Use clear, descriptive names reflecting user actions or events (e.g., `loadUserDetails()`, `submitRegistration()`, `retryFetch()`).

## State Properties & Patterns

1.  **Common State Properties (using `DataState` pattern):**
    ```dart
    enum Status { idle, loading, success, error }

    @freezed
    class DataState<T> with _$DataState<T> {
      const factory DataState.idle() = _Idle;
      const factory DataState.loading() = _Loading;
      const factory DataState.success(T data) = _Success<T>;
      const factory DataState.error(AuthFailure failure) = _Error; // Use specific Failure type
    }

    @freezed
    class FeatureState with _$FeatureState {
      const FeatureState._(); // Private constructor

      const factory FeatureState({
        @Default(DataState.idle()) DataState<UserModel> userProfileState,
        @Default(false) bool isRegistrationButtonEnabled,
        // Add other UI-specific state properties here
      }) = _FeatureState;

      // Helper getters for convenience in UI
      bool get isLoading => userProfileState is _Loading;
      bool get hasError => userProfileState is _Error;
      AuthFailure? get error => hasError ? (userProfileState as _Error).failure : null;
      UserModel? get userProfile => userProfileState is _Success<UserModel>
          ? (userProfileState as _Success<UserModel>).data : null;

      factory FeatureState.initial() => const FeatureState();
    }
    ```
2.  Handle different statuses (`loading`, `success`, `error`) explicitly in the Cubit/Bloc and UI.

## Error Handling

1.  Catch failures from Repositories/Use Cases (`Result.failure`).
2.  Map Failures to appropriate UI states (e.g., emit `state.copyWith(userProfileState: DataState.error(failure))`).
3.  Provide user-friendly error messages in the Presentation Layer based on the failure type. Consider using `slang` (Rule 02) for localized messages.

## Best Practices

1.  State Management:
    *   Keep state classes immutable (`freezed`).
    *   Use `DataState` or similar for async status.
    *   Emit new states rather than mutating existing ones.
    *   Cubits/Blocs should orchestrate calls to repositories/use cases and manage UI state, not contain complex business rules.
    *   Log state transitions and errors using `Logger`.
2.  Use Cases: Use them to simplify Blocs/Cubits when logic involves multiple steps or repositories.

## Testing Guidelines (Application Layer)

1.  Directory Structure:
    ```
    test/
      └── features/
          └── [feature_name]/
              └── application/
                  ├── [feature_name]_cubit/
                  │   └── [feature_name]_cubit_test.dart
                  └── usecases/
                      └── [feature_use_case]_test.dart # If using use cases
    ```
2.  Cubit/Bloc Testing:
    *   **Use `bloc_test` package.**
    *   Use `mocktail` to mock Repository/Use Case dependencies.
    *   Test initial state.
    *   Test state emissions for each method/event:
        *   Stub repository methods to return `Result.success` or `Result.failure`.
        *   Verify the sequence of emitted states using `expect:`.
        *   Verify repository methods were called using `verify(() => repository.method(...)).called(1)`.
    *   Test all possible success and failure paths.
    *   Aim for >99.99% coverage (Rule 02).
3.  Use Case Testing:
    *   Unit test the logic within the use case.
    *   Use `mocktail` to mock Repository dependencies.
    *   Verify success (`Result.success`) and failure (`Result.failure`) return values.
    *   Verify repository interactions.

## Code Example (Application Layer - Auth Cubit)

```dart
import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:logger/logger.dart';
// Assume Domain (IAuthRepository, UserModel, AuthFailure) and DataState are defined

part 'auth_state.dart'; // Contains FeatureState definition using DataState
part 'auth_cubit.freezed.dart'; // For FeatureState
part 'auth_cubit.g.dart';      // For FeatureState if needed

/// Cubit responsible for authentication state management.
@injectable // Register with GetIt/Injectable
class AuthCubit extends Cubit<AuthState> {
  final IAuthRepository _authRepository; // Inject repository interface
  final Logger _logger;             // Inject Logger

  AuthCubit(this._authRepository, this._logger) : super(AuthState.initial());

  /// Attempts user registration.
  Future<void> register({
    required String name,
    required String email,
    required String password,
  }) async {
    _logger.i('Registration attempt started for $email');
    // Emit loading state
    emit(state.copyWith(registrationState: const DataState.loading()));

    // Call repository method
    final result = await _authRepository.register(
      name: name,
      email: email,
      password: password,
    );

    // Emit success or error state based on result
    result.handle(
      onSuccess: (user) {
        _logger.i('Registration successful for $email');
        emit(state.copyWith(registrationState: DataState.success(user)));
        // Optionally update other parts of state, e.g., loggedInUserState
        emit(state.copyWith(loggedInUserState: DataState.success(user)));
      },
      onFailure: (failure) {
         _logger.w('Registration failed for $email: $failure');
        emit(state.copyWith(registrationState: DataState.error(failure)));
      },
    );
  }

  /// Attempts user login.
  Future<void> login({required String email, required String password}) async {
     _logger.i('Login attempt started for $email');
    emit(state.copyWith(loginState: const DataState.loading()));

    final result = await _authRepository.login(email: email, password: password);

    result.handle(
      onSuccess: (user) {
         _logger.i('Login successful for $email');
        emit(state.copyWith(
          loginState: DataState.success(user),
          loggedInUserState: DataState.success(user), // Update logged-in user state
        ));
      },
      onFailure: (failure) {
         _logger.w('Login failed for $email: $failure');
        emit(state.copyWith(loginState: DataState.error(failure)));
      },
    );
  }

   /// Fetches the current user's profile (example).
  Future<void> fetchUserProfile() async {
    // Check if user is already loaded
    final currentUser = state.loggedInUser;
    if (currentUser == null) {
       _logger.w('Cannot fetch profile, no user logged in.');
       // Handle appropriately, maybe emit an error or redirect
       emit(state.copyWith(loggedInUserState: DataState.error(const AuthFailure.invalidCredentials()))); // Or a different failure
       return;
    }

     _logger.i('Fetching profile for user ${currentUser.id}');
    emit(state.copyWith(loggedInUserState: const DataState.loading())); // Show loading for profile update

    final result = await _authRepository.getUserProfile(currentUser.id);

     result.handle(
      onSuccess: (user) {
         _logger.i('Profile fetch successful for ${user.id}');
        emit(state.copyWith(loggedInUserState: DataState.success(user)));
      },
      onFailure: (failure) {
         _logger.w('Profile fetch failed for ${currentUser.id}: $failure');
        emit(state.copyWith(loggedInUserState: DataState.error(failure)));
      },
    );
  }

  /// Logs out the current user.
  void logout() {
     _logger.i('User logout initiated.');
    // Clear user-related state
    emit(AuthState.initial()); // Reset to initial state or a specific logged-out state
     _logger.i('User logged out.');
    // Potentially clear secure storage, navigate, etc. (via listeners in UI)
  }
}

// Example AuthState (in auth_state.dart)
@freezed
class AuthState with _$AuthState {
  const AuthState._();

  const factory AuthState({
    @Default(DataState.idle()) DataState<UserModel> registrationState,
    @Default(DataState.idle()) DataState<UserModel> loginState,
    @Default(DataState.idle()) DataState<UserModel> loggedInUserState,
    // Add other UI-specific flags, e.g., form validation status
  }) = _AuthState;

  factory AuthState.initial() => const AuthState();

  // Helper getters
  bool get isRegistering => registrationState is _Loading;
  bool get isLoggingIn => loginState is _Loading;
  bool get isLoggedIn => loggedInUserState is _Success<UserModel>;
  UserModel? get loggedInUser => loggedInUserState is _Success<UserModel>
      ? (loggedInUserState as _Success<UserModel>).data
      : null;
}
```


/* ========================================================================
   === 4. PRESENTATION LAYER ===============================================
   ======================================================================== */

# Presentation Layer Guidelines

## Directory Structure

```
lib/
  └── features/
      └── [feature_name]/
          └── presentation/
              ├── pages/                  # Top-level screens/routes
              │   └── [feature_name]_page.dart
              ├── widgets/                # Reusable widgets specific to this feature
              │   └── [feature_name]_widget.dart
              │   └── login_form.dart     # Example: Specific component
              └── bloc/                   # Or cubit - Can be here or in application/
                  └── [feature_name]_cubit/ # (As shown in Application Layer section)
                      ├── [feature_name]_cubit.dart
                      └── [feature_name]_state.dart
```

## Presentation Layer Conventions

### Page Structure (`StatelessWidget` or `HookWidget`)

1.  Pages should:
    *   Typically be `StatelessWidget` or `HookWidget` (using `flutter_hooks` - Rule 02). Avoid `StatefulWidget` unless managing complex local UI state not suitable for Bloc/Cubit (e.g., complex animations).
    *   Provide the `BlocProvider` (or `MultiBlocProvider`) for the required Cubits/Blocs at the top of the widget tree for this feature/page.
    *   Delegate UI building based on state to specific view/content widgets.
    *   Handle navigation logic (potentially using `BlocListener` for navigation side effects).

### View/Widget Structure

1.  Widgets must:
    *   Be small and have a single responsibility (SRP - Rule 02).
    *   Use `BlocBuilder`, `BlocSelector`, or `context.watch<Cubit>()` to react to state changes and rebuild the UI.
    *   Use `BlocListener` or `context.read<Cubit>()` for triggering actions/side effects (showing Snackbars, navigation, calling Cubit methods) without rebuilding.
    *   Use layout constants from `KSizes` (Rule 02) for all padding, margins, font sizes, spacing, etc. Use `Gap` widget (Rule 02) for spacing.
    *   Use named parameters for clarity.
    *   Include documentation (`///`).
    *   Use `Key` parameters for testing and widget identification.
    *   Get assets via `flutter_gen` (Rule 02) generated code (e.g., `Assets.images.logo.svg()`).
    *   Get localized strings via `slang` (Rule 02) generated code (e.g., `t.login.title`).
    *   **Use color definitions exclusively from the `AppColors` class (`lib/core/styles/colors/app_colors.dart`). Never use the standard `Colors` class directly.**

## Naming Conventions

### Files

1.  Page files:
    *   Use `_page.dart` suffix.
    *   Use `snake_case`.
    *   Be descriptive (e.g., `user_profile_page.dart`).
2.  Widget files:
    *   Use `_widget.dart` suffix (optional if name is descriptive, e.g., `login_form.dart`).
    *   Use `snake_case`.
    *   Describe the widget's purpose (e.g., `user_avatar_widget.dart`).

### Classes

1.  Page classes:
    *   Use `PascalCase`.
    *   End with 'Page'.
    *   Match their file names (without suffix).
2.  Widget classes:
    *   Use `PascalCase`.
    *   Be descriptive (e.g., `LoginForm`, `UserProfileHeader`).
    *   Match their file names.

## Code Organization

1.  Pages:
    *   One main page widget per file in `presentation/pages/`.
    *   Setup `BlocProvider` here.
2.  Widgets:
    *   Group related widgets in `presentation/widgets/`.
    *   Extract complex parts of a page into smaller, reusable widgets.
    *   Keep widgets focused. If a widget becomes too complex (>50-100 lines), break it down further.

## Best Practices

1.  Layout:
    *   **Strictly use `KSizes` constants and `Gap` widget (Rule 02)** for all dimensions, spacing, padding, margins, font sizes, radii. **No magic numbers.**
    *   **Use `AppColors` for all color definitions. Never use Flutter's `Colors` class directly.**
    *   Build responsive layouts considering different screen sizes. `flutter_screenutil` can help (Rule 02).
2.  State Consumption:
    *   Use `BlocBuilder`/`context.watch` only for widgets that need to rebuild based on state changes.
    *   Use `BlocSelector` to rebuild only when specific parts of the state change.
    *   Use `BlocListener`/`context.read` for actions that don't require a rebuild (button presses, showing dialogs).
    *   Keep build methods pure and fast.
3.  Error Handling:
    *   Use `BlocListener` to show user-friendly error messages (e.g., `SnackBar`, `Dialog`) based on the error state from the Cubit/Bloc. Use `slang` for localized messages.
    *   Provide clear feedback for loading states (e.g., `CircularProgressIndicator`).
    *   Implement retry mechanisms where appropriate (e.g., a button in the error widget that calls the Cubit's retry method).

## Testing Guidelines (Presentation Layer)

1.  Directory Structure:
    ```
    test/
      └── features/
          └── [feature_name]/
              └── presentation/
                  ├── pages/
                  │   └── [feature_name]_page_test.dart
                  └── widgets/
                      └── [feature_name]_widget_test.dart
                      └── login_form_test.dart
    ```
2.  Widget Testing:
    *   **Use `flutter_test` and `bloc_test` (`MockBloc` / `MockCubit`).**
    *   Test that widgets render correctly for different states (initial, loading, success, error).
    *   Use `MockBloc` or `MockCubit` from `bloc_test` to provide specific states to the widget under test.
    *   Verify that UI elements display the correct data from the state.
    *   Simulate user interactions (e.g., `tester.tap()`, `tester.enterText()`).
    *   Verify that interactions trigger the correct Cubit/Bloc methods using `verify(() => cubit.method(...)).called(1)`.
    *   Use `find.byKey()` extensively for reliable widget finding. Assign `Key`s in the widget code.
    *   Test form validation logic.
    *   Aim for >99.99% coverage (Rule 02).
3.  Page/Integration Testing:
    *   Test the integration of multiple widgets on a page.
    *   Test navigation flows triggered by state changes (using `MockNavigator` or integration testing tools).

## Code Example (Presentation Layer - Auth Page/Widgets)

```dart
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart'; // Use Gap for spacing (Rule 02)
import 'package:ksk_app/core/styles/colors/app_colors.dart'; // Import AppColors
// Assume KSizes (Rule 02), AuthCubit, AuthState, DataState are defined/imported
// Assume t (slang Rule 02) is available for localization
// Assume Assets (flutter_gen Rule 02) is available for assets

/// Provides the AuthCubit to the widget tree.
class AuthPage extends StatelessWidget {
  const AuthPage({super.key});

  @override
  Widget build(BuildContext context) {
    // Assuming AuthCubit is already provided higher up or using GetIt page provider setup
    // If not, provide it here:
    // return BlocProvider(
    //   create: (context) => getIt<AuthCubit>(), // Using GetIt/Injectable
    //   child: const AuthView(),
    // );
    return const AuthView(); // Assuming Cubit is provided above
  }
}

/// Displays the main authentication view (Login or Registration).
class AuthView extends StatelessWidget {
  const AuthView({super.key});

  @override
  Widget build(BuildContext context) {
    // Use BlocListener for side effects like showing errors or navigating
    return BlocListener<AuthCubit, AuthState>(
      listener: (context, state) {
        // Listen for login errors
        if (state.loginState is _Error) {
          final failure = (state.loginState as _Error).failure;
          // Map failure to user-friendly message (use slang/t for localization)
          final errorMessage = failure.map(
              serverError: (_) => "t.errors.server", // Example localization key
              invalidCredentials: (_) => "t.errors.invalidCredentials",
              emailInUse: (_) => "t.errors.emailInUse", // Should not happen on login
              networkError: (_) => "t.errors.network",
          );
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(SnackBar(
              content: Text(errorMessage),
              backgroundColor: AppColors.error, // Use AppColors instead of Colors
            ));
        }
        // Listen for successful login/registration to navigate
        if (state.isLoggedIn) {
           _showSuccessDialog(context, "t.auth.loginSuccessTitle");
          // Potentially navigate: Navigator.of(context).pushReplacementNamed('/home');
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text("t.auth.title"), // Localized title
          backgroundColor: AppColors.primary, // Use AppColors
        ),
        body: Padding(
          padding: EdgeInsets.all(KSizes.p16), // Use KSizes constants
          child: Center(
            // Use BlocBuilder to rebuild UI based on state
            child: BlocBuilder<AuthCubit, AuthState>(
              builder: (context, state) {
                // Show loading indicator during login/registration
                if (state.isLoggingIn || state.isRegistering) {
                  return CircularProgressIndicator(
                    color: AppColors.primary, // Use AppColors
                  );
                }
                // Show login form (example)
                return const LoginForm();
                // Could switch between LoginForm and RegisterForm based on UI state
              },
            ),
          ),
        ),
      ),
    );
  }

  // Helper for showing dialog
  void _showSuccessDialog(BuildContext context, String titleKey) {
     showDialog(
       context: context, 
       builder: (_) => AlertDialog(
         title: Text(titleKey),
         content: Text("t.auth.successContent"),
         backgroundColor: AppColors.bgMain, // Use AppColors
         actions: [
           TextButton(
             onPressed: () => Navigator.pop(context),
             child: Text("t.common.ok", style: TextStyle(color: AppColors.primary)), // Use AppColors
           )
         ],
       ),
     );
  }
}

/// A reusable Login Form widget.
class LoginForm extends StatefulWidget {
  // Use StatefulWidget for local form state management (controllers, focus nodes)
  const LoginForm({super.key = const Key('login_form')}); // Add Key

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final _formKey = GlobalKey<FormState>(); // Key for form validation
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _submitLogin() {
    // Validate the form first
    if (_formKey.currentState?.validate() ?? false) {
      // Read Cubit and call login method
      context.read<AuthCubit>().login(
            email: _emailController.text.trim(),
            password: _passwordController.text.trim(),
          );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Use Asset generated by flutter_gen
          // Assets.images.logo.image(height: KSizes.s100),
          // Gap(KSizes.g32), // Use Gap for spacing

          TextFormField(
            key: const Key('login_email_field'), // Key for testing
            controller: _emailController,
            decoration: InputDecoration(
              labelText: "t.auth.emailLabel",
              labelStyle: TextStyle(color: AppColors.textPrimary), // Use AppColors
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: AppColors.primary), // Use AppColors
              ),
            ),
            keyboardType: TextInputType.emailAddress,
            validator: (value) {
              if (value == null || value.isEmpty || !value.contains('@')) {
                return "t.validation.invalidEmail"; // Localized error
              }
              return null;
            },
          ),
          Gap(KSizes.g16), // Use Gap

          TextFormField(
             key: const Key('login_password_field'), // Key for testing
            controller: _passwordController,
            decoration: InputDecoration(
              labelText: "t.auth.passwordLabel",
              labelStyle: TextStyle(color: AppColors.textPrimary), // Use AppColors
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: AppColors.primary), // Use AppColors
              ),
            ),
            obscureText: true,
             validator: (value) {
              if (value == null || value.isEmpty || value.length < 6) {
                return "t.validation.passwordTooShort"; // Localized error
              }
              return null;
            },
          ),
          Gap(KSizes.g32),

          // Use context.watch only if button state depends on Cubit state
          // Otherwise, use context.read in the onPressed callback
          ElevatedButton(
             key: const Key('login_button'), // Key for testing
            // Disable button while logging in using context.watch or BlocBuilder
            // onPressed: context.watch<AuthCubit>().state.isLoggingIn ? null : _submitLogin,
            onPressed: _submitLogin, // Simpler if button doesn't disable
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primary, // Use AppColors
              foregroundColor: AppColors.white, // Use AppColors
              minimumSize: Size.fromHeight(KSizes.buttonHeightDefault), // Use KSizes
            ),
            child: Text("t.auth.loginButton"),
          ),
          Gap(KSizes.g16),
          TextButton(
            onPressed: () {
              // Handle navigation to registration or switch form
               _logger.i('Navigate to register'); // Use logger
            },
            style: TextButton.styleFrom(
              foregroundColor: AppColors.primary, // Use AppColors
            ),
            child: Text("t.auth.registerPrompt"),
          ),
        ],
      ),
    );
  }
}

// Placeholder for Logger instance (should be injected/provided globally)
final _logger = Logger();
```

---

*End of Updated Coding Generation Guide.*