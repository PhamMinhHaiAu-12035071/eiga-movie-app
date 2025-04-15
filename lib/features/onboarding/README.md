# 🌟 Onboarding Feature

## Overview

The onboarding feature provides first-time users with an introduction to the app's key features. It displays a sequence of slides with engaging visuals and explanatory text to highlight the main benefits of using the EIGA movie app.

## Architecture

This feature follows Clean Architecture principles with a complete separation of concerns:

### Domain Layer

- **Models**: 
  - `OnboardingInfo`: Represents each slide with image path, title, and description
  
- **Repository Interfaces**: 
  - `OnboardingRepository`: Defines methods to check and save onboarding completion status

### Infrastructure Layer

- **Repository Implementation**: 
  - `OnboardingRepositoryImpl`: Implements the onboarding repository interface using SharedPreferences for persistence

### Application Layer

- **State Management**: 
  - `OnboardingCubit`: Manages application state and business logic
  - `OnboardingState`: Contains slide data and current page index

### Presentation Layer

- **Pages**: 
  - `OnboardingPage`: Main onboarding screen with navigation controls

- **Widgets**: 
  - `OnboardingPageView`: Displays onboarding slides with PageView
  - `OnboardingDotIndicator`: Shows the current position in the sequence
  - `OnboardingNextButton`: Button to navigate between slides or complete onboarding

## Usage

The onboarding flow is designed to appear on first app launch. Users can:

- Swipe horizontally to navigate between slides
- Tap "Next" to proceed to the next slide
- Tap "Skip" to bypass the onboarding process
- Tap "Get Started" on the final slide to complete onboarding

## Implementation Details

### Assets

Onboarding uses image assets stored in the following structure:
```
assets/images/onboarding/
├── onboarding1.png
├── onboarding2.png
└── onboarding3.png
```

Each image has 2.0x and 3.0x variants for different screen densities.

### Persistence

The onboarding completion status is stored in SharedPreferences with the key `onboarding_seen`. Once a user completes or skips the onboarding, this flag is set to `true`, and the onboarding will not be shown on subsequent app launches.

### Navigation

The onboarding feature uses the app's navigation system to direct users to the main screen after completion.

## Error Handling

The onboarding images include an error handler that displays a placeholder if the image files cannot be loaded, ensuring a graceful degradation of the UI if assets are missing.

## Key Classes

- `OnboardingCubit`: Primary state management
- `OnboardingPage`: Main UI container
- `OnboardingPageView`: Handles slide display and transitions

## Testing

The feature includes:
- Unit tests for the `OnboardingCubit` and repository
- Widget tests for UI components
- Integration tests for the full onboarding flow 