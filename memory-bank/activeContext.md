# Active Context

## Current Focus
- Analyzing the onboarding feature implementation
- **Successfully reaching 100% test coverage for the OnboardingPage component**
- Reviewing the responsive design patterns between portrait and landscape orientations
- Understanding navigation patterns, particularly route replacement techniques
- Examining widget structure and component organization
- Unit testing for core components following refactoring
- Completing test coverage for refactored lib/core structure
- Ensuring proper alignment between production code and test code
- Enhancing widgetbook showcases to match the latest structure
- Applying established widget testing patterns to core components
- Addressing performance issues in widget tests
- **Updating memory bank and rules (`@common`) to formalize orientation handling patterns.**

## Recent Findings
- ✅ Analyzed onboarding feature implementation:
  - The `OnboardingPage` is a stateful widget that handles orientation changes
  - It uses a `PageController` to control page swiping animations
  - Contains separate views for portrait and landscape orientations
  - Integrates with `OnboardingCubit` for state management
  - Uses `context.router.replace()` for navigation after completing onboarding

- ✅ Identified responsive design patterns:
  - Portrait and landscape views are implemented as separate components
  - `OnboardingPortraitView` for vertical layout optimization
  - `OnboardingLandscapeView` for horizontal layout optimization
  - Media queries detect orientation changes and render appropriate view
  - Common components like dot indicators and buttons are shared between views

- ✅ Analyzed UI structure differences:
  - Portrait: Vertical stacking with image on top, text below
  - Landscape: Horizontal split with image on left, text on right
  - Portrait uses more vertical space for images (flex: 3)
  - Landscape optimizes horizontal space with different flex ratios (5:7)
  - Both use consistent branding (logo, colors, text)

- ✅ Identified navigation patterns:
  - Route replacement used to navigate from onboarding to login
  - `context.router.replace(const LoginRoute())` pattern for navigation
  - Ensures back button doesn't return to onboarding after completion
  - Testing with mock routers to verify navigation behavior

## Recent Changes
- ✅ Refactored lib/core directory structure:
  - Organized into clear, focused subdirectories (di, router, asset, styles, sizes, durations, themes)
  - Split DI modules for clearer separation of concerns
  - Added API module for network communication
  - Removed RegisterModule in favor of more specific modules
  - Aligned test directory structure with production code
- ✅ Updated themes directory structure:
  - Added extensions directory with extensions.dart barrel file
  - Created app_theme.dart for main theme configuration
  - Added themes.dart barrel file for easy imports
- ✅ Updated testing infrastructure:
  - Created matching test directory structure for refactored core components
  - Updated test/core structure to mirror lib/core
  - Removed obsolete test/core/di/register_module_test.dart
  - Added new tests for specific DI modules
- ✅ Implemented comprehensive test coverage for OnboardingPage widget (100%)
  - Fixed failing tests by switching from direct callback invocation to UI interactions
  - Added specific tests for portrait and landscape orientation interactions
  - Ensured all callback methods were tested with proper verifications
  - Successfully covered all branches in orientation-specific layouts and interactions
- ✅ Updated mock implementations to follow consistent patterns:
  - Explicit return types for all function declarations
  - Boolean parameters made nullable with default values
  - Full interface implementation for visual components
  - Proper type hierarchies (MaterialColor vs Color)
- ✅ Fixed linting issues in test files:
  - Proper type declarations for callbacks
  - Named parameters for boolean values
  - Correct mock implementations for AssetGenImage
  - Proper MaterialColor usage in color mocks
- ✅ Fixed deprecated color properties in test files:
  - Replaced `color.red`, `color.green`, `color.blue` with `color.r.toInt()`, `color.g.toInt()`, `color.b.toInt()`
  - Replaced `color.value` with `color.toARGB32()`
  - Improved mock implementations with proper typing
- ✅ Refactored widgetbook structure to match main app structure:
  - Created bootstrap.dart with similar structure to main app bootstrap
  - Added environment-specific entry points (main_development.dart, main_staging.dart, main_production.dart)
  - Updated widgetbook app.dart to use ResponsiveInitializer
  - Aligned initialization flow with main app patterns
- ✅ Enhanced widgetbook developer experience:
  - Added InspectorAddon, GridAddon, AlignmentAddon, ZoomAddon for advanced layout/debugging
  - Greatly expanded DeviceFrameAddon list: now covers a wide range of iOS/Android phones and tablets (including iPhone12Mini, iPhone12ProMax, iPadAir4, iPadPro11Inches, iPad12InchesGen2/4, Samsung Galaxy A50, Sony Xperia 1 II, and generic small/medium/large devices)
- ✅ Implemented proper teardown in widget tests to prevent test interference
- ✅ Converted static methods to factory constructors in mock classes
- ✅ Improved error handling in test assertions and validations

## Testing Patterns Established
1. Mock Dependencies:
   ```dart
   - AppSizes: Explicit numeric values for dimensions
   - AppTextStyles: Basic style implementations
   - AppColors: MaterialColor implementations with proper color component access
   - AssetGenImage: Full mock with error handling
   ```

2. Widget Test Structure:
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

3. Standard Test Cases:
   - Basic rendering verification
   - User interaction handling
   - Error state management
   - Style and layout verification
   - Edge cases (empty states, rapid interactions)
   - Animation and transition testing

4. Coverage Requirements:
   - Widget tree structure verification
   - State management testing
   - Callback validation
   - Style property verification
   - Error handling validation
   - Edge case coverage

