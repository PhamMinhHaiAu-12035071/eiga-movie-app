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
- **flutter_secure_storage**: Secure key-value storage

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

### UI/UX Technologies
- **Material Design 3**: Design principles and components
- **Responsive Design**: flutter_screenutil
- **Animations**: flutter_animate, lottie
- **SVG Support**: flutter_svg
- **Image Handling**: cached_network_image
- **Custom Theming**: Theme extensions

### Modern API Usage
- **Color API**: Using modern component accessors (r, g, b, a) instead of deprecated properties
- **Material 3 Components**: Using latest widget patterns
- **Null Safety**: Fully implemented throughout the codebase

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
├── core/                       # Core utilities and shared functionality
│   ├── di/                     # Dependency Injection
│   ├── router/                 # Navigation
│   ├── asset/                  # Asset management
│   ├── styles/                 # UI styles definitions (colors, text styles)
│   ├── sizes/                  # Size and dimension constants
│   ├── durations/              # Duration constants for animations and transitions
│   └── themes/                 # Theme management
│       ├── extensions/         # Theme extensions for assets, colors, etc.
│       │   └── extensions.dart # Barrel file for all theme extensions
│       ├── app_theme.dart      # Main theme configuration
│       └── themes.dart         # Barrel file for all theme exports
├── features/                   # Feature modules
│   ├── env/                    # Environment configuration feature
│   ├── onboarding/             # Onboarding feature
│   ├── login/                  # Login feature
│   └── storage/                # Storage feature
├── shared/                     # Shared components
├── generated/                  # Generated code
├── app.dart                    # Main application widget
└── bootstrap.dart              # Application initialization
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
- **mocktail**: Mocking framework for creating test doubles
- **get_it**: Used for dependency injection in tests

### Widget Testing
- **flutter_test**: Provides widget testing utilities
- **mocktail**: For mocking dependencies in widget tests
- **golden_toolkit**: For screenshot/UI testing (planned)
- **robot_pattern**: Custom implementation for test organization

### Test Organization
```
test/
├── core/                     # Tests for core functionality
│   ├── di/                   # DI tests
│   ├── router/               # Router tests
│   ├── styles/               # Styles tests
│   ├── sizes/                # Sizes tests
│   ├── durations/            # Durations tests
│   ├── themes/               # Theme tests
│   └── asset/                # Asset tests
├── features/                 # Feature-specific tests
│   └── [feature_name]/       # Tests for specific feature
│       ├── domain/           # Domain layer tests
│       ├── application/      # Application layer tests
│       ├── infrastructure/   # Infrastructure layer tests
│       └── presentation/     # Presentation layer tests
├── shared/                   # Tests for shared components
│   └── helpers/              # Test helpers
└── integration/              # Integration tests
```

### Test Patterns
- **Mock Implementation Standards**:
  - Explicit return types for all function declarations
  - Boolean parameters made nullable with default values
  - Full interface implementation for visual components
  - Proper type hierarchies (MaterialColor vs Color)
  - Factory constructors over static methods
  - Proper error handling in mock implementations

- **Widget Test Structure**:
  ```dart
  group('Component Tests', () {
    setUp(() {
      // GetIt registration
      // Mock initialization
      // Test data setup
    });

    tearDown(() {
      // Controller disposal
      // GetIt cleanup
    });

    testWidgets('test case', (tester) async {
      // Widget setup
      // Action simulation
      // Verification
    });
  });
  ```

- **Standard Test Cases**:
  - Basic rendering verification
  - User interaction handling
  - Error state management
  - Style and layout verification
  - Edge cases (empty states, rapid interactions)
  - Animation and transition testing

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

# Run tests with tags
fvm flutter test --tags="unit"
```

### Test Helpers
- Helper classes for common test operations
- Mock implementations using mocktail
- Fake implementations for simple scenarios
- Error-throwing implementations to test failure cases
- Empty implementations to test boundary conditions

### Current Testing Metrics
- Overall project: ~65% coverage (improving)
- Storage Feature: 100% (achieved)
- Environment Feature: 100% (achieved)
- OnboardingPageView: 100% (achieved)
- OnboardingDotIndicator: 100% (achieved)
- Core Modules: ~70% (improving)

### Testing Challenges
- Widget Finding: Multiple instances of similar widgets requiring specific finders
- Style Testing: Null safety in decoration testing, proper type casting
- Test Performance: Some widget tests are slower than desired
- Coverage Gaps: Integration test coverage below target, some edge cases not covered

### Testing Focus
1. Complete widget tests for remaining onboarding components
2. Implement integration tests for full onboarding flow
3. Document established test patterns for team reference
4. Optimize test performance and execution time
5. Implement visual regression testing for key components

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
   - Fast movie list scrolling with image caching

2. **Compatibility**:
   - Android API level 21+ (Android 5.0+)
   - iOS 12.0+
   - Web (modern browsers)

3. **Network**:
   - Must work with intermittent connectivity
   - Graceful handling of API failures
   - Data synchronization when connectivity is restored
   - Movie poster and trailer caching for offline viewing

4. **Security**:
   - Secure storage of sensitive information
   - API authentication
   - Input validation
   - Environment variable obfuscation
   - Secure payment information handling

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
   - Configured for movie app API endpoints (eigamovie.com)

2. **Storage Feature** (100% Complete):
   - Provides abstraction for local storage operations
   - Uses SharedPreferences for persistent storage
   - Implements functional error handling
   - Comprehensive test coverage

3. **Onboarding Feature** (92% Complete):
   - Handles user onboarding flow with movie-themed content
   - "Choose movies, watch trailers, take tickets" messaging
   - "Find Your Favorite Movies" feature highlight
   - "Book movie tickets anytime, anywhere" feature highlight
   - Persists onboarding status
   - UI components based on design specifications
   - Tests in progress

4. **Login Feature** (35% Complete):
   - Basic welcome screen implemented with EIGA branding
   - "Welcome to EIGA!" welcome message
   - "Your movie journey begins here" subtitle
   - State management setup
   - Authentication logic in planning

5. **Movie Listing Feature** (0% Complete):
   - Planning phase - not yet implemented
   - Will display popular and upcoming movies
   - Will include search and filtering functionality
   - Domain models and repositories in design

6. **Ticket Booking Feature** (0% Complete):
   - Planning phase - not yet implemented
   - Will include seat selection interface
   - Will handle theater, date, and time selection
   - Domain models in early design