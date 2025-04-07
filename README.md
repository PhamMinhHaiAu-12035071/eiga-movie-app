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
│   └── env/                     # Environment configuration
├── features/                    # Separate functionalities (feature-first)
│   └── [feature_name]/          
│       └── presentation/        # UI Widgets, Pages, Route bindings
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
  - Repository interfaces: `IOnboardingRepository` for persistence

- **Infrastructure Layer**: Implements data access logic
  - Repository implementation using SharedPreferences for state persistence

- **Application Layer**: Manages state and business logic
  - `OnboardingCubit` for state management with slides information
  - `OnboardingState` to track current page and slide data

- **Presentation Layer**: UI components
  - `OnboardingPage`: Main screen with page navigation
  - Reusable widgets: `OnboardingPageView`, `OnboardingDotIndicator`, `OnboardingNextButton`

The onboarding flow presents users with information about key app features, with smooth page transitions, progress indicators, and options to skip or move to the next screen.

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

The project uses `envied` for secure environment variable handling. Environment variables are stored in `.env` files and accessed through generated Dart code.

### 📁 Environment Files Structure

```
lib/assets/env/
├── .env.dev     # Development environment variables
├── .env.stg     # Staging environment variables
└── .env.prod    # Production environment variables
```

### 🛠️ Environment Setup

1. Create environment class:
```dart
@Envied(path: 'lib/assets/env/.env.dev', obfuscate: true)
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

- [Bloc Pattern](https://bloclibrary.dev/)
- [Chopper & Dio Integration](https://pub.dev/packages/chopper)
- [Dependency Injection with Injectable & GetIt](https://pub.dev/packages/injectable)
- [RxDart Documentation](https://pub.dev/packages/rxdart)
- [Very Good Analysis (Linting)](https://pub.dev/packages/very_good_analysis)
- [Dartx Extensions](https://pub.dev/packages/dartx)
- [Gap Package](https://pub.dev/packages/gap)
- [Nil Package](https://pub.dev/packages/nil)
- [Basic Utils](https://pub.dev/packages/basic_utils)
- [Flutter Hooks](https://pub.dev/packages/flutter_hooks)
- [Path Provider](https://pub.dev/packages/path_provider)
- [Package Info Plus](https://pub.dev/packages/package_info_plus)
- [Collection Package](https://pub.dev/packages/collection)
- [Meta Package](https://pub.dev/packages/meta)
- [Device Info Plus](https://pub.dev/packages/device_info_plus)
- [Logger](https://pub.dev/packages/logger)
- [After Layout](https://pub.dev/packages/after_layout)
- [Envied](https://pub.dev/packages/envied)

---

[coverage_badge]: coverage_badge.svg
[license_badge]: https://img.shields.io/badge/license-MIT-blue.svg
[license_link]: https://opensource.org/licenses/MIT
[very_good_analysis_badge]: https://img.shields.io/badge/style-very_good_analysis-B22C89.svg
[very_good_analysis_link]: https://pub.dev/packages/very_good_analysis
