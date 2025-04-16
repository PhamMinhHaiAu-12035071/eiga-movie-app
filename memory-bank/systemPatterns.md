# System Patterns

## Architecture Overview

The KSK App follows the **Clean Architecture** principles, organizing code into the following layers:

```
Domain --> Application --> Infrastructure --> Presentation
```

### Domain Layer
- Contains business entities and repository interfaces
- Pure Dart with no dependencies on Flutter or external packages
- Defines the business rules and logic

### Application Layer
- Contains use cases and state management
- Implements business logic
- Uses BLoC/Cubit for state management

### Infrastructure Layer
- Implements repository interfaces from the domain layer
- Handles data sources (API, local storage)
- Communicates with external services

### Presentation Layer
- Contains UI components (pages, widgets)
- Consumes state from the application layer
- Handles user interactions

## Project Structure
The codebase follows a **feature-first** organization:

```
lib/
├── core/                       # Common system configurations
│   ├── di/                     # Dependency Injection
│   ├── router/                 # Navigation
│   ├── asset/                  # Asset management
│   ├── services/               # Service abstractions and implementations
│   ├── styles/                 # UI styles definitions (colors, text styles)
│   ├── sizes/                  # Size and dimension constants
│   ├── durations/              # Duration constants for animations and transitions
│   └── themes/                 # Theme management
├── features/                   # Feature modules
│   ├── env/                    # Environment configuration
│   │   ├── domain/             # Environment repository interface
│   │   ├── infrastructure/     # Environment repository implementation
│   │   └── env_development.dart # Environment variables and configuration
│   └── [other_feature_name]/   
│       ├── domain/             # Entities, repository interfaces
│       ├── application/        # State management, use cases
│       ├── infrastructure/     # Repository implementations
│       └── presentation/       # UI components
├── shared/                     # Shared components
├── generated/                  # Generated code
├── app.dart                    # Main application widget
└── bootstrap.dart              # Application initialization
```

## Feature Structure Example

### Login Feature Structure
This is a typical structure for a feature, exemplified by the login feature:

```
lib/features/login/
├── application/
│   └── cubit/
│       ├── login_cubit.dart    # State management
│       └── login_state.dart    # State definition
├── presentation/
│   ├── pages/
│   │   └── login_page.dart     # Route page with @RoutePage annotation
│   └── widgets/
│       └── login_view.dart     # Main UI component
└── README.md                   # Feature documentation
```

### Environment Feature Structure
The environment feature provides configuration based on the running environment:

```
lib/features/env/
├── domain/
│   └── env_config_repository.dart   # Repository interface
├── infrastructure/
│   └── env_config_repository_impl.dart  # Repository implementation
├── env_development.dart         # Development environment configuration
└── .env.dev                     # Environment variables file
```

## Key Design Patterns

### Repository Pattern
- Abstracts data sources behind interfaces
- Uses clear naming convention (no "I" prefix for interfaces, "Impl" suffix for implementations)
- Repository interfaces defined in domain layer (e.g., `FeatureRepository`)
- Repository implementations in infrastructure layer (e.g., `FeatureRepositoryImpl`)
- Allows for easy swapping of implementations
- Facilitates testing via mock repositories

### Dependency Injection
- Uses `get_it` and `injectable` for service location
- Centralizes dependency management
- Facilitates testing by allowing injection of mocks

### BLoC Pattern
- Separates business logic from UI
- Manages state through streams of events and states
- Promotes unidirectional data flow

### Factory Pattern
- Used for creating instances of repositories and services
- Centralizes object creation logic
- Supports different implementations based on environment

### Adapter Pattern
- Used in the infrastructure layer to adapt external data to domain models
- Isolates data transformation logic

### Service Abstraction
- Core services defined as interfaces to decouple from specific implementations
- Services reside in `core/services` directory
- Enables swapping implementations without affecting consumers
- Examples include `LocalStorageService` for abstracting persistence operations
- Follows Dependency Inversion principle from SOLID

## Specific Implementation Patterns

### Navigation
- Uses `auto_route` for type-safe routing
- Centralized route definitions in `app_router.dart`
- Route pages annotated with `@RoutePage()`
- Navigation implemented using `context.router.replace()` or `context.router.push()`
- Support for nested routes and guards

### State Management
- Uses `flutter_bloc` for state management
- Separate state classes for each feature
- Immutable state objects with `freezed` or `equatable`
- State providers injected using BlocProvider
- Consumption with BlocBuilder or BlocConsumer

