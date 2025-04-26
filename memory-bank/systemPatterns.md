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

1. **Orientation Handling**
   - **Pattern: Separate Views for Different Orientations**
   - We use distinct view components for portrait and landscape layouts:
     ```dart
     Scaffold(
       body: SafeArea(
         child: orientation == Orientation.portrait
             ? PortraitView(...)
             : LandscapeView(...),
       ),
     )
     ```
   - Orientation is detected via `MediaQuery.of(context).orientation`
   - All callbacks and data are passed consistently to both views
   - Views are responsible for optimizing layouts for their orientation

2. **View-Specific Layout Optimizations**
   - **Portrait Views:** Optimize for vertical flow
     - Vertical arrangement of components
     - Full width utilization
     - Scroll for content overflow
   - **Landscape Views:** Optimize for horizontal flow
     - Side-by-side arrangement of components
     - Split screen approach
     - Horizontal navigation when appropriate

3. **Consistent UX Across Orientations**
   - Core functionality remains identical between orientations
   - Visual styling and branding stay consistent
   - Only the layout and positioning are adjusted

4. **Example Implementation: Onboarding Feature**
   ```dart
   // In onboarding_page.dart
   @override
   Widget build(BuildContext context) {
     return BlocProvider(
       create: (_) => getIt<OnboardingCubit>(),
       child: BlocBuilder<OnboardingCubit, OnboardingState>(
         builder: (context, state) {
           final orientation = MediaQuery.of(context).orientation;
           
           return Scaffold(
             body: SafeArea(
               child: orientation == Orientation.portrait
                   ? OnboardingPortraitView(
                       pageController: _pageController,
                       slides: state.slides,
                       currentPage: state.currentPage,
                       isLastPage: state.isLastPage,
                       onPageChanged: (index) => 
                           context.read<OnboardingCubit>().updatePage(index),
                       onNextPressed: () {
                         if (state.isLastPage) {
                           _finishOnboarding(context);
                         } else {
                           _nextPage(context);
                         }
                       },
                       onSkipPressed: () => _finishOnboarding(context),
                     )
                   : OnboardingLandscapeView(
                       // Same properties as portrait view
                     ),
             ),
           );
         },
       ),
     );
   }
   ```

## Utility Usage Patterns

1. **Direct Package Usage**
   - **Prefer direct usage of utility packages** rather than creating wrapper components
   - Example: Use `Gap` directly from the 'gap' package instead of creating custom wrappers
   ```dart
   // PREFERRED: Direct usage
   Gap(16)
   
   // AVOID: Unnecessary wrapper
   CustomGap(width: 16)
   ```
   - This approach reduces abstraction layers and simplifies the codebase
   - Only create wrapper components when they add significant value or customization

2. **Utility Library Selection**
   - Use established packages for common utilities:
     - `gap` for spacing in UI
     - `flutter_screenutil` for responsive sizing
     - `dartx` for extension methods
     - `collection` for advanced collection operations
     - `logger` for structured logging

## Testing Patterns

1. **Unit Testing**
   - All repositories and service implementations are unit tested
   - Domain models and application layer logic have comprehensive tests
   - Mockito or Mocktail is used for mocking dependencies

2. **Widget Testing**
   - Key components and screens have widget tests
   - Test both basic rendering and interaction scenarios
   - Mock dependencies using GetIt in test setup

3. **Orientation Testing Strategy**
   - **Test both portrait and landscape orientations separately**
   - Set physical screen size to control orientation in tests:
     ```dart
     // Set portrait orientation
     tester.binding.window.physicalSizeTestValue = const Size(800, 1600);
     tester.binding.window.devicePixelRatioTestValue = 1.0;
     addTearDown(tester.binding.window.clearPhysicalSizeTestValue);
     
     // Set landscape orientation
     tester.binding.window.physicalSizeTestValue = const Size(1600, 800);
     tester.binding.window.devicePixelRatioTestValue = 1.0;
     addTearDown(tester.binding.window.clearPhysicalSizeTestValue);
     ```
   - Verify orientation-specific views appear correctly:
     ```dart
     expect(find.byType(OnboardingPortraitView), findsOneWidget);
     expect(find.byType(OnboardingLandscapeView), findsNothing);
     ```
   - Use UI interactions in tests rather than direct callback invocation:
     ```dart
     await tester.tap(find.byType(NextButton));
     ```

4. **Testing Components with ScreenUtil**
   - **Use ScreenUtilInit in test builders to support responsive sizing**
   - Create a helper function to wrap test widgets with ScreenUtil:
     ```dart
     Widget buildTestWidget(Widget child) {
       return ScreenUtilInit(
         designSize: const Size(360, 800),
         minTextAdapt: true,
         splitScreenMode: true,
         builder: (_, __) => MaterialApp(
           home: Scaffold(
             body: child,
           ),
         ),
       );
     }
     ```
   - Use the helper to properly initialize ScreenUtil in tests:
     ```dart
     await tester.pumpWidget(
       buildTestWidget(
         const HeaderTitleGroup(
           title: 'Test Title',
           subtitle: 'Test Subtitle',
           spacing: 5.0, // Will be converted to 5.0.h by ScreenUtil
         ),
       ),
     );
     ```
   - When checking for Gap widgets that use ScreenUtil values, use specific widget predicates:
     ```dart
     final gapFinder = find.byWidgetPredicate(
       (widget) => widget is Gap && widget.mainAxisExtent == 5.0.h,
     );
     expect(gapFinder, findsOneWidget);
     ```
   - Be specific when finding widgets in complex hierarchies:
     ```dart
     // Find a Gap inside a specific Row
     final rowFinder = find.byType(Row);
     final gapInRow = find.descendant(
       of: rowFinder,
       matching: find.byWidgetPredicate(
         (widget) => widget is Gap && widget.mainAxisExtent == 14.0.w,
       ),
     );
     expect(gapInRow, findsOneWidget);
     ```

## Error Handling

1. **Repository Error Model**
   - Domain-specific error types returned via Either
   - Explicit error mapping in repositories
   - Consistent error patterns across features

2. **UI Error Handling**
   - Error states managed in Cubit/BLoC state
   - Consistent error UI patterns (snackbars, error widgets)
   - Retry mechanisms implemented where appropriate

## Styling System

1. **Centralized Styling**
   - Colors defined in `AppColors`
   - Text styles defined in `AppTextStyles`
   - Sizes and spacing in `AppSizes`
   - Durations in `AppDurations`
   - Theme data and extensions in `AppTheme`

2. **Theme Extensions**
   - Custom theme properties implemented via ThemeExtension
   - Accessed through `Theme.of(context).extension<ExtensionType>()`
   - Both light and dark mode supported

## Component Relationships

The application follows a clear dependency flow, with each layer communicating only with adjacent layers:

1. Presentation → Application → Domain ← Infrastructure

2. Core systems (DI, Router, Styles) are accessed by all layers as needed

3. Components in the same layer can communicate directly, but should generally minimize direct dependencies.

The core principles of Clean Architecture are maintained, with dependencies flowing inward toward the domain layer. The domain layer defines interfaces that the infrastructure layer implements, ensuring that the domain remains isolated from external concerns.

## Widgetbook Integration

Widgetbook serves as a component library and development tool, showcasing UI components in isolation:

1. **Structures**
   - Components organized by feature and type
   - Each widget has multiple use cases demonstrated
   - Responsive layout testing with device frames

2. **Developer Experience**
   - Grid, alignment, and inspector add-ons available
   - Device frame selection for various form factors
   - Zoom controls for detailed inspection