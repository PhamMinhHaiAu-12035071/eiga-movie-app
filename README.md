# 📦 EIGA Movie App

![coverage][coverage_badge]
[![style: very good analysis][very_good_analysis_badge]][very_good_analysis_link]
[![License: MIT][license_badge]][license_link]

A Flutter app that allows users to browse movies, watch trailers, and book tickets using a modern, high-performance, and maintainable architecture.

## 📦 Project Structure (Clean Architecture)

The application applies Clean Architecture and organizes the source code in a feature-first structure:

```
lib/
├── core/                         # Common system configurations
│   ├── di/                      # Dependency Injection (GetIt, Injectable)
│   ├── router/                  # Navigation (auto_route)
│   ├── asset/                   # Asset management
│   ├── services/                # Service abstractions and implementations
│   ├── styles/                  # UI styles definitions
│   │   ├── colors/             # Color definitions and extensions
│   │   └── app_text_styles.dart # Text style definitions
│   ├── sizes/                   # Size and dimension constants
│   ├── durations/              # Duration constants for animations and transitions
│   └── themes/                  # Theme management
│       ├── extensions/         # Theme extensions for assets, colors, etc.
│       │   └── extensions.dart # Barrel file for all theme extensions
│       ├── app_theme.dart      # Main theme configuration
│       └── themes.dart         # Barrel file for all theme exports
├── features/                    # Separate functionalities (feature-first)
│   ├── env/                    # Environment configuration feature
│   │   ├── domain/            # Environment repository interface
│   │   ├── infrastructure/    # Environment repository implementation 
│   │   └── env_development.dart # Environment variables and configuration
│   └── [feature_name]/          
│       ├── domain/             # Business entities and repository interfaces
│       ├── application/        # State management, use cases
│       ├── infrastructure/     # Repository implementations
│       └── presentation/       # UI Widgets, Pages, Route bindings
├── shared/                      # Shared components
│   └── widgets/                 # Reusable widgets
├── generated/                   # Generated code (assets, translations)
├── app.dart                     # Main application widget
├── bootstrap.dart               # Application initialization  
├── main_development.dart        # Entry point for development
├── main_staging.dart            # Entry point for staging
└── main_production.dart         # Entry point for production
```

Each feature may come with a `README.md` file describing its functionality, main logic, and related APIs.

## 🚀 Implemented Features

### 🌟 Onboarding (92% Complete)

The onboarding feature provides new users with an introduction to the app's key features:

- **Domain Layer**: `OnboardingInfo` model and `OnboardingRepository` interface
- **Infrastructure Layer**: `OnboardingRepositoryImpl` for persistence with SharedPreferences
- **Application Layer**: `OnboardingCubit` for state management
- **Presentation Layer**: 
  - `OnboardingPage`: Main screen with page navigation
  - Reusable widgets: `OnboardingPageView`, `OnboardingDotIndicator`, `OnboardingHeader`, `OnboardingNextButton`

The onboarding showcases key app features:
- "Choose movies, watch trailers, take tickets"
- "Find Your Favorite Movies"
- "Book movie tickets anytime, anywhere with just a few taps"

### 🔐 Environment (100% Complete)

Provides configuration based on the running environment:

- Uses `envied` for secure access to environment variables
- Clean Architecture with domain and infrastructure layers
- Comprehensive test coverage
- Configured for movie app API endpoints

### 💾 Storage (100% Complete)

Provides abstraction for local storage operations:

- Uses `SharedPreferences` for persistent storage
- Implements functional error handling with `fpdart`
- Comprehensive test coverage
- Follows Clean Architecture principles

### 🔍 Login (35% Complete)

Currently includes:
- Basic welcome screen with EIGA branding
- "Welcome to EIGA!" welcome message
- "Your movie journey begins here" subtitle
- State management setup with Cubit

## 🧮 Functional Programming

The app leverages the `fpdart` library to implement functional programming concepts:

- **Either type**: Represents operations that can succeed or fail with explicit error types
- **Option type**: Replaces nullable values with a more type-safe approach
- **Task type**: Manages asynchronous operations with better composability

Example usage pattern:

```dart
// Repository method returning Either type
Future<Either<Failure, List<Movie>>> getMovies() async {
  try {
    final result = await _apiClient.get('/movies');
    return right(result.map((json) => Movie.fromJson(json)).toList());
  } on NetworkException catch (e) {
    return left(NetworkFailure(e.message));
  } on ServerException catch (e) {
    return left(ServerFailure(e.message));
  } catch (e) {
    return left(UnexpectedFailure(e.toString()));
  }
}

// Cubit handling Either results
Future<void> loadMovies() async {
  emit(state.copyWith(status: MovieStatus.loading));
  
  final result = await _movieRepository.getMovies();
  
  result.fold(
    (failure) => emit(state.copyWith(
      status: MovieStatus.error,
      errorMessage: failure.message,
    )),
    (movies) => emit(state.copyWith(
      status: MovieStatus.loaded, 
      movies: movies,
    )),
  );
}
```

