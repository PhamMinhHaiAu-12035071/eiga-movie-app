---
description: 
globs: 
alwaysApply: false
---
# 📌 CursorRule: Flutter Project Structure & Coding Standards (Ultimate Guide - EN)

> 🧠 This is a technical guideline for **Cursor AI** and all Flutter developers to ensure the source code adheres to standard architecture, is readable, maintainable, extensible, and supports automation through AI. It includes Clean Architecture, Clean Code, Design Patterns, Commenting Rule, Naming, Formatting, Testing, and more than 15 professional software development principles.

---

## 🎯 Objectives & Target Audience

- **For:** Cursor AI, Technical Lead, Flutter Developers from mid-level and above.
- **Applies:** When creating new/refactoring Flutter projects or scaling teams.
- **Goals:**
  - Standardize the structure and codebase for large-scale Flutter projects.
  - Optimize readability, extensibility, testing, and support for Cursor AI.

---

## 📂 Project Directory Structure (Clean Architecture)

```plaintext
lib/
├── core/                         # System configuration
│   ├── di/                      # Dependency Injection (GetIt, Injectable)
│   ├── router/                  # Navigation (auto_route)
│   ├── env/                     # Environment configuration
│   ├── asset/                   # Asset management
│   ├── services/                # Service abstractions and implementations
│   ├── styles/                  # UI styles definitions (colors, text styles)
│   ├── sizes/                   # Size and dimension constants
│   ├── durations/              # Duration constants for animations
│   └── themes/                  # Theme management
├── features/                    # Feature module separation
│   └── [feature_name]/
│       ├── domain/              # Business logic and rules
│       │   ├── models/          # Business entities/models
│       │   └── repositories/    # Repository interfaces
│       ├── infrastructure/      # Implementation of repositories
│       │   └── repositories/    # Repository implementations
│       ├── application/         # State management and use cases
│       │   └── cubit/           # Cubits/BLoCs
│       └── presentation/        # UI, page, widget, router
│           └── widgets/         # Reusable UI components
├── shared/                      # Reusable resources
│   └── widgets/                 # Shared widgets
├── generated/                   # Generated code (assets, translations)
├── app.dart                     # Main application widget
├── bootstrap.dart               # Application initialization
├── main_development.dart        # Entry point for development environment
├── main_staging.dart            # Entry point for staging environment
└── main_production.dart         # Entry point for production environment
```

### 📘 Structure Explanation
| Directory   | Purpose                                                                 |
|-------------|-------------------------------------------------------------------------|
| `core/`     | Core configuration for the entire system – not belonging to any feature |
| `features/` | Modules divided by functionality – easy to scale, maintain, and test separately |
| `shared/`   | Reusable widgets and logic across modules                               |
| `generated/`| Auto-generated code from the build_runner or other code generators      |

---

## ✅ Checklist for Creating a New Feature

```bash
# 1. Create a standard structure directory
lib/features/your_feature/presentation

# 2. Create UI components (presentation layer)
# 3. Set up navigation in the router
# 4. Add the feature to the main app flow
```

---

## 💬 Commenting Rule – Supporting AI & Readability

> Comments are **mandatory** for Cursor AI and developers when reading or generating code.

- [x] Comment at the beginning of classes/functions (`///` or `/** */`).
- [x] Comment on major logic: loops, if/else, calculations, states.
- [x] Use inline comments if clarification is needed at a line.

```dart
/// Displays a list of users with interactive buttons
class UserListPage extends StatelessWidget {
  const UserListPage({super.key});

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<UserBloc>();

    return Scaffold(
      appBar: AppBar(title: const Text('Users')),
      body: BlocBuilder<UserBloc, UserState>(
        builder: (context, state) {
          if (state is Loading) {
            return const CircularProgressIndicator(); // Loading
          } else if (state is Success) {
            return ListView(
              children: [
                for (final user in state.users)
                  ListTile(title: Text(user.name))
              ],
            );
          } else {
            return const Text('No data');
          }
        },
      ),
    );
  }
}
```

