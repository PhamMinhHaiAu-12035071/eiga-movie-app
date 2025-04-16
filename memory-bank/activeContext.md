# Active Context

## Current Focus
The project is currently in active development, with a focus on implementing the core features and establishing the architectural foundation for the EIGA movie app. The primary focus is on the onboarding feature and the newly added login feature, which represent the first user interactions with the application. Currently, we are refining the UI components of the onboarding screens to match the Figma design and improve code maintainability, while also implementing a simple login screen that appears after the onboarding flow. We're also enhancing the design system by implementing a robust color management approach for better consistency across the application.

**Recent refactor:** The themes module in `lib/core/themes` was refactored to match the structure of the styles module, introducing an `extensions/extensions.dart` index and updating all relevant imports. A new test directory for themes was created, and 100% unit test coverage was achieved for `AppAssetExtension`. Next steps include extending this coverage to `AppColorExtension` and `AppTheme`.

## Recent Changes
1. Set up the project structure following Clean Architecture principles
2. Implemented the environment configuration system
3. Set up the routing system with auto_route
4. Implemented the theme management system
5. Implemented the onboarding feature with domain, application, infrastructure, and presentation layers
6. Refined the onboarding UI components:
   - Created a dedicated OnboardingHeader widget for better maintainability
   - Updated buttons with gradient backgrounds to match design
   - Improved color scheme for dot indicators and skip button
   - Enhanced layout with proper spacing and positioning
   - Applied UI improvements based on Figma design
   - Added movie-themed content and messaging
     - "EIGA" branding in header
     - "Choose movies, watch trailers, take tickets" messaging
     - "Find Your Favorite Movies" feature highlight
     - "Book movie tickets anytime, anywhere" feature highlight
7. Improved the color system:
   - Refactored AppColors to use MaterialColor for better shade variations
   - Standardized color usage across the application
   - Removed direct color references in favor of AppColors
   - Added common colors like black, white, and grey as MaterialColors
8. Restructured project organization:
   - Moved sizes directory out of styles to be at the same level as other directories in core
   - Updated imports in styles.dart to reference the new location
   - Maintained all existing functionality with a cleaner hierarchy
9. Implemented centralized duration system:
   - Created durations directory in core for managing animation timing
   - Defined AppDurations class with standardized durations (veryShort, short, medium, long, extraLong, oneSecond)
   - Refactored hardcoded duration values in onboarding feature to use AppDurations
   - Improved maintainability by centralizing animation timing constants
10. Updated repository naming conventions:
    - Removed "I" prefix from repository interfaces (e.g., changed `IFeatureRepository` to `FeatureRepository`)
    - Added "Impl" suffix to repository implementations (e.g., changed `FeatureRepository` to `FeatureRepositoryImpl`)
    - Updated all references throughout the codebase to reflect new naming convention
    - Regenerated dependency injection code to maintain functionality
11. Implemented abstraction for local storage:
    - Created `LocalStorageService` interface in core/services to abstract storage operations
    - Implemented `SharedPreferencesStorageService` as a concrete implementation
    - Updated `OnboardingRepositoryImpl` to depend on the abstraction instead of directly on SharedPreferences
    - Improved compliance with SOLID principles (Dependency Inversion)
    - Enhanced testability by making it easier to mock storage dependencies
12. Implemented the login feature:
    - Created login feature directory structure following Clean Architecture
    - Added LoginRoute to AppRouter for navigation from onboarding
    - Implemented LoginState using Equatable for simple state management
    - Created LoginCubit for handling login screen state
    - Developed LoginPage with proper styling and responsiveness
    - Built LoginView to display welcome message following design guidelines
    - Added "Welcome to EIGA!" and "Your movie journey begins here" messaging
    - Added detailed feature documentation in README.md
13. Created storage feature:
    - Implemented a dedicated storage feature with domain, infrastructure layers
    - Created `StorageFailure` class to represent storage operation failures
    - Implemented `LocalStorageService` interface with methods for local storage operations
    - Created `SharedPreferencesStorageService` implementation based on SharedPreferences
    - Added comprehensive unit tests with 100% coverage for the storage feature
    - Fixed lint issues in test files to follow 80-character line limit
14. Improved Makefile:
    - Simplified Makefile by removing specialized test and coverage commands
    - Updated coverage generation commands for better clarity
    - Streamlined the project command structure
