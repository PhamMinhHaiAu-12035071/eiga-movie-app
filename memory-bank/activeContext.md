# Active Context

## Current Focus
- Analyzing the onboarding feature implementation
- **Successfully reaching 100% test coverage for the OnboardingPage and OnboardingLogo components**
- Updating widget implementation and unit tests to maintain alignment
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
- **Building and testing movie-related features (browse, details, ticket booking)**

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
- ✅ Updated HeaderTitle widget to improve text handling:
  - Added `maxLines` property with default value of 1
  - Implemented `TextOverflow.ellipsis` for proper text truncation
  - Updated unit tests to verify both default and custom maxLines values
  - Updated widgetbook component to include maxLines configuration knob
  - Ensured tests are aligned with implementation for 100% coverage
  - Successfully tested both default behavior and parameter overrides
- ✅ Achieved 100% test coverage for OnboardingLogo widget:
  - Added tests for fixed widget keys (`onboarding_logo_container` and `onboarding_logo_image_container`)
  - Implemented individual parameter override tests (containerSize, imageSize, borderRadius, containerColor)
  - Added widget hierarchy test to verify correct structure (Container → Center → SizedBox → Image)
  - Ensured all properties and their default values are properly tested
  - Verified that individual parameter overrides maintain other default values
  - All tests pass successfully, confirming widget robustness and flexibility
- ✅ Refactored HorizontalGap widget:
  - Completely removed the redundant HorizontalGap widget
  - Replaced all usages with the Gap widget from the 'gap' package directly
  - Updated OnboardingHeader to use Gap directly: `Gap(gapWidth ?? sizes.h16)`
  - Removed HorizontalGap Widgetbook component and its reference in directories.dart
  - Deleted horizontal_gap_test.dart as it's no longer needed
  - Simplified codebase by eliminating unnecessary abstraction
- ✅ Refactored HeaderTitleGroup component:
  - Added `spacing` property (default 3.29) to control gap between title and subtitle
  - Uses `Gap(spacing.h)` for responsive spacing between elements
  - Maintained consistent structure with title on top, subtitle below
  - Updated widgetbook component to include spacing slider for easy adjustment
  - Implemented comprehensive tests to verify spacing behavior
  - Ensured 100% test coverage for both default and custom spacing values
- ✅ Refactored OnboardingHeader component:
  - Simplified structure to use Row as the root element (removed ColoredBox and Padding)
  - Renamed `gapWidth` parameter to `spacing` for better consistency
  - Changed default spacing value to 14.0 
  - Changed image size calculation to 63% of container size (was 60%)
  - Updated widgetbook component to use the new parameters
  - Uses ScreenUtil for responsive spacing with `spacing.w`
  - Updated unit tests to verify the new structure and parameters
  - Ensured 100% test coverage for the updated implementation
- ✅ Refactored OnboardingHeader unit tests:
  - Completely rewrote tests to match the new simplified structure
  - Removed tests for ColoredBox and Padding (now removed from the component)
  - Added specific tests for default spacing value (14.0.w)
  - Added test for custom spacing via constructor
  - Added test for custom title and subtitle
  - Added more verification for HeaderTitleGroup integration
  - Used specific widget finders to identify Gap widgets correctly
  - Fixed tests to properly handle ScreenUtil responsive units
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
- ✅ **Created movie discovery and browsing feature structure (in progress)**
- ✅ **Established Cinema entity model for ticket booking feature (in progress)**

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
   - Individual parameter override testing to ensure defaults are maintained
   - Widget tree hierarchy verification

4. Coverage Requirements:
   - Widget tree structure verification
   - State management testing
   - Callback validation
   - Style property verification
   - Error handling validation
   - Edge case coverage
   - Testing each parameter individually to ensure proper overrides and defaults
   - Widget key verification for critical components

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
   - Test parameters individually to ensure proper behavior

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
   - Individual parameter overrides
   - Widget tree hierarchy

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
   - **When updating widget implementation, ensure tests are updated to match**
   - **Verify all widget properties including color, padding, and layout**
   - **Test individual parameter overrides to ensure other defaults are maintained**
   - **Verify widget key consistency and correct usage**
   - **Test widget hierarchy to ensure proper component nesting**

7. **Responsive Design Pattern**:
   - **Use separate view components for significantly different layouts**
   - **Create PortraitView and LandscapeView components when layouts differ**
   - **Use MediaQuery or OrientationBuilder to detect orientation**
   - **Share common components between orientations for consistency**
   - **Optimize layouts based on orientation (vertical vs horizontal flow)**
   - **Maintain consistent UX across orientations**

## Next Steps
1. Implement updated tests for refactored core components:
   - DI module tests
   - API module tests
   - Routing tests
   - Styles, sizes, durations tests
   - Theme tests with extensions
2. Implement widget tests for remaining onboarding components:
   - ✅ OnboardingHeader (Completed with 100% coverage)
   - ✅ OnboardingLogo (Completed with 100% coverage)
   - ✅ HeaderTitleGroup (Completed with 100% coverage)
   - OnboardingNextButton (Pending)
3. **Implement Movie Browse feature**:
   - Create domain models and repositories
   - Implement application layer (BLoC/Cubit)
   - Build UI components with responsive design
   - Implement movie card and list components
   - Add navigation to movie details
4. **Implement Movie Details feature**:
   - Create detail view with trailer support
   - Add booking button integration
   - Implement responsive layout with portrait/landscape views
5. **Begin Ticket Booking feature**:
   - Design seat selection interface
   - Implement cinema, showtime, and seat models
   - Create booking flow with state management

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

5. Widget Updates:
   - Maintaining alignment between widget implementation and tests
   - Ensuring test coverage after code changes
   - Properly testing updated widget properties
   - Handling visual regression testing

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
- **When updating widgets, always update tests to match implementation changes**
- **For subtle implementation changes, verify test coverage remains at 100%**

## Active Work
We are currently focused on implementing a comprehensive testing strategy for the refactored core components and completing all onboarding widget tests. Recently completed the OnboardingHeader tests to match implementation changes, successfully maintaining 100% test coverage while transitioning from Padding to Container-based implementation.

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