---

## 🔠 Naming Conventions

| Item           | Rule         | Example                         |
|----------------|--------------|---------------------------------|
| Class          | PascalCase   | `LoginPage`, `AuthBloc`        |
| File/folder    | snake_case   | `login_form.dart`              |
| Function/var   | camelCase    | `fetchUser()`, `isLoading`     |
| Const/Enum     | SCREAM_CASE  | `MAX_ITEMS`, `USER_ROLE.admin` |
| Private        | `_` prefix   | `_counter`, `_onPressed()`     |
| Test file      | `_test.dart` | `login_bloc_test.dart`         |

---

## 📄 File Splitting & Size Guidelines

| Component     | Limit          | Notes                               |
|---------------|----------------|-------------------------------------|
| Dart File     | ≤ 300 lines    | Easy to read, easy to review, should be split if exceeded |
| Class         | 1–2 responsibilities | Follow Single Responsibility Principle |
| Function      | ≤ 40 lines     | Split if logic is complex           |
| build()       | ≤ 50 lines     | Extract child widgets               |

---

## 📚 Code Style & Formatting Rules

- Use `const` wherever possible.
- Use `final` by default – only use var if mutating.
- Maximum of 3 levels of nested logic (if-else, loop...).
- Automatically format code (`dart format`, IDE).
- Follow `very_good_analysis` standards.

### 🛠️ Utility Libraries Usage

- Use extension methods from `dartx` instead of custom utility functions when possible.
- Prefer `nil` package for null checking and handling optional values.
- Use `gap` for consistent spacing in UI rather than custom SizedBox widgets.
- Leverage `basic_utils` for common operations instead of implementing custom solutions.
- Implement `flutter_hooks` for stateful logic in functional components.
- Use `path_provider` for accessing standard file system locations.
- Apply `logger` for consistent, readable logging across the application.
- Access device and app information with `device_info_plus` and `package_info_plus`.
- Use `collection` for advanced operations on lists, maps, and iterables.
- Add `@required` and other annotations from `meta` to improve code clarity.
- Use `after_layout` for post-layout initialization and measurements.
- Manage environment variables securely with `envied` instead of hardcoding.
- Implement `showcaseview` to highlight and explain new features to users.
- Apply functional programming principles with `fpdart` for error handling and domain modeling.
- Use `google_fonts` for consistent typography across the application.

---

## 🧠 Advanced Software Principles

| Principle           | Goals & Notes |
|---------------------|---------------|
| **SOLID**           | 5 core OOP principles – scalable architecture |
| **Dependency Inversion** | Depend on abstractions not implementations; use service interfaces |
| **DRY**             | Avoid code duplication – use common helpers/widgets |
| **KISS**            | Keep code as simple as possible |
| **YAGNI**           | Only build what is needed |
| **Law of Demeter**  | Avoid calling methods too far down the dependency chain |
| **PoLA**            | Code behavior should match the reader's expectations |
| **Composition > Inheritance** | Easier to extend in the long run |
| **Low Coupling**    | Reduce dependencies between modules |
| **High Cohesion**   | Each piece of code should do one task only |
| **Encapsulation**   | Hide internal details, only expose necessary interfaces |
| **Separation of Concerns** | UI, Logic, Data should be separated |
| **GRASP**           | Principles for assigning responsibilities in OOP |
| **CoC (Convention > Config)** | Easier to read and set up quickly |
| **Information Expert** | Assign responsibilities to the place that understands the data best |
| **Protected Variations** | Place abstraction where changes are likely |
| **Functional Programming** | Use fpdart for immutability, Either/Option types, and pure functions |

---

## 🧩 Applicable Design Patterns

