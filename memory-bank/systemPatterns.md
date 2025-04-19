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
│   ├── styles/                 # UI styles definitions (colors, text styles)
│   ├── sizes/                  # Size and dimension constants
│   ├── durations/              # Duration constants for animations and transitions
│   └── themes/                 # Theme management
│       ├── extensions/         # Theme extensions for assets, colors, etc.
│       │   └── extensions.dart # Barrel file for all theme extensions
│       ├── app_theme.dart      # Main theme configuration
│       └── themes.dart         # Barrel file for all theme exports
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

### Testing Architecture

The project follows a comprehensive testing strategy across all layers:

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

### Testing Patterns

#### Mock Implementation Standards
- Use explicit return types for all function declarations
- Make boolean parameters nullable with default values
- Implement full interface for visual components
- Use proper type hierarchies (MaterialColor vs Color)
- Use factory constructors over static methods
- Implement proper error handling in mocks

#### Widget Test Structure
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

#### Standard Test Cases
- Basic rendering verification
- User interaction handling
- Error state management
- Style and layout verification
- Edge cases (empty states, rapid interactions)
- Animation and transition testing

#### Coverage Requirements
- Widget tree structure verification
- State management testing
- Callback validation
- Style property verification
- Error handling validation
- Edge case coverage