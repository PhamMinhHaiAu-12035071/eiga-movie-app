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
│   ├── env/                    # Environment configuration
│   ├── asset/                  # Asset management
│   ├── services/               # Service abstractions and implementations
│   ├── styles/                 # UI styles definitions (colors, text styles)
│   ├── sizes/                  # Size and dimension constants
│   ├── durations/             # Duration constants for animations and transitions
│   └── themes/                 # Theme management
├── features/                   # Feature modules
│   └── [feature_name]/         
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
│   ├── env/              # Environment configuration
│   ├── theme/            # Application theming
│   ├── router/           # Navigation routing
│   ├── di/               # Dependency injection setup
│   ├── styles/           # Shared style definitions
│   └── sizes/            # Standardized sizing constants
│   └── durations/        # Animation duration constants
├── features/             # Application features
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

### Testing Approach

The project implements a comprehensive testing strategy:

1. **Unit Testing**
   - Tests for domain entities and application logic
   - Tests for repositories and services
   - Uses fpdart's Either for testing error scenarios
   - Mock dependencies using mocktail

2. **Widget Testing**
   - Tests for UI components in isolation
   - Tests for screen flows and interactions
   - Uses flutter_test framework

3. **Integration Testing**
   - Tests for feature workflows
   - Tests for navigation between screens
   - Tests for end-to-end functionality

4. **Test Coverage**
   - Uses lcov for generating coverage reports
   - Customized Makefile commands for running tests and viewing coverage
   - Target of 80%+ code coverage 