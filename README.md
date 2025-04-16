# 📦 KSK App

![coverage][coverage_badge]
[![style: very good analysis][very_good_analysis_badge]][very_good_analysis_link]
[![License: MIT][license_badge]][license_link]

A Flutter app that allows workers to easily input order data using a modern, high-performance, and maintainable architecture.

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

## 🚀 Features

### 🌟 Onboarding

The onboarding feature provides new users with an introduction to the app's key features. It follows Clean Architecture principles with a complete separation of concerns:

- **Domain Layer**: Defines the core business logic and entities
  - Models: `OnboardingInfo` representing each onboarding slide
  - Repository interfaces: `OnboardingRepository` for persistence

- **Infrastructure Layer**: Implements data access logic
  - Repository implementation (`OnboardingRepositoryImpl`) using abstractions for storage operations

- **Application Layer**: Manages state and business logic
  - `OnboardingCubit` for state management with slides information
  - `OnboardingState` to track current page and slide data

- **Presentation Layer**: UI components
  - `OnboardingPage`: Main screen with page navigation
  - Reusable widgets: `OnboardingPageView`, `OnboardingDotIndicator`, `OnboardingNextButton`

The onboarding flow presents users with information about key app features, with smooth page transitions, progress indicators, and options to skip or move to the next screen.

### 🔍 Feature Showcasing

The app uses the `showcaseview` package to provide interactive tutorials highlighting key features. This helps users discover and understand the app's functionality:

- **Interactive guides**: Step-by-step walkthroughs for complex features
- **Targeted highlights**: Focus user attention on specific UI elements
- **Persistent state**: Track which tutorials users have already seen
- **Configurable appearance**: Customize the look and feel of showcase elements

Implementation follows the repository pattern for tracking showcase completion:

- **Domain Layer**: Defines the `ShowcaseRepository` interface
- **Infrastructure Layer**: Implements persistence of showcase state
- **Application Layer**: Manages when and how showcases are triggered
- **Presentation Layer**: UI components with showcase annotations

### 🧮 Functional Programming

The app leverages the `fpdart` library to implement functional programming concepts that improve error handling and domain modeling:

- **Either type**: Represents operations that can succeed or fail with explicit error types
- **Option type**: Replaces nullable values with a more type-safe approach
- **Task type**: Manages asynchronous operations with better composability

Benefits of using functional programming in the app:

- **Explicit error handling**: All potential failure cases are encoded in the type system
- **Type safety**: Compiler ensures all error cases are properly handled
- **Cleaner domain models**: More expressive and self-documenting code
- **Predictable execution**: Function composition and immutable data structures

Typical usage pattern:

```dart
// Repository method returning Either type
Future<Either<Failure, List<Product>>> getProducts() async {
  try {
    final result = await _apiClient.get('/products');
    return right(result.map((json) => Product.fromJson(json)).toList());
  } on NetworkException catch (e) {
    return left(NetworkFailure(e.message));
  } on ServerException catch (e) {
    return left(ServerFailure(e.message));
  } catch (e) {
    return left(UnexpectedFailure(e.toString()));
  }
}

// Cubit handling Either results
Future<void> loadProducts() async {
  emit(state.copyWith(status: ProductStatus.loading));
  
  final result = await _productRepository.getProducts();
  
  result.fold(
    (failure) => emit(state.copyWith(
      status: ProductStatus.error,
      errorMessage: failure.message,
    )),
    (products) => emit(state.copyWith(
      status: ProductStatus.loaded, 
      products: products,
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

## 📦 Dependencies

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
```

Generate coverage report:

```bash
genhtml coverage/lcov.info -o coverage/
open coverage/index.html
```

- The test suite now includes `test/core/themes/extensions/app_asset_extension_test.dart` with 100% coverage. Coverage for `AppColorExtension` and `AppTheme` is in progress.

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
- [Vibe Coding Tutorial Weather App](https://github.com/erkansahin/vibe_coding_tutorial_weather_app)
- [Smart App Monorepo by Banua Coder](https://github.com/banua-coder/smart-app)
- [Storage App by Draphonix](https://github.com/draphonix/storage)

---

[coverage_badge]: coverage_badge.svg
[license_badge]: https://img.shields.io/badge/license-MIT-blue.svg
[license_link]: https://opensource.org/licenses/MIT
[very_good_analysis_badge]: https://img.shields.io/badge/style-very_good_analysis-B22C89.svg
[very_good_analysis_link]: https://pub.dev/packages/very_good_analysis