### Error Handling
- Centralized error handling through repositories
- Custom exception types for different error scenarios
- User-friendly error messages via UI

### Persistence
- Storage abstracted through `LocalStorageService` interface
- Primary implementation via `SharedPreferencesStorageService` for simple data
- More complex data structures may use SQLite or Hive
- All storage operations follow the interface contract
- Features depend on the abstraction, not concrete implementations

### Networking
- HTTP requests via `dio` and `chopper`
- Type-safe API client generation
- Request/response interceptors for common operations

### Color System
- Uses MaterialColor for primary color palettes
- Centralizes all color definitions in AppColors class
- Organizes colors by theme (light/dark) and feature
- Provides shade variations (50-900) for each main color
- Enforces color consistency by avoiding direct color references

### Duration System
- Centralizes all animation and transition durations in AppDurations class
- Provides categorized durations (veryShort, short, medium, long, extraLong, oneSecond)
- Ensures consistent timing across the application
- Improves maintainability by eliminating hardcoded duration values
- Makes animation timing adjustments easier by changing values in a single place

### Styling System
- Text styles defined in AppTextStyle class
- Size constants defined in AppDimension class
- Colors defined in AppColors class
- Consistent usage throughout the application
- Responsive design with ScreenUtil

## Component Communication
- Primarily through BLoC/Cubit pattern
- Repository pattern for data access
- Event-based communication for cross-feature interactions

## Feature Implementation Patterns
### Minimal Feature
- Start with a simple state class (using Equatable or Freezed)
- Create a basic Cubit with minimal functionality
- Implement UI with proper routing and navigation
- Follow the app's design guidelines for consistent UI

### Full Feature
- Domain layer with entities and repository interfaces
- Infrastructure layer with repository implementations
- Application layer with state management
- Presentation layer with UI components
- Comprehensive documentation in README.md

## Testing Strategy
- Unit tests for domain and application layers
- Widget tests for presentation layer
- Integration tests for key user flows
- Mock repositories and services for isolated testing 

## Architectural Patterns

### Clean Architecture
The application is structured according to Clean Architecture principles, with a clear separation of concerns through layers:

1. **Domain Layer**
   - Contains business logic, entities, and repository interfaces
   - Has no dependencies on other layers or external frameworks
   - Includes use cases that encapsulate business rules

2. **Application Layer**
   - Contains state management (BLoC/Cubit)
   - Orchestrates flow of data between domain and presentation
   - Depends only on the domain layer

3. **Infrastructure Layer**
   - Implements repository interfaces from the domain layer
   - Handles external data sources (API, database, local storage)
   - Contains adapters to convert external data models to domain entities

4. **Presentation Layer**
   - Contains UI components (widgets, pages)
   - Consumes state from application layer
   - Handles user interactions and delegates to application layer

### Feature-First Organization
The project is organized around features rather than layers, which keeps related code together and improves maintainability:

```
lib/
├── core/                  # Core utilities and shared functionality
│   ├── theme/            # Application theming
│   ├── router/           # Navigation routing
│   ├── di/               # Dependency injection setup
│   ├── styles/           # Shared style definitions
│   ├── sizes/            # Standardized sizing constants
│   └── durations/        # Animation duration constants
├── features/             # Application features
│   ├── env/              # Environment configuration feature
│   │   ├── domain/       # Environment repository interface
│   │   └── infrastructure/ # Environment repository implementation
│   ├── onboarding/       # Onboarding feature
│   │   ├── domain/       # Domain layer for onboarding
│   │   ├── application/  # Application layer for onboarding
│   │   ├── infrastructure/ # Infrastructure layer for onboarding
│   │   └── presentation/ # Presentation layer for onboarding
│   ├── login/            # Login feature
│   │   ├── domain/       # Domain layer for login
│   │   ├── application/  # Application layer for login
│   │   ├── infrastructure/ # Infrastructure layer for login
│   │   └── presentation/ # Presentation layer for login
│   └── storage/          # Storage feature
│       ├── domain/       # Domain layer for storage
│       └── infrastructure/ # Infrastructure layer for storage
└── main.dart             # Application entry point
```

### Environment Feature Architecture

The Environment feature provides environment-specific configuration and constants using the envied package. It follows Clean Architecture principles:

