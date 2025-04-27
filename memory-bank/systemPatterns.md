# System Patterns

## Architecture Overview

The EIGA Movie App follows Clean Architecture principles, with a feature-first organization approach. Each feature is divided into four main layers:

1. **Domain Layer**
   - Contains business models, interfaces, and use cases
   - Defines repository interfaces that the infrastructure layer implements
   - Represents the core business logic and rules

2. **Application Layer**
   - Manages state using BLoC/Cubit pattern
   - Interacts with the domain layer to execute use cases
   - Transforms domain data for presentation

3. **Infrastructure Layer**
   - Provides concrete implementations of domain interfaces
   - Manages external data sources (API, local storage)
   - Converts data models to domain entities

4. **Presentation Layer**
   - Contains UI components, screens, and widgets
   - Consumes state from the application layer
   - Dispatches user events to the application layer

## Directory Structure

```
lib/
├── core/                     # Core application code
│   ├── di/                   # Dependency injection
│   ├── router/               # Navigation configuration
│   ├── asset/                # Asset management
│   ├── styles/               # UI style definitions 
│   ├── sizes/                # Size and spacing definitions
│   ├── durations/            # Animation duration constants
│   └── themes/               # Theme configurations
│       ├── extensions/       # Theme extensions
│       └── app_theme.dart    # Theme definitions
├── features/                 # Feature modules
│   └── [feature_name]/       # Specific feature
│       ├── domain/           # Domain layer
│       │   ├── models/       # Domain models
│       │   └── repositories/ # Repository interfaces
│       ├── application/      # Application layer (state management)
│       │   ├── cubit/        # Feature Cubits (or BLoCs)
│       │   └── facades/      # Feature facades (optional)
│       ├── infrastructure/   # Infrastructure layer
│       │   ├── datasources/  # Data sources (API, Database)
│       │   ├── models/       # Response/Request models
│       │   └── repositories/ # Repository implementations
│       └── presentation/     # Presentation layer
│           ├── pages/        # Full screens with routing
│           ├── views/        # Main UI containers 
│           └── widgets/      # UI components
├── shared/                   # Shared code across features
│   ├── domain/               # Shared models/interfaces
│   ├── infrastructure/       # Shared implementations
│   └── widgets/              # Shared UI components
└── main.dart                 # Application entry point
```

## Key Technical Decisions

### State Management

We use the BLoC pattern (via `flutter_bloc`) for state management:

1. **Cubit Approach**
   - Most features use Cubit for simpler state management
   - State classes are created with Freezed for immutability
   - State follows a uniform structure with data, status, and error properties

2. **State Design Pattern**
   ```dart
   @freezed
   class FeatureState with _$FeatureState {
     const factory FeatureState({
       @Default(LoadingStatus.initial) LoadingStatus status,
       FeatureModel? data,
       String? errorMessage,
     }) = _FeatureState;
   
     factory FeatureState.initial() => const FeatureState();
   }
   ```

3. **Cubit Pattern**
   ```dart
   @injectable
   class FeatureCubit extends Cubit<FeatureState> {
     final FeatureRepository _repository;
   
     FeatureCubit(this._repository) : super(FeatureState.initial());
   
     // Methods to update state
   }
   ```

### Navigation

1. **Auto Router**
   - Using `auto_route` for type-safe routing
   - Routes are defined in `core/router/app_router.dart`
   - Screens are annotated with `@RoutePage()`
   - Navigation uses the `context.router` extension methods

2. **Route Replacement**
   - For one-time screens like onboarding, we use route replacement:
   ```dart
   context.router.replace(const LoginRoute());
   ```

### Dependency Injection

1. **GetIt + Injectable**
   - Using `get_it` for service location
   - Using `injectable` for code generation
   - Dependencies are registered in modules under `core/di`
   - Repositories are registered with their interfaces
   - Modules are organized by functionality

2. **Registration Pattern**
   ```dart
   @module
   abstract class ApiModule {
     @lazySingleton
     Dio provideDio(EnvRepository envRepository) {
       // Configuration...
     }
   }
   ```

### Repositories

1. **Repository Pattern**
   - Interfaces defined in domain layer
   - Implementations in infrastructure layer
   - Result return type using Either from fpdart
   - Error handling with typed error objects

2. **Repository Interface**
   ```dart
   abstract class FeatureRepository {
     Future<Either<FeatureError, FeatureModel>> getFeature(String id);
   }
   ```

3. **Repository Implementation**
   ```dart
   @LazySingleton(as: FeatureRepository)
   class FeatureRepositoryImpl implements FeatureRepository {
     final ApiClient _apiClient;
   
     FeatureRepositoryImpl(this._apiClient);
   
     @override
     Future<Either<FeatureError, FeatureModel>> getFeature(String id) async {
       try {
         final response = await _apiClient.getFeature(id);
         return right(response.toDomain());
       } catch (e) {
         return left(_mapExceptionToError(e));
       }
     }
   }
   ```

