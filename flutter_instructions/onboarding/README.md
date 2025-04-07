# Onboarding Feature Implementation Guide

This document provides a comprehensive guide for implementing the onboarding feature in the EIGA movie app using Clean Architecture principles.

## Feature Overview

The onboarding feature presents new users with a series of introductory screens that highlight the app's core functionality. It consists of:

- A series of slides with images and descriptive text
- Navigation controls (next/skip buttons)
- Visual indicators showing progress
- Persistence of onboarding completion status

## Implementation Steps

### 1. Create Directory Structure

Follow Clean Architecture by creating these directories:

```
lib/features/onboarding/
├── domain/models/
├── domain/repositories/
├── infrastructure/repositories/
├── application/cubit/
├── presentation/
└── presentation/widgets/
```

### 2. Implement Domain Layer

Create the data model and repository interface:

```dart
// domain/models/onboarding_info.dart
class OnboardingInfo extends Equatable {
  const OnboardingInfo({
    required this.imagePath,
    required this.title, 
    required this.description,
  });
  
  final String imagePath;
  final String title;
  final String description;
  
  @override
  List<Object?> get props => [imagePath, title, description];
}

// domain/repositories/i_onboarding_repository.dart
abstract class IOnboardingRepository {
  Future<bool> checkIfOnboardingSeen();
  Future<void> markOnboardingAsSeen();
}
```

### 3. Implement Infrastructure Layer

Create the repository implementation:

```dart
// infrastructure/repositories/onboarding_repository.dart
@LazySingleton(as: IOnboardingRepository)
class OnboardingRepository implements IOnboardingRepository {
  OnboardingRepository(this._prefs);
  
  final SharedPreferences _prefs;
  static const String _onboardingSeenKey = 'onboarding_seen';
  
  @override
  Future<bool> checkIfOnboardingSeen() async {
    return _prefs.getBool(_onboardingSeenKey) ?? false;
  }
  
  @override
  Future<void> markOnboardingAsSeen() async {
    await _prefs.setBool(_onboardingSeenKey, true);
  }
}
```

### 4. Implement Application Layer

Create the state management classes:

```dart
// application/cubit/onboarding_state.dart
class OnboardingState extends Equatable {
  final List<OnboardingInfo> slides;
  final int currentPage;
  
  bool get isLastPage => currentPage == slides.length - 1;
  
  const OnboardingState({
    required this.slides,
    this.currentPage = 0,
  });
  
  OnboardingState copyWith({
    List<OnboardingInfo>? slides,
    int? currentPage,
  }) {
    return OnboardingState(
      slides: slides ?? this.slides,
      currentPage: currentPage ?? this.currentPage,
    );
  }
  
  @override
  List<Object?> get props => [slides, currentPage];
}

// application/cubit/onboarding_cubit.dart
@injectable
class OnboardingCubit extends Cubit<OnboardingState> {
  OnboardingCubit(this._repository)
      : super(
          const OnboardingState(
            slides: [
              OnboardingInfo(
                imagePath: 'assets/images/onboarding/onboarding1.png',
                title: 'Welcome to EIGA',
                description: 'Discover and book movie tickets with ease',
              ),
              OnboardingInfo(
                imagePath: 'assets/images/onboarding/onboarding2.png',
                title: 'Find Your Favorite Movies',
                description: 'Explore new and popular movies from around the world',
              ),
              OnboardingInfo(
                imagePath: 'assets/images/onboarding/onboarding3.png',
                title: 'Book Tickets Quickly',
                description: 'Book movie tickets anytime, anywhere with just a few taps',
              ),
            ],
          ),
        );

  final IOnboardingRepository _repository;

  void updatePage(int page) {
    emit(state.copyWith(currentPage: page));
  }

  void nextPage() {
    if (!state.isLastPage) {
      emit(state.copyWith(currentPage: state.currentPage + 1));
    }
  }

  Future<void> completeOnboarding() async {
    await _repository.markOnboardingAsSeen();
  }

  Future<bool> checkIfOnboardingSeen() async {
    return _repository.checkIfOnboardingSeen();
  }
}
```

### 5. Implement Presentation Layer

Create UI components:

```dart
// presentation/widgets/onboarding_dot_indicator.dart
class OnboardingDotIndicator extends StatelessWidget {
  // Implementation...
}

// presentation/widgets/onboarding_next_button.dart
class OnboardingNextButton extends StatelessWidget {
  // Implementation...
}

// presentation/widgets/onboarding_page_view.dart
class OnboardingPageView extends StatelessWidget {
  // Implementation...
}

// presentation/onboarding_page.dart
@RoutePage()
class OnboardingPage extends StatefulWidget {
  // Implementation with navigation logic...
}
```

### 6. Register Dependencies

Add the following to the dependency injection setup:

```dart
@module
abstract class OnboardingModule {
  @preResolve
  Future<SharedPreferences> get prefs => SharedPreferences.getInstance();
}

// Make sure to register the module in your configureDependencies() function
```

### 7. Add Navigation

Configure the Auto Route:

```dart
// core/router/app_router.dart
@AutoRouterConfig()
class AppRouter extends $AppRouter {
  @override
  List<AutoRoute> get routes => [
        AutoRoute(page: OnboardingRoute.page, initial: true),
        // Other routes...
      ];
}
```

### 8. Prepare Assets

Add the following to `pubspec.yaml`:

```yaml
flutter:
  assets:
    - assets/images/onboarding/
```

Create images:
- `assets/images/onboarding/onboarding1.png`
- `assets/images/onboarding/onboarding2.png`
- `assets/images/onboarding/onboarding3.png`

For responsive images, add 2.0x and 3.0x versions in:
- `assets/images/onboarding/2.0x/`
- `assets/images/onboarding/3.0x/`

### 9. Testing

Write tests for each layer:

- Unit tests for the cubit and repository
- Widget tests for UI components
- Integration tests for the full flow

## Best Practices

1. **Documentation**: Add thorough comments to all classes and methods
2. **Error Handling**: Implement error handling for loading assets
3. **Responsive Design**: Use ScreenUtil for adaptive UI
4. **Optimization**: Use const constructors where possible
5. **Feature Documentation**: Create a README.md in the feature directory

## Common Issues and Solutions

1. **Assets Not Loading**: Ensure paths in pubspec.yaml are correct
2. **Navigation Issues**: Check route configuration in AppRouter
3. **State Not Updating**: Verify Cubit emissions and BlocBuilder usage
4. **Dependency Injection**: Ensure all dependencies are properly registered

## Related Resources

- [Flutter Bloc Documentation](https://bloclibrary.dev/)
- [Auto Route Documentation](https://pub.dev/packages/auto_route)
- [ScreenUtil Documentation](https://pub.dev/packages/flutter_screenutil)
- [SharedPreferences Documentation](https://pub.dev/packages/shared_preferences) 