1. **Domain Layer**:
   - `EnvConfigRepository` interface: Defines contract for accessing environment values
   - Provides getters for common configuration values (apiUrl, appName, environmentName)

2. **Infrastructure Layer**:
   - `EnvConfigRepositoryImpl`: Implements repository interface by accessing EnvDev
   - Registered as a lazySingleton in the dependency injection container
   
3. **Configuration**:
   - `EnvDev` class: Uses the envied package to securely access and obfuscate environment variables
   - `.env.dev` file: Stores actual environment variables (not committed to version control)

4. **Testing**:
   - Comprehensive tests for both domain and infrastructure layers
   - Mock implementations for testing different scenarios
   - Test helpers for validating environment values

### Storage Feature Architecture

The Storage feature implements persistent data storage capabilities using SharedPreferences as its underlying mechanism. It follows Clean Architecture principles and includes:

1. **Domain Layer**:
   - `StorageFailure` class: Represents different types of storage operation failures
     - Uses freezed for immutable implementation
     - Provides specific failure types: storageError, keyNotFound, typeMismatch
   - `LocalStorageService` interface: Defines contract for storage operations
     - Uses Either<StorageFailure, T> return type for functional error handling
     - Provides methods for CRUD operations (getBool, setBool, containsKey, remove, clear)

2. **Infrastructure Layer**:
   - `SharedPreferencesStorageService`: Implements LocalStorageService using SharedPreferences
     - Handles exceptions and converts them to appropriate StorageFailure types
     - Registered as a lazySingleton in the dependency injection container

3. **Testing**:
   - 100% code coverage with comprehensive unit tests
   - Tests for all failure and success scenarios
   - Uses mocktail for mocking dependencies

## Testing Architecture

### Test Organization
```
test/
├── domain/
│   ├── entities/
│   ├── value_objects/
│   └── use_cases/
├── application/
│   ├── blocs/
│   └── services/
├── infrastructure/
│   └── repositories/
├── presentation/
│   ├── widgets/
│   └── screens/
├── integration/
│   └── features/
├── helpers/
│   ├── test_helpers.dart
│   ├── mock_helpers.dart
│   └── robot_helpers.dart
└── fixtures/
    └── mock_data/
```

### Testing Patterns

#### 1. Robot Pattern
Used for widget and integration tests to encapsulate test actions and assertions:
```dart
class LoginRobot {
  Future<void> enterEmail(String email) => ...
  Future<void> enterPassword(String password) => ...
  Future<void> tapLoginButton() => ...
  Future<void> verifyErrorMessage(String message) => ...
}
```

#### 2. Test Data Factories
Consistent mock data generation using factory pattern:
```dart
class UserFactory {
  static User createDefault() => ...
  static User createWithRole(UserRole role) => ...
  static List<User> createMany(int count) => ...
}
```

#### 3. Golden Testing
Visual regression testing setup:
```dart
goldenTest(
  'renders correctly',
  builder: () => MyWidget(),
  goldenFile: 'my_widget.png',
  customPump: (tester, widget) async {
    await tester.binding.setSurfaceSize(Size(400, 800));
    await tester.pumpWidget(widget);
  },
);
```

#### 4. BLoC Test Pattern
Standard structure for testing BLoCs:
```dart
blocTest<LoginBloc, LoginState>(
  'emits [loading, success] when login succeeds',
  build: () => LoginBloc(authRepository: mockAuthRepo),
  act: (bloc) => bloc.add(LoginSubmitted()),
  expect: () => [
    LoginState.loading(),
    LoginState.success(),
  ],
);
```

### Test Helpers

#### 1. Widget Test Helpers
```dart
extension PumpApp on WidgetTester {
  Future<void> pumpApp(Widget widget) async {
    await pumpWidget(
      MaterialApp(
        home: widget,
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
      ),
    );
  }
}
```

#### 2. Mock Helpers
```dart
class MockBuilder {
  static MockAuthRepository buildAuthRepository() {
    final mock = MockAuthRepository();
    when(() => mock.login(any(), any()))
        .thenAnswer((_) async => const Right(unit));
    return mock;
  }
}
```

### Testing Guidelines

1. **Unit Tests**
   - One test file per class
   - Follow Arrange-Act-Assert pattern
   - Mock external dependencies
   - Test edge cases and error scenarios

2. **Widget Tests**
   - Use robot pattern for complex widgets
   - Test user interactions
   - Verify widget state changes
   - Include accessibility testing