## Responsive Design Patterns

### 1. Orientation-Specific Components

We use distinct view components for portrait and landscape layouts to optimize the user experience for each orientation:

```dart
// Standard naming convention
class FeaturePortraitView extends StatelessWidget {
  // Portrait-optimized layout implementation
}

class FeatureLandscapeView extends StatelessWidget {
  // Landscape-optimized layout implementation
}
```

**Key principles:**
- Use consistent naming pattern with `PortraitView` and `LandscapeView` suffixes
- Maintain equivalent functionality between orientations
- Optimize layout for the specific orientation
- Share common widgets between orientations where possible
- Use the same data and callback interfaces for both view types

### 2. Orientation Detection

We detect orientation and render the appropriate view component using MediaQuery:

```dart
@override
Widget build(BuildContext context) {
  final orientation = MediaQuery.of(context).orientation;
  
  return Scaffold(
    body: SafeArea(
      child: orientation == Orientation.portrait
          ? FeaturePortraitView(/* common parameters */)
          : FeatureLandscapeView(/* common parameters */),
    ),
  );
}
```

For more reactive handling, we occasionally use OrientationBuilder:

```dart
OrientationBuilder(
  builder: (context, orientation) {
    return orientation == Orientation.portrait
        ? FeaturePortraitView(/* common parameters */)
        : FeatureLandscapeView(/* common parameters */);
  },
)
```

### 3. Layout Optimization Strategies

**Portrait Layouts:**
- Vertical flow using Column as primary container
- Full width utilization for content
- Vertical stacking with image-content-controls flow
- Typical flex ratio: 3:5:2 (header:content:footer)
- More vertical space for content than UI controls

**Landscape Layouts:**
- Horizontal flow using Row as primary container
- Split screen approach with side-by-side content
- Typical flex ratio: 4:6 or 5:7 (left:right)
- Balance horizontal space between informational and interactive areas
- Minimize vertical scrolling when possible

### 4. Testing Orientation-Specific Views

We test both orientation layouts separately:

```dart
testWidgets('renders correctly in portrait', (tester) async {
  // Set portrait orientation
  tester.binding.window.physicalSizeTestValue = const Size(1080, 1920);
  tester.binding.window.devicePixelRatioTestValue = 1.0;
  addTearDown(tester.binding.window.clearPhysicalSizeTestValue);
  
  // Test implementation...
  
  // Verify portrait view is rendered
  expect(find.byType(FeaturePortraitView), findsOneWidget);
});
```

### 5. Example: Onboarding Feature Implementation

Our onboarding feature demonstrates this pattern with:

- `OnboardingPortraitView`: Vertical layout with stacked elements
  - Content flows top to bottom
  - More space allocated to the image (flex: 3)
  - Controls at the bottom of the screen

- `OnboardingLandscapeView`: Horizontal layout with side-by-side elements
  - Image on the left (flex: 5)
  - Content and controls on the right (flex: 7)
  - Optimized for horizontal space utilization

Both views maintain identical functionality and share common components (OnboardingHeader, OnboardingDotIndicator, OnboardingNextButton), ensuring consistent UX across orientations.

## Widget Implementation Patterns

### 1. Abstract Base Widgets

We use abstract base classes for common widget functionality, enforcing consistent implementation across related components:

```dart
abstract class BaseHeaderText extends StatelessWidget {
  const BaseHeaderText({
    required this.text,
    this.color,
    this.maxLines = 1,
    Key? key,
  })  : assert(text.isNotEmpty),
        assert(maxLines > 0),
        super(key: key);

  final String text;
  final Color? color;
  final int maxLines;

  // Abstract properties that must be implemented by subclasses
  TextStyle? get style;
  Key get semanticKey;
  String get semanticLabel;
  bool get isHeader;

  // Shared implementation for all subclasses
  TextStyle buildTextStyle(BuildContext context) {
    // Implementation...
  }
}
```

**Key principles:**
- Use abstract classes to enforce implementation of required properties
- Share common logic in the abstract class
- Define clear interfaces with required and optional parameters
- Use assertions to validate input parameters
- Provide semantic information for accessibility

### 2. Input Validation with Assertions

We consistently use assertions to validate input parameters at construction time, preventing runtime errors:

```dart
const OnboardingLogo({
  this.containerSize,
  this.imageSize,
  this.borderRadius,
  this.containerColor,
  Key? key,
}) : assert(
        containerSize == null || imageSize == null || containerSize >= imageSize,
        'Container size must be greater than or equal to image size',
      ),
      super(key: key);
```