## Active Decisions
1. Core Directory Structure:
   - Maintaining clear separation between different core functionalities
   - Organizing themes with proper extensions support
   - Keeping styles and sizes separate for better organization
   - Using barrel files for easy imports

2. Test Structure:
   - Mirror production code structure in test directory
   - Create dedicated test files for each component
   - Focus on thorough test coverage for refactored components
   - Verify both functionality and integration

3. Mock Implementation Standards:
   - Use explicit return types for all function declarations
   - Make boolean parameters nullable with default values
   - Implement full interface for visual components
   - Use proper type hierarchies (MaterialColor vs Color)
   - Factory constructors preferred over static methods
   - Proper error handling in mock implementations

4. Test Coverage Requirements:
   - Widget rendering
   - User interactions
   - Error states
   - Style application
   - Edge cases
   - Animation and transitions

5. Performance Optimization:
   - Optimize setup and teardown procedures
   - Minimize unnecessary widget rebuilds in tests
   - Improve test data generation
   - Enhance mock implementation efficiency
   
6. **Widget Testing Best Practices**:
   - **Avoid direct callback invocation when possible**
   - **Use UI interactions (tester.tap, tester.drag) for more realistic tests**
   - **Test portrait and landscape orientations separately**
   - **Set appropriate window sizes for orientation-specific tests**
   - **Ensure that orientation-specific views are properly tested**

## Next Steps
1. Implement updated tests for refactored core components:
   - DI module tests
   - API module tests
   - Routing tests
   - Styles, sizes, durations tests
   - Theme tests with extensions
2. Implement widget tests for remaining onboarding components:
   - OnboardingHeader
   - OnboardingNextButton
3. Implement unit tests for:
   - OnboardingCubit
   - OnboardingRepository
4. Implement integration tests for full onboarding flow:
   - Page navigation
   - Persistence verification
   - State management testing
5. Document established test patterns for team reference:
   - Create testing guidelines document
   - Update widget test templates
   - Standardize mock implementations
6. Complete remaining widgetbook integration:
   - Add showcases for OnboardingHeader, NextButton, DotIndicator
   - Ensure consistent styling between app and widgetbook
   - Document widget usage patterns in widgetbook
7. Optimize test performance:
   - Refactor setup and teardown procedures
   - Improve mock implementation efficiency
   - Enhance test data generation
8. **Apply updated rules regarding responsive/orientation handling to future features.**

## Current Challenges
1. Widget Finding:
   - Multiple instances of similar widgets requiring specific finders
   - Need for careful widget tree traversal
   - Proper handling of async widget updates
   - Ensuring stable test execution across different environments

2. Style Testing:
   - Null safety in decoration testing
   - Proper type casting for decorations
   - Comprehensive style property verification
   - Ensuring consistent style validation across different widgets

3. Test Performance:
   - Some widget tests are slower than desired
   - Setup/teardown procedures need optimization
   - Mock implementation overhead affecting test execution time
   - Balancing comprehensive testing with execution speed

4. Coverage Gaps:
   - Some edge cases not fully covered
   - Integration test coverage below target
   - Animation and transition testing incomplete
   - Error scenario coverage needs improvement

## Notes
- Keep test files organized and well-documented
- Follow established patterns for new tests
- Maintain balance between coverage and maintainability
- Regular review of test performance metrics
- Continuously refine mock implementations based on lessons learned
- Consider breaking complex tests into smaller, focused tests
- Prioritize readability and maintainability in test code
- **For orientation testing, prefer actual UI interactions over direct method calls**
- **Use `tester.binding.window.physicalSizeTestValue` to properly set orientation in tests**

## Active Work
We are currently focused on implementing a comprehensive testing strategy for the refactored core components. The main areas of focus are:

1. **Core Component Testing**
   - Updating/creating tests for DI modules
   - Testing API module functionality
   - Ensuring proper styling and theming tests
   - Validating assets and resource handling

2. **Widget Testing**
   - ✅ Creating widget tests for core components (OnboardingPage completed with 100% coverage)
   - 🚧 Creating widget tests for remaining Onboarding components (Header, NextButton)
   - Setting up visual regression testing
   - Implementing the robot pattern for widget test organization

3. **Integration Testing**
   - Building end-to-end tests for main user flows
   - Setting up test data factories
   - Implementing API mocking strategy

### Recent Decisions
1. Refactored lib/core for better organization and maintainability
2. Aligned test structure with production code structure
3. Set up Github Actions for CI/CD test automation
4. Established testing standards for the refactored code
5. Committed to maintaining high test coverage during refactoring

### Current Challenges
1. Handling async operations in widget tests
2. Managing test data consistency
3. Platform-specific golden test issues
4. CI/CD pipeline optimization needed
5. Test execution performance improvements required

### Active Considerations
- Balance between test coverage and maintenance overhead
- Strategies for handling flaky tests
- Approach to testing responsive layouts
- Management of test data and fixtures
- Integration of performance testing

## Technical Debt
- Some tests need updating to match refactored code structure
- Mock data needs better structure
- Test helper utilities need optimization
- Coverage gaps in error scenarios
- Slow test execution in CI

## Dependencies
(Verify these versions against pubspec.lock if needed)
- mocktail: ^1.0.0
- flutter_test: sdk: flutter
- integration_test: sdk: flutter
- golden_toolkit: ^1.0.0
- coverage: ^1.0.0

## Notes
- Consider implementing custom test runners for different test suites
- Need to improve error handling coverage
- Visual regression tests needed for dark/light theme variations
- Consider adding mutation testing
- Document test patterns for new contributors 