| Pattern     | Context |
|-------------|---------|
| **Factory** | Create models from JSON responses |
| **Singleton** | Global DI (GetIt) |
| **Strategy** | Change themes, change strategy handlers |
| **Observer** | Bloc/Cubit → UI updates |
| **Repository** | Separate interface/data implementation |
| **Service Abstraction** | Decouple from external dependencies with interfaces |

---

## 🧪 Testing Guidelines

| Component       | Test Type     | Recommended Tools          |
|------------------|---------------|-----------------------------|
| Bloc/Cubit       | Unit test     | `bloc_test`, `mocktail`     |
| UI/Page/Widget   | Widget test   | `flutter_test`              |
| UseCase/Service  | Unit test     | `test`, `mocktail`          |
| API & parsing    | Response test | `chopper_mock`, `dio_adapter` |

### 📌 Coverage Target: **>= 99.99%** (use `--coverage`)

---

## 🧭 Tooling & Automation

| Tool                | Purpose |
|---------------------|---------|
| `fvm`               | Manage Flutter versions per project |
| `very_good_cli`     | Scaffold Clean Architecture projects, flavors |
| `build_runner`      | Code generation for DI, JSON, freezed... |
| `injectable`, `get_it` | Dependency Injection |
| `mason`             | Quickly create feature/widget templates |
| `flutter_gen`       | Automatically manage assets safely |
| `dart_code_metrics` | Analyze code quality |
| `flutter_screenutil` | Responsive UI across devices |
| `slang`, `slang_build_runner` | Type-safe, code-generated localization system |
| `basic_utils` | Collection of utility functions for common operations |
| `nil` | Null-safety utilities for clean, expressive code |
| `gap` | Simple widget for spacing in UI layouts |
| `dartx` | Extension methods enhancing core Dart classes |
| `flutter_hooks` | React-like hooks for state management and side-effects |
| `path_provider` | Platform-specific file system locations |
| `package_info_plus` | Access app package information (version, name) |
| `collection` | Advanced collection operations and utilities |
| `meta` | Annotations for more expressive code |
| `device_info_plus` | Access device-specific information |
| `logger` | Pretty, easy to use and extensible logger |
| `after_layout` | Execute code after first widget layout |
| `envied` | Type-safe environment variables handling |
| `showcaseview` | Highlight and showcase app features with interactive tutorial |
| `fpdart` | Functional programming utilities for error handling |
| `google_fonts` | Easy access to Google Fonts library |

---

## ✅ Cursor Checklist – During Code Analysis or Code Generation

- [ ] Correct structure of `core/`, `features/`, `shared/`, `generated/`
- [ ] Each feature has a `presentation/` layer
- [ ] Sufficient comments for classes, functions, and important logic
- [ ] No overly long classes/methods/files
- [ ] Logic & UI tests are present
- [ ] Variable, class, file names follow naming conventions
- [ ] No warnings from `flutter analyze`
- [ ] Clear separation between UI components
- [ ] Environment configuration is properly set up in `core/env/`
- [ ] Assets are properly managed through the generated code in `generated/`