**Key principles:**
- Validate logical constraints between related parameters
- Provide clear error messages explaining the constraint
- Use assertions during development to catch implementation errors early
- Focus on validating parameters that could cause visual or functional issues

### 3. Widget Keys for Testing

We use consistent key naming and assignment for testability and accessibility:

```dart
@override
Widget build(BuildContext context) {
  return Container(
    key: const Key('onboarding_logo_container'),
    // Implementation...
    child: Center(
      child: SizedBox(
        key: const Key('onboarding_logo_image_container'),
        // Implementation...
      ),
    ),
  );
}
```

**Key principles:**
- Use snake_case for key name strings
- Include the widget name in the key for clarity
- Add suffixes to distinguish between multiple keys in the same widget
- Assign keys to critical widgets that need to be found in tests
- Use consistent key naming across the application

### 4. Context Extensions for Styling

We leverage context extensions to access styles, colors, and dimensions:

```dart
@override
TextStyle buildTextStyle(BuildContext context) {
  return (isHeader ? context.textTheme.headlineLarge : context.textTheme.titleMedium)
      ?.copyWith(color: color ?? context.colorScheme.primary);
}
```

**Key principles:**
- Use context extensions to access theme properties
- Provide fallbacks for nullable parameters
- Allow style customization while maintaining consistent defaults
- Follow the material design system hierarchy
- Keep styling code concise and readable

### 5. Semantics for Accessibility

We consistently incorporate semantics for accessibility:

```dart
@override
Widget build(BuildContext context) {
  return Semantics(
    label: semanticLabel,
    header: isHeader,
    child: Text(
      text,
      style: buildTextStyle(context),
      maxLines: maxLines,
      overflow: TextOverflow.ellipsis,
    ),
  );
}
```

**Key principles:**
- Provide meaningful labels for screen readers
- Use appropriate semantic properties (header, button, etc.)
- Ensure all interactive elements have proper semantics
- Make accessibility a core part of the widget design
- Test with accessibility tools to verify proper implementation

### 6. Parameter Flexibility with Defaults

We design widgets with flexible parameters and sensible defaults:

```dart
const HeaderTitle({
  required String text,
  TextStyle? style,
  Color? color,
  int maxLines = 1,
  Key? key,
}) : super(
        text: text,
        color: color,
        maxLines: maxLines,
        key: key,
      );
```

**Key principles:**
- Required parameters for essential functionality
- Optional parameters with sensible defaults
- Clear parameter naming that reflects purpose
- Consistent parameter order across related widgets
- Use named parameters for better readability and maintainability

### 7. Animation with AnimatedContainer

We use AnimatedContainer for smooth transitions:

```dart
@override
Widget build(BuildContext context) {
  return AnimatedContainer(
    duration: context.durations.fast,
    // Implementation...
  );
}
```

**Key principles:**
- Use built-in animation widgets when possible
- Ensure consistent animation durations using context extensions
- Prefer implicit animations for simple state changes
- Use explicit animations for more complex sequences
- Ensure animations are smooth and purposeful

## Utility Usage Patterns

1. **Direct Package Usage**
   - **Prefer direct usage of utility packages** rather than creating wrapper components
   - Example: Use `Gap` directly from the 'gap' package instead of creating custom wrappers
   ```dart
   // PREFERRED: Direct usage
   Gap(AppSizes.spacing16.h)
   
   // AVOID: Creating wrapper components
   VerticalGap(size: AppSizes.spacing16)
   ```

2. **Widget Extension Methods**
   - Using extension methods to add functionality to widgets
   - Example: Adding padding or margin to a widget
   ```dart
   extension WidgetX on Widget {
     Widget withPadding(EdgeInsets padding) {
       return Padding(
         padding: padding,
         child: this,
       );
     }
   }
   
   // Usage
   Text('Hello').withPadding(EdgeInsets.all(8.0))
   ```

3. **Context Extension Methods**
   - Using extension methods on BuildContext for common operations
   - Example: Accessing theme colors
   ```dart
   extension BuildContextX on BuildContext {
     ThemeData get theme => Theme.of(this);
     ColorScheme get colorScheme => theme.colorScheme;
   }
   
   // Usage
   Container(
     color: context.colorScheme.background,
   )
   ```

## Testing Patterns

1. **Mock Implementation Standards**
   - Create consistent mock implementations for dependencies
   - Use factory constructors for mock creation
   - Ensure proper type definitions and return types
   - Example: Mock color implementation
   ```dart
   class MockAppColors extends Mock implements AppColors {
     @override
     MaterialColor get primary => MaterialColor(
       0xFF6200EE,
       <int, Color>{
         50: Color(0xFFF2E7FE),
         100: Color(0xFFD7B7FD),
         // ... other shades
       },
     );
   }
   ```

