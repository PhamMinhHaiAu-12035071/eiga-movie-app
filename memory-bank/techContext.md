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
- **envied**: Type-safe environment variables

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
- Environment variables stored in `.env` files
- Separate configurations for development, staging, and production

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

### Test Commands
```bash
# Run all tests
fvm flutter test

# Run tests with coverage
fvm flutter test --coverage

# Generate coverage report
genhtml coverage/lcov.info -o coverage/
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
   - Core Modules: 90%+ (target)

## Build and Deployment

// ... existing code ... 