## 🚀 Getting Started

The project consists of 3 configuration environments:

- ✅ **development** (default)
- 🛠️ **staging**
- 🚀 **production**

Run the app in different environments:

```bash
# Development
fvm flutter run --flavor development --target lib/main_development.dart

# Staging
fvm flutter run --flavor staging --target lib/main_staging.dart

# Production
fvm flutter run --flavor production --target lib/main_production.dart
```

## 🔐 Environment Configuration

The project uses `envied` for secure environment variable handling. Environment variables are stored in `.env` files and accessed through generated Dart code following Clean Architecture principles.

### 📁 Environment Files Structure

```
lib/features/env/
├── domain/                 # Environment repository interface
│   └── env_config_repository.dart
├── infrastructure/         # Environment repository implementation
│   └── env_config_repository_impl.dart
├── .env.dev                # Development environment variables 
└── env_development.dart    # Generated environment code for development
```

### 🛠️ Environment Setup

1. Create environment class:
```dart
@Envied(path: 'lib/features/env/.env.dev', obfuscate: true)
abstract class EnvDev {
  @EnviedField(varName: 'API_URL')
  static String apiUrl = _EnvDev.apiUrl;

  @EnviedField(varName: 'APP_NAME')
  static String appName = _EnvDev.appName;
}
```

2. Generate environment code:
```bash
fvm flutter pub run build_runner build
```

3. Access environment variables through repository:
```dart
@LazySingleton(as: EnvConfigRepository)
class EnvConfigRepositoryImpl implements EnvConfigRepository {
  @override
  String get apiUrl => EnvDev.apiUrl;
  
  @override
  String get appName => EnvDev.appName;
}
```

## 📦 Key Dependencies

| Package                     | Role in the project                           |
|-----------------------------|-----------------------------------------------|
| **flutter_bloc, bloc**      | State management (BLoC pattern)              |
| **get_it, injectable**      | Automatic Dependency Injection                 |
| **dio, chopper**            | Powerful and flexible networking               |
| **pretty_chopper_logger**   | Logging HTTP requests & responses             |
| **freezed, json_serializable, json_annotation** | Create immutable models, automatic JSON conversion |
| **equatable**               | Convenient object comparison, more efficient  |
| **auto_route**              | Code-generated navigation system with nested routing & guards |
| **rxdart**                  | Reactive programming, advanced Stream handling |
| **flutter_screenutil**      | Responsive UI scaling based on screen size     |
| **slang, slang_build_runner** | Type-safe, code-generated localization system |
| **basic_utils**             | Collection of utility functions for common operations |
| **nil**                     | Null-safety utilities for clean, expressive code |
| **gap**                     | Simple widget for spacing in UI layouts |
| **dartx**                   | Extension methods that add powerful functionality to core Dart classes |
| **flutter_hooks**           | React-like hooks for state management and side-effects |
| **path_provider**           | Platform-specific file system locations |
| **package_info_plus**       | Access app package information (version, name) |
| **collection**              | Advanced collection operations and utilities |
| **meta**                    | Annotations for more expressive code |
| **device_info_plus**        | Access device-specific information |
| **logger**                  | Pretty, easy to use and extensible logger |
| **after_layout**           | Execute code after first widget layout |
| **envied**                 | Type-safe environment variables handling |
| **showcaseview**           | Highlight and showcase app features with an interactive overlay |
| **fpdart**                 | Functional programming with Either, Option types for error handling |
| **google_fonts**           | Easy access to Google Fonts for consistent typography |

### 🔧 Code Generation

Run the command to generate code:

```bash
fvm flutter pub run build_runner build --delete-conflicting-outputs
```

## 🧪 Testing & Coverage

Run unit & widget tests:

```bash
fvm flutter test --coverage --test-randomize-ordering-seed random
# or
make test
```

Generate coverage report:

```bash
genhtml coverage/lcov.info -o coverage/
# or
make coverage
```

### Testing Standards
- **Widget Testing**: Comprehensive testing for UI components
- **Mock Dependencies**: Properly typed mock implementations
- **Test Data Factories**: Reusable test data creation
- **Color API Usage**: Using modern color component accessors (r, g, b, a) instead of deprecated properties
- **Test Coverage Targets**:
  - Overall project: 80%+ (target)
  - Storage Feature: 100% (achieved)
  - Environment Feature: 100% (achieved)
  - Core Modules: 90%+ (target)