15. Refactored environment configuration from core module to feature-based architecture:
    - Moved environment configuration from `core/env` to `features/env` directory
    - Reorganized according to Clean Architecture principles with domain and infrastructure layers
    - Consolidated test files to match the implementation structure
    - Fixed failing dependency injection tests
    - Ensured all tests pass with the new structure
    - Improved test organization by consolidating helper classes into appropriate test files
    - Regenerated dependency injection code to maintain functionality
    - Updated environment configuration for movie app API endpoints (eigamovie.com)
16. Fixed dependency injection test failure:
    - Fixed incorrect test for unregistered dependency resolution in `test/core/di/injection_test.dart`
    - The original test was trying to test that GetIt directly would throw when requesting an unregistered dependency
    - Corrected to properly use a function expression to check that trying to resolve an unregistered dependency throws
    - Updated test to use `expect(() => getIt<UnregisteredDependency>(), throwsA(anything))` pattern
    - Ensures that the test now accurately verifies that GetIt properly throws when trying to resolve unregistered dependencies
17. Rebranded the application from a generic order data input app to the EIGA Movie App:
    - Updated app name and branding throughout the codebase
    - Refocused application purpose on cinema ticket booking experience
    - Modified onboarding content to highlight movie-related features
    - Adjusted login screen to reflect the movie app experience

## Current Tasks
1. Complete the onboarding feature implementation
   - Finalize UI design and animations
   - ✅ Implement persistence of onboarding status
   - Add comprehensive unit and widget tests
   
2. Complete the login feature implementation
   - ✅ Basic welcome screen
   - Design and implement login form with username/password fields
   - Add authentication logic
   - Implement form validation
   - Add error handling for authentication failures

3. ✅ Create storage feature for better data persistence
   - ✅ Implement dedicated storage feature module
   - ✅ Add comprehensive unit tests with 100% coverage
   - ✅ Ensure proper error handling for storage operations

4. ✅ Refactor environment configuration to follow feature-based architecture
   - ✅ Move from core/env to features/env
   - ✅ Update import paths throughout the codebase
   - ✅ Reorganize and enhance tests
   - ✅ Ensure all tests pass with the new structure

5. Prepare for the movie listing feature implementation
   - Define domain models for movies and related entities
   - Design repository interfaces for movie data access
   - Plan UI components for movie browsing and details view
   - Design API integration for fetching movie data

6. Improve development infrastructure
   - Enhance CI/CD pipeline
   - Add linting rules and code quality checks
   - ✅ Apply SOLID principles through abstractions
   - ✅ Set up automated testing with Makefile commands
   - ✅ Improve Makefile for better development workflow
   - ✅ Fix failing tests in dependency injection module

## Active Decisions and Considerations

### Architecture Decisions
1. **Clean Architecture**: The project follows Clean Architecture principles to ensure separation of concerns and testability. This decision impacts how features are organized and how dependencies flow.

2. **State Management**: Using BLoC pattern for state management to ensure unidirectional data flow and predictable state changes.

3. **Dependency Injection**: Using get_it and injectable for dependency injection to facilitate testing and decouple components.

4. **Feature-First Organization**: Moving core functionality like environment configuration to feature-based modules to improve cohesion and maintainability.

### Technical Considerations
1. **Performance**: Need to ensure smooth animations and transitions, especially in the onboarding feature.

2. **Offline Support**: Planning for offline capability, requiring careful design of data persistence and synchronization.

3. **Code Generation**: Heavily relying on code generation for immutable models, JSON serialization, routing, and dependency injection, which impacts the development workflow.

4. **API Integration**: Need to design robust movie data fetching and caching strategies for optimal performance.

### Design Considerations
1. **Responsive Design**: Ensuring the UI works well on various device sizes using flutter_screenutil.

2. **Accessibility**: Need to implement proper accessibility features, including screen reader support and adequate contrast.

3. **Localization**: Implementing localization support from the beginning to avoid refactoring later.

4. **Movie-Specific UI Patterns**: Implementing effective movie browsing, filtering, and ticket booking UI patterns that follow industry standards while maintaining uniqueness.

## Next Steps
1. Complete the onboarding feature
2. Expand the login feature with full authentication
3. Begin implementation of the movie listing feature
4. Plan and design the ticket booking feature
5. Set up comprehensive testing infrastructure
6. Enhance the CI/CD pipeline for automated testing and deployment

## Blockers and Challenges
1. Need to finalize API specifications for movie data and authentication
2. Determining the best approach for handling offline movie browsing
3. Ensuring consistent design across different platforms
4. Optimizing performance for devices with limited resources
5. Implementing an efficient and intuitive seat selection interface for the ticket booking feature 