# Technical Context

## Technology Stack

### Framework
- **Flutter**: Cross-platform UI toolkit (v3.5.0+)
- **Dart**: Programming language (v3.5.0+)

### State Management
- **flutter_bloc/bloc**: Implementation of the BLoC pattern
- **equatable**: Simplifies equality comparisons for immutable objects

### Dependency Injection
- **get_it**: Service locator for dependency injection
- **injectable**: Code generation for get_it

### Routing
- **auto_route**: Type-safe routing with code generation

### API Communication
- **dio**: HTTP client for Dart
- **chopper**: Type-safe HTTP client with code generation
- **pretty_chopper_logger**: Logging HTTP requests and responses

### Data Modeling
- **freezed**: Code generation for immutable models
- **json_serializable**: JSON serialization/deserialization
- **json_annotation**: Annotations for JSON serialization

### UI Components
- **flutter_screenutil**: Responsive UI scaling
- **gap**: Simple spacing widget
- **google_fonts**: Access to Google Fonts

### Storage
- **shared_preferences**: Persistent key-value storage

### Environment Configuration
- **envied**: Type-safe environment variables with obfuscation

### Localization
- **slang**: Type-safe localization with code generation

### Utilities
- **dartx**: Extension methods for Dart classes
- **rxdart**: Extensions for reactive programming
- **basic_utils**: Utility functions
- **nil**: Null-safety utilities
- **logger**: Structured logging
- **after_layout**: Callback after first layout
- **flutter_hooks**: React-like hooks for Flutter

### Device Information
- **package_info_plus**: Access to app package information
- **device_info_plus**: Access to device information
- **path_provider**: Access to file system locations

## Development Setup

### Required Tools
- Flutter SDK (v3.5.0+)
- Dart SDK (v3.5.0+)
- FVM (Flutter Version Management)
- Android Studio / VS Code with Flutter/Dart plugins
- Git

### Environment Configuration
- Environment variables stored in `.env` files (e.g., `.env.dev`)
- Separate configurations for development, staging, and production
- Accessed through a dedicated environment feature using Clean Architecture

### Local Development
```bash
# Use correct Flutter version
fvm use

# Install dependencies
fvm flutter pub get

# Generate code
fvm flutter pub run build_runner build --delete-conflicting-outputs

# Run in development mode
fvm flutter run --flavor development --target lib/main_development.dart
```

## Project Structure
The project follows a feature-first organization with Clean Architecture:

```
lib/
├── core/                     # Core utilities and shared functionality
│   ├── di/                   # Dependency injection
│   ├── router/               # Navigation
│   ├── styles/               # UI styles
│   ├── sizes/                # Size constants
│   └── durations/            # Animation durations
├── features/                 # Feature modules
│   ├── env/                  # Environment configuration feature
│   ├── onboarding/           # Onboarding feature
│   ├── login/                # Login feature
│   └── storage/              # Storage feature
├── app.dart                  # Main application widget
└── bootstrap.dart            # Application initialization
```

## Build & Deployment

### Android
- Multiple flavors (development, staging, production)
- APK and AAB build support

### iOS
- Multiple schemes (development, staging, production)
- TestFlight deployment support

### Web
- Progressive Web App support
- Firebase hosting configuration

## Testing Infrastructure

### Unit Testing
- **flutter_test**: Flutter's built-in testing framework
- **bloc_test**: Testing utilities for BLoC
- **mocktail**: Mocking framework

### Test Organization
- Tests mirror production code structure with feature-first organization
- Domain tests focus on interface contracts and validation
- Infrastructure tests verify implementation details
- Integration tests check the whole feature flow
- Edge case tests for error handling scenarios

### Test Patterns
- Helper classes for common test operations
- Mock implementations using mocktail
- Fake implementations for simple scenarios
- Error-throwing implementations to test failure cases
- Empty implementations to test boundary conditions

### Test Commands
```bash
# Run all tests
fvm flutter test

# Run tests with coverage
fvm flutter test --coverage

# Generate coverage report
genhtml coverage/lcov.info -o coverage/

# Run specific feature tests
fvm flutter test test/features/env/
```

## CI/CD Pipeline

### Continuous Integration
- Static code analysis with `very_good_analysis`
- Automated testing on pull requests
- Code coverage reporting

### Continuous Deployment
- Automated builds for each environment
- Deployment to test devices
- Release management

## Technical Constraints

1. **Performance**: 
   - Minimize app startup time (<2s)
   - Smooth animations (60fps)
   - Efficient memory usage

2. **Compatibility**:
   - Android API level 21+ (Android 5.0+)
   - iOS 12.0+
   - Web (modern browsers)

3. **Network**:
   - Must work with intermittent connectivity
   - Graceful handling of API failures
   - Data synchronization when connectivity is restored

4. **Security**:
   - Secure storage of sensitive information
   - API authentication
   - Input validation
   - Environment variable obfuscation

5. **Accessibility**:
   - Support for screen readers
   - Color contrast compliance
   - Keyboard navigation support 

## Development Tools

### Testing Tools
- **Flutter Test**: Core testing framework for Flutter
- **Mocktail**: Mocking library for creating test doubles
- **FPDart**: Functional programming library used for handling errors with Either
- **LCOV**: Coverage reporting tool integrated with Makefile
- **GoldenToolkit**: For screenshot/UI testing (planned)

### Code Coverage Process
The project uses a standardized approach to tracking and generating code coverage:

1. **Running Tests with Coverage**:
   - Use `make test` to run all tests
   - Use `make coverage` to generate and view coverage reports

2. **Coverage Reports**:
   - Generate HTML reports using lcov and genhtml
   - Reports show line coverage percentages
   - Easily viewable in browser

3. **Coverage Targets**:
   - Overall project: 80%+ (target)
   - Storage Feature: 100% (achieved)
   - Environment Feature: 100% (achieved)
   - Core Modules: 90%+ (target)

## Feature Implementation Status

1. **Environment Feature** (100% Complete):
   - Provides configuration based on the running environment
   - Uses envied for secure access to environment variables
   - Clean Architecture with domain and infrastructure layers
   - Comprehensive test coverage

2. **Storage Feature** (100% Complete):
   - Provides abstraction for local storage operations
   - Uses SharedPreferences for persistent storage
   - Implements functional error handling
   - Comprehensive test coverage

3. **Onboarding Feature** (92% Complete):
   - Handles user onboarding flow
   - Persists onboarding status
   - UI components based on design specifications
   - Tests in progress

4. **Login Feature** (35% Complete):
   - Basic welcome screen implemented
   - State management setup
   - Authentication logic in planning