2. **Widget Test Structure**
   - Follow a consistent test structure for all widgets
   ```dart
   group('Widget Tests', () {
     setUp(() {
       // Initialization
     });
     
     tearDown(() {
       // Cleanup
     });
     
     testWidgets('description', (tester) async {
       // Widget setup
       // Test execution
       // Verification
     });
   });
   ```

3. **Response Mocking**
   - Mock API responses using classes with test data
   - Example: Mock repository implementation
   ```dart
   class MockUserRepository extends Mock implements UserRepository {
     @override
     Future<Either<UserError, User>> getUser(String id) async {
       return right(
         User(
           id: '1',
           name: 'Test User',
           email: 'test@example.com',
         ),
       );
     }
   }
   ```

## Error Handling

1. **Typed Errors**
   - Using freezed to create typed error classes
   ```dart
   @freezed
   class FeatureError with _$FeatureError {
     const factory FeatureError.server([String? message]) = ServerError;
     const factory FeatureError.network([String? message]) = NetworkError;
     const factory FeatureError.unexpected([String? message]) = UnexpectedError;
   }
   ```

2. **Either Pattern**
   - Using Either from fpdart for result types
   - Left side represents errors, right side represents success
   ```dart
   Future<Either<FeatureError, FeatureModel>> getFeature(String id);
   ```

3. **Error Mapping**
   - Mapping exceptions to typed errors
   ```dart
   FeatureError _mapExceptionToError(dynamic exception) {
     if (exception is DioError) {
       if (exception.type == DioErrorType.connectTimeout ||
           exception.type == DioErrorType.other) {
         return const FeatureError.network();
       }
       return FeatureError.server(exception.response?.statusMessage);
     }
     return const FeatureError.unexpected();
   }
   ```

## Theme and Styling

1. **Theme Extensions**
   - Using theme extensions to add custom theme properties
   ```dart
   class AppColorExtension extends ThemeExtension<AppColorExtension> {
     final Color customColor1;
     final Color customColor2;
     
     AppColorExtension({
       required this.customColor1,
       required this.customColor2,
     });
     
     @override
     ThemeExtension<AppColorExtension> copyWith({
       Color? customColor1,
       Color? customColor2,
     }) {
       return AppColorExtension(
         customColor1: customColor1 ?? this.customColor1,
         customColor2: customColor2 ?? this.customColor2,
       );
     }
     
     @override
     ThemeExtension<AppColorExtension> lerp(
       ThemeExtension<AppColorExtension>? other,
       double t,
     ) {
       if (other is! AppColorExtension) {
         return this;
       }
       
       return AppColorExtension(
         customColor1: Color.lerp(customColor1, other.customColor1, t)!,
         customColor2: Color.lerp(customColor2, other.customColor2, t)!,
       );
     }
   }
   ```

2. **Centralized Style Definitions**
   - All styles defined in dedicated classes
   - No direct use of colors, text styles, or sizes in widgets
   - Example: Accessing styles
   ```dart
   Text(
     'Hello',
     style: AppTextStyles.bodyMedium.copyWith(
       color: AppColors.primary,
     ),
   )
   ```

## Documentation

1. **README for Features**
   - Each feature should have a README.md explaining its purpose and architecture
   - Example structure:
   ```
   # Feature Name
   
   ## Overview
   Brief description of the feature.
   
   ## Architecture
   Description of how the feature is implemented.
   
   ## Components
   List of main components and their roles.
   
   ## Testing
   Information about how to test the feature.
   ```

2. **Code Comments**
   - Using dartdoc comments for public APIs
   - Example:
   ```dart
   /// Returns a user by ID.
   ///
   /// Parameters:
   /// - [id]: The ID of the user to retrieve.
   ///
   /// Returns:
   /// A [Future] that completes with an [Either] containing either a [UserError]
   /// or a [User].
   ///
   /// Throws:
   /// Nothing. Errors are returned in the [Either].
   Future<Either<UserError, User>> getUser(String id);
   ```

3. **Example Usage**
   - Including example usage in comments for complex components
   - Example:
   ```dart
   /// A widget that displays a custom button with a gradient background.
   ///
   /// Example:
   /// ```dart
   /// GradientButton(
   ///   gradient: LinearGradient(
   ///     colors: [Colors.blue, Colors.purple],
   ///   ),
   ///   onPressed: () => print('Button pressed'),
   ///   child: Text('Press me'),
   /// )
   /// ```
   class GradientButton extends StatelessWidget {
     // Implementation...
   }
   ```