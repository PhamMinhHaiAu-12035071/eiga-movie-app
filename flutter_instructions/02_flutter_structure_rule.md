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
│   └── theme/                   # Common interface
├── features/                    # Feature module separation
│   └── [feature_name]/
│       ├── domain/              # Entity, repository abstract
│       ├── application/         # Bloc/Cubit, UseCase, intermediate logic
│       ├── infrastructure/      # Repository implementation, API services
│       └── presentation/        # UI, page, widget, router
└── shared/                      # Reusable resources
    ├── constants/
    ├── utils/
    └── widgets/
```

### 📘 Structure Explanation
| Directory   | Purpose                                                                 |
|-------------|-------------------------------------------------------------------------|
| `core/`     | Core configuration for the entire system – not belonging to any feature |
| `features/` | Modules divided by functionality – easy to scale, maintain, and test separately |
| `shared/`   | Reusable widgets and logic across modules                               |

---

## ✅ Checklist for Creating a New Feature

```bash
# 1. Create a standard structure directory
lib/features/your_feature/{domain,application,infrastructure,presentation}

# 2. Define Entity & Repo Interface (domain)
# 3. Create UseCase + Bloc/Cubit (application)
# 4. Set up actual repo/service (infrastructure)
# 5. Build UI/page + router (presentation)
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

---

## 🧠 Advanced Software Principles

| Principle           | Goals & Notes |
|---------------------|---------------|
| **SOLID**           | 5 core OOP principles – scalable architecture |
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

---

## 🧩 Applicable Design Patterns

| Pattern     | Context |
|-------------|---------|
| **Factory** | Create models from JSON responses |
| **Singleton** | Global DI (GetIt) |
| **Strategy** | Change themes, change strategy handlers |
| **Observer** | Bloc/Cubit → UI updates |
| **Repository** | Separate interface/data implementation |

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

---

## ✅ Cursor Checklist – During Code Analysis or Code Generation

- [ ] Correct structure of `core/`, `features/`, `shared/`
- [ ] Each feature has all 4 layers (domain, app, infra, presentation)
- [ ] Sufficient comments for classes, functions, and important logic
- [ ] No overly long classes/methods/files
- [ ] Logic & UI tests are present
- [ ] Variable, class, file names follow naming conventions
- [ ] No warnings from `flutter analyze`
- [ ] Clear separation between UI ↔ Logic ↔ Data
- [ ] Localization is implemented using `slang` with generated Dart accessors
- [ ] Translation files are under `lib/i18n/` and structured with nested keys

---

## 📚 References

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

> 💡 Treat this as a foundational guide for any modern Flutter project. With both Cursor AI and developers following this rule, it ensures a scalable, maintainable, and high-quality codebase that benefits from powerful AI-assisted development.
