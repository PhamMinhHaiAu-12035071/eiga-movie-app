# Active Context

## Current Focus
- Unit testing for onboarding feature
- Widget testing patterns established
- Fixing deprecated API usage in test files
- Refactoring widgetbook to match main app structure

## Recent Changes
- Implemented comprehensive test coverage for OnboardingPageView widget
- Fixed linting issues in test files:
  - Proper type declarations for callbacks
  - Named parameters for boolean values
  - Correct mock implementations for AssetGenImage
  - Proper MaterialColor usage in color mocks
- Fixed deprecated color properties in test files:
  - Replaced `color.red`, `color.green`, `color.blue` with `color.r.toInt()`, `color.g.toInt()`, `color.b.toInt()`
  - Replaced `color.value` with `color.toARGB32()`
  - Improved mock implementations with proper typing
- Refactored widgetbook structure to match main app structure:
  - Created bootstrap.dart with similar structure to main app bootstrap
  - Added environment-specific entry points (main_development.dart, main_staging.dart, main_production.dart)
  - Updated widgetbook app.dart to use ResponsiveInitializer
  - Aligned initialization flow with main app patterns

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

## Active Decisions
1. Mock Implementation Standards:
   - Use explicit return types for all function declarations
   - Make boolean parameters nullable with default values
   - Implement full interface for visual components
   - Use proper type hierarchies (MaterialColor vs Color)

2. Test Coverage Requirements:
   - Widget rendering
   - User interactions
   - Error states
   - Style application
   - Edge cases

## Next Steps
1. Apply established testing patterns to other onboarding components:
   - OnboardingHeader
   - OnboardingDotIndicator
   - OnboardingNextButton

2. Implement integration tests for full onboarding flow

3. Document test patterns for team reference

4. Complete remaining widgetbook integration:
   - Add additional component showcases
   - Ensure consistent styling between app and widgetbook
   - Document widget usage patterns in widgetbook

## Active Decisions
1. Testing Standards:
   - Use specific widget finders to avoid ambiguity
   - Apply null safety best practices in tests
   - Follow consistent code formatting
   - Implement comprehensive style testing

2. Code Style:
   - Use trailing commas for better git diffs
   - Prefer `var` for boolean flags in tests
   - Use descriptive test names
   - Group related tests logically

## Current Challenges
1. Widget Finding:
   - Multiple instances of similar widgets requiring specific finders
   - Need for careful widget tree traversal
   - Proper handling of async widget updates

2. Style Testing:
   - Null safety in decoration testing
   - Proper type casting for decorations
   - Comprehensive style property verification

## Testing Focus Areas
1. Visual Properties:
   - Colors and gradients
   - Dimensions and padding
   - Text styles and formatting

2. Functionality:
   - Callback handling
   - State management
   - User interactions

3. Edge Cases:
   - Null handling
   - Error states
   - Conditional rendering

## Active Work
We are currently focused on implementing a comprehensive testing strategy across all layers of the application. The main areas of focus are:

1. **Domain Layer Testing**
   - Writing unit tests for entities and value objects
   - Testing use cases and business logic
   - Implementing test coverage for domain services

2. **Widget Testing**
   - Creating widget tests for core components
   - Setting up visual regression testing
   - Implementing the robot pattern for widget test organization

3. **Integration Testing**
   - Building end-to-end tests for main user flows
   - Setting up test data factories
   - Implementing API mocking strategy

### Recent Decisions
1. Adopted mocktail for mocking in tests
2. Implemented robot pattern for widget testing
3. Set up GitHub Actions for CI/CD test automation
4. Chose golden_toolkit for visual regression testing
5. Established 80% as minimum test coverage threshold

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
- Some tests need refactoring for better organization
- Mock data needs better structure
- Test helper utilities need optimization
- Coverage gaps in error scenarios
- Slow test execution in CI

## Dependencies
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

## Current Challenges
1. Test Performance
   - Some widget tests are slower than desired
   - Setup/teardown optimization needed
   - Mock implementation overhead

2. Coverage Gaps
   - Integration test coverage below target
   - Some edge cases not covered
   - Complex widget interactions

3. Technical Debt
   - Linter warnings in test files
   - Inconsistent mock implementations
   - Test documentation gaps

## Notes
- Keep test files organized and well-documented
- Follow established patterns for new tests
- Maintain balance between coverage and maintainability
- Regular review of test performance metrics 