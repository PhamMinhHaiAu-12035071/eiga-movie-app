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

## Key Design Patterns

### Repository Pattern
- Abstracts data sources behind interfaces
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

## Specific Implementation Patterns

### Navigation
- Uses `auto_route` for type-safe routing
- Centralized route definitions
- Support for nested routes and guards

### State Management
- Uses `flutter_bloc` for state management
- Separate state classes for each feature
- Immutable state objects with `freezed`

### Error Handling
- Centralized error handling through repositories
- Custom exception types for different error scenarios
- User-friendly error messages via UI

### Persistence
- Local storage with `shared_preferences` for simple data
- More complex data structures may use SQLite or Hive

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

## Component Communication
- Primarily through BLoC/Cubit pattern
- Repository pattern for data access
- Event-based communication for cross-feature interactions

## Testing Strategy
- Unit tests for domain and application layers
- Widget tests for presentation layer
- Integration tests for key user flows
- Mock repositories and services for isolated testing 