# Testing Guide

This directory contains all tests for the application, organized according to Clean Architecture principles.

## Directory Structure

```
test/
├── core/                  # Tests for core functionality
├── features/              # Tests for features, mirroring lib/features structure
│   ├── feature_1/
│   │   ├── domain/        # Domain layer tests
│   │   ├── application/   # Application layer tests
│   │   ├── infrastructure/ # Infrastructure layer tests
│   │   └── presentation/  # Presentation layer tests
│   └── ...
└── shared/               # Shared test utilities
    ├── fixtures/         # Test data files in JSON format
    ├── mocks.dart        # Common mock implementations
    ├── keys.dart         # Widget test keys
    └── test_helpers.dart # Common test helper functions
```

## Test Helpers

The `test/shared/test_helpers.dart` file contains utilities to make testing easier:

- `pumpApp()`: Helper to pump a widget with MaterialApp and other necessary wrappers
- `pumpAndSettleWithDuration()`: Helper for tests with animations
- `setUpTestInjection()`: Sets up dependency injection for tests
- `tearDownTestInjection()`: Tears down dependency injection

Example usage:

```dart
void main() {
  setUp(() {
    setUpTestInjection();
  });

  tearDown(() {
    tearDownTestInjection();
  });

  testWidgets('MyWidget test', (tester) async {
    await pumpApp(tester, MyWidget());
    // Test assertions here
  });
}
```

## Test Fixtures

Store test data in JSON files in the `test/shared/fixtures` directory:

```dart
import 'package:test/shared/fixtures/fixture_reader.dart';

// Synchronously load a fixture
final json = fixture('feature_name/data.json');

// Asynchronously load a fixture
final json = await loadFixture('feature_name/data.json');
```

## Widget Test Keys

Use the centralized keys in `test/shared/keys.dart` to find widgets in tests:

```dart
import 'package:test/shared/keys.dart';

// Find a widget using a predefined key
final widget = find.byKey(TestKeys.myWidgetKey);
```

## Mocks

Use the common mocks defined in `test/shared/mocks.dart`:

```dart
import 'package:test/shared/mocks.dart';

final httpClient = MockHttpClient();
final localStorage = MockLocalStorage();
```

## Best Practices

1. **Use table-driven tests** for similar test cases:
   ```dart
   const testCases = [
     {'input': 1, 'expected': 2},
     {'input': 2, 'expected': 4},
   ];
   
   for (final testCase in testCases) {
     test('doubling ${testCase['input']} gives ${testCase['expected']}', () {
       expect(double(testCase['input']), testCase['expected']);
     });
   }
   ```

2. **Group related tests** using `group()`:
   ```dart
   group('MyClass', () {
     group('success cases', () {
       // Success test cases
     });
     
     group('error cases', () {
       // Error test cases
     });
   });
   ```

3. **Follow AAA pattern** (Arrange, Act, Assert):
   ```dart
   test('example test', () {
     // Arrange
     final sut = MyClass();
     
     // Act
     final result = sut.doSomething();
     
     // Assert
     expect(result, expectedValue);
   });
   ```

4. **Keep tests small and focused** - each test should test one specific behavior

5. **Use semantic matchers** like `findsOneWidget`, `findsNWidgets(n)`, etc. for widget tests

6. **Tag slow tests** with `@Tags(['slow'])` to run them separately in CI

## Adding New Tests

1. Create test files that mirror the structure of the code being tested
2. Use the appropriate test helpers and fixtures
3. Follow the naming convention: `{feature}_{class}_test.dart`
4. Ensure each test file focuses on a specific component
5. Keep test files under 300 lines (split them if needed)
6. Ensure all test cases are covered (success, error, edge cases)

## Running Tests

Run all tests:
```
flutter test
```

Run specific tests:
```
flutter test test/features/my_feature
```

Run tests with a specific tag:
```
flutter test --tags="slow"
``` 