3. **Integration Tests**
   - Focus on critical user flows
   - Use mock data consistently
   - Implement retry mechanisms
   - Log test steps for debugging
   - Test complete feature flows end-to-end
   - Verify API integrations
   - Test database operations
   - Validate navigation flows
   - Check error handling

4. **Performance Tests**
   - Measure widget build times
   - Track memory usage
   - Monitor frame drops
   - Test with large datasets

## Testing Patterns

### Widget Testing Best Practices

1. **Mock Dependencies**
   - Use Mocktail for mocking dependencies
   - Create mock classes with specific implementations for required methods
   - Register mocks with GetIt for dependency injection

```dart
class MockAppColors extends Mock implements AppColors {
  @override
  MaterialColor get white => const MaterialColor(
    0xFFFFFFFF,
    <int, Color>{
      50: Color(0xFFFFFFFF),
      // ... other shades
    },
  );
}
```

2. **Test Setup**
   - Use `setUp` for common test initialization
   - Register mocks in setUp
   - Use `tearDown` to clean up GetIt registry
   - Create helper methods for building test widgets

```dart
setUp(() {
  mockDependency = MockDependency();
  GetIt.I.registerSingleton<Dependency>(mockDependency);
});

tearDown(() {
  GetIt.I.reset();
});
```

3. **Widget Building**
   - Wrap test widgets in MaterialApp for proper context
   - Use helper functions for consistent widget building
   - Include all necessary providers/dependencies

```dart
Widget buildTestWidget({
  required VoidCallback onPressed,
  required String text,
  bool someFlag = false,
}) {
  return MaterialApp(
    home: Scaffold(
      body: YourWidget(
        onPressed: onPressed,
        text: text,
        someFlag: someFlag,
      ),
    ),
  );
}
```

4. **Finding Widgets**
   - Use specific finders to avoid ambiguity
   - For nested widgets, use `find.descendant()`
   - When multiple instances exist, use first/last/at as appropriate
   - Always verify widget existence before testing properties

```dart
final specificWidget = find.descendant(
  of: find.byType(ParentWidget),
  matching: find.byType(ChildWidget),
).first;
```

5. **Testing Styles and Decorations**
   - Use null-safe assertions for nullable properties
   - Cast decorations explicitly when needed
   - Test gradient colors and other visual properties thoroughly
   - Verify all style properties including colors, sizes, and fonts

```dart
final decoration = container.decoration! as BoxDecoration;
expect(decoration.gradient, isNotNull);
expect(
  (decoration.gradient! as LinearGradient).colors,
  [expectedColor1, expectedColor2],
);
```

6. **Testing Callbacks**
   - Use variables to track callback execution
   - Prefer `var` over explicit `bool` for callback flags
   - Test both positive and negative cases

```dart
var callbackExecuted = false;
await tester.tap(find.byType(ButtonWidget));
expect(callbackExecuted, isTrue);
```

7. **Code Style in Tests**
   - Follow consistent formatting
   - Add trailing commas for better git diffs
   - Use descriptive test names
   - Group related tests together

### Test Coverage Requirements

1. **Widget Tests**
   - Must cover all constructor parameters
   - Must test all callback functions
   - Must verify all visual properties
   - Must test edge cases and conditional rendering
   - Target 100% code coverage

2. **Integration Tests**
   - Must cover main user flows
   - Must test widget interactions
   - Must verify state management
   - Must test navigation flows

3. **Unit Tests**
   - Must cover all business logic
   - Must test all edge cases
   - Must verify error handling
   - Must test async operations

## Error Handling Patterns

1. **Null Safety**
   - Use null assertion operator (!) only when certain about non-null values
   - Provide meaningful error messages for null checks
   - Handle null cases gracefully in UI

2. **Exception Handling**
   - Catch specific exceptions rather than using catch-all
   - Provide user-friendly error messages
   - Log errors appropriately for debugging

3. **State Management**
   - Handle loading, success, and error states
   - Provide feedback for user actions
   - Maintain consistent state across widget tree

## Code Organization

1. **Feature Structure**
   - Organize by feature first, then by layer
   - Keep related files close together
   - Use index files for cleaner imports

2. **Test Structure**
   - Mirror source code directory structure
   - Group tests logically
   - Keep test files focused and manageable

3. **Dependency Management**
   - Use GetIt for dependency injection
   - Register dependencies at app startup
   - Use proper scoping for dependencies