## 🌐 Localization

The project uses [slang](https://pub.dev/packages/slang) for localization, providing a type-safe, code-generated, and developer-friendly i18n solution.

### 📁 Add your translation files:

Place your JSON files under:

```
lib/i18n/
├── en.json
└── vi.json
```

Example `en.json`:
```json
{
  "auth": {
    "login": "Login",
    "welcome": "Welcome, {name}!"
  }
}
```

### ⚙️ Configuration

Add a `slang.yaml` file in the root:

```yaml
input_directory: lib/i18n
output_directory: lib/generated
fallback_locale: en
input_file_pattern: .json
output_file_name: translations.g.dart
```

### 🛠️ Code Generation

Run the command:

```bash
fvm flutter pub run slang_build_runner build
```

### 🚀 Usage

In your main.dart:

```dart
await Translations.ensureInitialized();
runApp(TranslationProvider(child: MyApp()));
```

Then use it in widgets:

```dart
Text(t.auth.login);
Text(t.auth.welcome(name: 'David'));
```

## 📌 Quick Checklist

- [ ] Ensure you are running the correct version of Flutter via FVM (`fvm use`)
- [ ] Run code generation (`build_runner`) whenever adding a model or dependency
- [ ] Write basic tests when adding a new feature
- [ ] Update localization whenever adding or modifying text in the UI
- [ ] Use modern Flutter APIs (avoid deprecated color properties)

## 🧠 Best Practices Checklist (Advanced)

- [ ] Class/file/variable names follow standard conventions: PascalCase, snake_case, camelCase
- [ ] Each class has a single responsibility (Single Responsibility)
- [ ] Follow Dependency Inversion by depending on abstractions, not implementations
- [ ] Use service abstractions in `core/services` to decouple from third-party libraries
- [ ] Clearly comment important class/function/logic
- [ ] Do not let classes exceed 300 lines, methods exceed 40 lines
- [ ] Use `const`, `final` wherever possible to improve performance
- [ ] Avoid nested logic greater than 3 levels (if necessary - extract helpers)
- [ ] At minimum, write tests for bloc/usecase/service
- [ ] New features should always include UI, logic, tests & README
- [ ] Use `flutter_screenutil` for consistent responsive UI scaling
- [ ] Define routes in a central `AppRouter` using `auto_route` and `@RoutePage`
- [ ] Avoid hardcoded navigation paths; use generated route classes instead
- [ ] Use utility libraries efficiently: `dartx` for extensions, `gap` for spacing, `nil` for null handling
- [ ] Apply hooks pattern with `flutter_hooks` for stateful logic in function components
- [ ] Use structured logging with `logger` instead of print statements
- [ ] Leverage platform utilities: `path_provider`, `device_info_plus`, `package_info_plus`
- [ ] Use `after_layout` for widget initialization that requires measurements
- [ ] Secure sensitive data using `envied` for environment variables
- [ ] Apply modern color API methods (r, g, b, a) instead of deprecated properties (red, green, blue)

## 📖 References

- [Clean Architecture – Uncle Bob](https://8thlight.com/blog/uncle-bob/2012/08/13/the-clean-architecture.html)
- [Effective Dart](https://dart.dev/guides/language/effective-dart)
- [Bloc Pattern](https://bloclibrary.dev/#/)
- [GRASP Patterns](https://en.wikipedia.org/wiki/GRASP_(object-oriented_design))
- [Very Good Ventures Blog](https://verygood.ventures/blog)
- [slang – Dart i18n made easy](https://pub.dev/packages/slang)
- [Flutter Hooks Documentation](https://pub.dev/packages/flutter_hooks)
- [Logger Package](https://pub.dev/packages/logger)
- [Collection & Meta Packages](https://dart.dev/guides/libraries/useful-libraries)
- [After Layout Documentation](https://pub.dev/packages/after_layout)
- [Envied - Secure Environment Variables](https://pub.dev/packages/envied)
- [Showcaseview - Feature Highlighting](https://pub.dev/packages/showcaseview)
- [fpdart - Functional Programming in Dart](https://pub.dev/packages/fpdart)
- [Google Fonts - Typography](https://pub.dev/packages/google_fonts)

---

[coverage_badge]: coverage_badge.svg
[license_badge]: https://img.shields.io/badge/license-MIT-blue.svg
[license_link]: https://opensource.org/licenses/MIT
[very_good_analysis_badge]: https://img.shields.io/badge/style-very_good_analysis-B22C89.svg
[very_good_analysis_link]: https://pub.dev/packages/very_good_analysis