---

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
- [Google Fonts for Flutter](https://pub.dev/packages/google_fonts)

---

## 🔐 Environment Configuration Best Practices

### 📁 Directory Structure
```
lib/core/env/
├── domain/                 # Environment repository interface
│   └── env_config_repository.dart
├── infrastructure/         # Environment repository implementation
│   └── env_config_repository_impl.dart
└── env_[environment].dart  # Environment-specific configuration
```

### 🛡️ Security Guidelines

1. **Environment Files**
   - Store `.env` files in `lib/assets/env/`
   - Never commit `.env` files to version control
   - Provide `.env.example` templates

2. **Code Generation**
   - Use `envied` with `obfuscate: true`
   - Generate separate files for each environment
   - Keep generated files in version control

3. **Access Pattern**
   - Use repository pattern for environment access
   - Inject environment config through DI
   - Never access env variables directly in features

### 📝 Example Implementation

```dart
// 1. Define repository interface
abstract class EnvConfigRepository {
  String get apiUrl;
  String get appName;
}

// 2. Create environment class
@Envied(path: 'lib/assets/env/.env.dev', obfuscate: true)
abstract class EnvDev {
  @EnviedField(varName: 'API_URL')
  static String apiUrl = _EnvDev.apiUrl;
}

// 3. Implement repository
@LazySingleton(as: EnvConfigRepository)
class EnvConfigRepositoryImpl implements EnvConfigRepository {
  @override
  String get apiUrl => EnvDev.apiUrl;
}

// 4. Use in features through DI
class MyService {
  final EnvConfigRepository _env;
  
  MyService(this._env);
  
  Future<void> makeRequest() {
    final url = _env.apiUrl;
    // Use url...
  }
}
```

---

## 📚 Feature Implementation Examples

### 🌟 Onboarding Feature Example

The onboarding feature demonstrates how to implement a complete feature using Clean Architecture. This pattern can be replicated for other features.

#### 📂 Directory Structure

```
lib/features/onboarding/
├── domain/
│   ├── models/
│   │   └── onboarding_info.dart       # Data model for onboarding slides
│   └── repositories/
│       └── onboarding_repository.dart # Repository interface
├── infrastructure/
│   └── repositories/
│       └── onboarding_repository_impl.dart  # Repository implementation
├── application/
│   └── cubit/
│       ├── onboarding_cubit.dart      # State management
│       └── onboarding_state.dart      # State definitions
├── presentation/
│   ├── onboarding_page.dart           # Main page
│   └── widgets/
│       ├── onboarding_page_view.dart  # Slide display
│       ├── onboarding_dot_indicator.dart # Progress indicator
│       └── onboarding_next_button.dart # Navigation button
└── README.md                          # Feature documentation
```

#### 🧩 Implementation Patterns

1. **Domain Layer**:
   - Models define pure data structures (`OnboardingInfo`)
   - Repository interfaces specify contracts (`IOnboardingRepository`)

2. **Infrastructure Layer**:
   - Implements repository interfaces (`OnboardingRepository`)
   - Handles data storage (e.g., using `SharedPreferences`)

3. **Application Layer**:
   - State management with `OnboardingCubit` and `OnboardingState`
   - Encapsulates business logic

4. **Presentation Layer**:
   - Main page (`OnboardingPage`) uses Auto Route for navigation
   - Reusable UI components in the `widgets` folder
   - Uses ScreenUtil for responsive design

#### 🧠 Design Patterns Applied

- **Repository Pattern**: Abstracts data operations
- **BLoC/Cubit Pattern**: Separates UI from business logic
- **Dependency Injection**: Components receive their dependencies
- **Builder Pattern**: Complex UI broken into smaller widgets

#### 📑 Best Practices

- Clear comments on every class and important method
- Single Responsibility for each class
- Error handling for asset loading
- Responsive design using ScreenUtil
- Clean separation between data, logic, and UI

### Service Layer
- Place service abstractions in `core/services` directory
- Define interfaces for external dependencies (e.g., `LocalStorageService`)
- Implement concrete services that fulfill these interfaces
- Inject services via DI instead of direct dependencies
- Follow naming convention: Interface (`ServiceName`), Implementation (`ServiceNameImpl`)
- Benefits: testability, swappable implementations, adherence to SOLID

### Persistence
- Storage abstracted through `LocalStorageService` interface
- Primary implementation via `SharedPreferencesStorageService` for simple data
- More complex data structures may use SQLite or Hive
- All storage operations follow the interface contract
- Features depend on the abstraction, not concrete implementations

### Feature Showcasing

For implementing feature showcases and interactive tutorials:

- Use `showcaseview` package to create guided user experiences
- Highlight key UI elements with configurable overlays
- Implement step-by-step walkthroughs for complex features
- Store user progress to avoid showing tutorials multiple times
- Create an abstraction layer for showcase management:

```dart
abstract class ShowcaseService {
  /// Initialize showcase features
  Future<void> initialize();
  
  /// Check if a specific showcase was completed
  Future<bool> isShowcaseCompleted(String showcaseKey);
  
  /// Mark a showcase as completed
  Future<void> completeShowcase(String showcaseKey);
  
  /// Reset all showcases (for testing)
  Future<void> resetAllShowcases();
}
```

Example implementation for a screen:

```dart
class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // Showcase keys for each feature
  final GlobalKey _menuKey = GlobalKey();
  final GlobalKey _searchKey = GlobalKey();
  final GlobalKey _profileKey = GlobalKey();
  
  // Showcase builder reference
  ShowCaseWidget? showcaseWidget;
  
  @override
  void initState() {
    super.initState();
    // Check if we should show the showcase
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _checkAndShowShowcase();
    });
  }
  
  Future<void> _checkAndShowShowcase() async {
    final showcaseService = getIt<ShowcaseService>();
    final isCompleted = await showcaseService.isShowcaseCompleted('home_screen');
    
    if (!isCompleted) {
      ShowCaseWidget.of(context)?.startShowCase([_menuKey, _searchKey, _profileKey]);
      await showcaseService.completeShowcase('home_screen');
    }
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
        actions: [
          Showcase(
            key: _searchKey,
            description: 'Tap to search for items',
            child: IconButton(
              icon: const Icon(Icons.search),
              onPressed: () {},
            ),
          ),
        ],
      ),
      drawer: Showcase(
        key: _menuKey,
        description: 'Open the menu to access more options',
        child: Drawer(...),
      ),
      // More UI with showcase elements
    );
  }
}

---

## 🧠 Functional Programming with fpdart

Functional programming using `fpdart` enables safer error handling and more explicit domain modeling:

### Core Functional Types

| Type           | Purpose                                               | Example Use Case                              |
|----------------|-------------------------------------------------------|-----------------------------------------------|
| `Either<L, R>` | Represent success (Right) or failure (Left) outcomes  | API calls, validations, operations that may fail |
| `Option<A>`    | Represent presence (Some) or absence (None) of values | Nullable values, search results              |
| `Task<A>`      | Represent asynchronous computations                   | Async operations with better composability    |

### Example Usage

```dart
// Repository method using Either for error handling
Future<Either<Failure, User>> getUserById(String id) async {
  try {
    final response = await _apiClient.get('/users/$id');
    
    if (response.statusCode == 200) {
      return right(User.fromJson(response.data));
    } else {
      return left(ServerFailure('Failed to fetch user: ${response.statusCode}'));
    }
  } catch (e) {
    return left(NetworkFailure(e.toString()));
  }
}

// Using Option for values that might be absent
Option<User> findUserByUsername(String username) {
  final user = _users.firstWhereOrNull((u) => u.username == username);
  return optionOf(user); // Returns Some(user) or None()
}
```

### Benefits of Functional Approach

1. **Explicit Error Handling**: No more unexpected exceptions or null checks
2. **Improved Type Safety**: Compiler enforces proper handling of all cases
3. **Better Composability**: Chain operations with map, flatMap, getOrElse, etc.
4. **Predictable Code**: Pure functions with no side effects
5. **Self-Documenting**: Types document possible outcomes

### Usage in Clean Architecture

- **Domain Layer**: Define failure types and repository methods returning Either
- **Infrastructure Layer**: Implement error handling with Either in repositories
- **Application Layer**: Use flatMap for chaining operations, mapLeft for error transformation
- **Presentation Layer**: Handle Either results from use cases in Cubit/Bloc

---

> 💡 Treat this as a foundational guide for any modern Flutter project. With both Cursor AI and developers following this rule, it ensures a scalable, maintainable, and high-quality codebase that benefits from powerful AI-assisted development.
