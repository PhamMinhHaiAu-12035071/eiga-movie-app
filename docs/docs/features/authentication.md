---
sidebar_position: 1
title: Authentication
description: Authentication and authorization in the KSK App
---

# Authentication

The authentication module in KSK App handles user login, registration, and authorization.

## Features

- User login
- User registration
- Session management
- Role-based access control
- Secure token storage

## Architecture

### Domain Layer

#### Entities

- `User` - Represents a user in the system
- `AuthCredentials` - Contains authentication credentials
- `AuthToken` - Contains authentication tokens (access, refresh)

#### Repository Interface

```dart
abstract class AuthRepository {
  Future<Either<AuthFailure, AuthToken>> login(AuthCredentials credentials);
  Future<Either<AuthFailure, Unit>> register(User user, String password);
  Future<Either<AuthFailure, User>> getCurrentUser();
  Future<Either<AuthFailure, Unit>> logout();
  Future<bool> isAuthenticated();
}
```

### Application Layer

#### UseCases

- `LoginUseCase` - Handles user login
- `RegisterUseCase` - Handles user registration
- `GetCurrentUserUseCase` - Retrieves the current user
- `LogoutUseCase` - Handles user logout

#### State Management

The authentication state is managed using the Bloc pattern:

```dart
class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final LoginUseCase _loginUseCase;
  final RegisterUseCase _registerUseCase;
  final GetCurrentUserUseCase _getCurrentUserUseCase;
  final LogoutUseCase _logoutUseCase;
  
  // Implementation details...
}
```

### Infrastructure Layer

#### Repository Implementation

```dart
@Injectable(as: AuthRepository)
class AuthRepositoryImpl implements AuthRepository {
  final AuthApiClient _apiClient;
  final SecureStorage _secureStorage;
  
  // Implementation details...
}
```

### Presentation Layer

The authentication UI includes:

- Login screen
- Registration screen
- Profile screen

## Usage

### Login Flow

1. User enters credentials
2. The credentials are validated on the client
3. The LoginUseCase is called with the credentials
4. On success, tokens are stored securely
5. The user is redirected to the home screen

### Session Management

- The app stores tokens securely using `flutter_secure_storage`
- A token refresh mechanism handles token expiration
- Auto-login is implemented if valid tokens exist

## Security Considerations

- Credentials are never stored on the device
- Tokens are stored in secure storage
- HTTPS is used for all API calls
- Tokens have an expiration time
- Sensitive information is not logged 