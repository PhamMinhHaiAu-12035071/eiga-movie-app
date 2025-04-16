# Environment Configuration Tests

This directory contains unit and integration tests for the environment configuration system.

## Overview

The environment configuration feature provides access to environment-specific variables like API URLs, app names, and environment identifiers. These tests verify that the system correctly loads and provides access to these values.

## Test Files Overview

- `domain/env_config_repository_test.dart` - Tests for the repository interface, mock implementations, and validation utilities
- `infrastructure/env_config_repository_impl_test.dart` - Tests for the implementation, error cases, and integration with EnvDev
- `env_development_test.dart` - Tests for environment variables loaded through the envied package

## Test Strategy

The tests use various approaches:

### Interface Testing
Tests the contract defined by `EnvConfigRepository` to ensure:
- All required properties are defined
- Behavior is consistent when mocked

### Implementation Testing
Tests the concrete `EnvConfigRepositoryImpl` to ensure:
- It properly implements the interface
- It correctly retrieves values from EnvDev
- It's registered properly with dependency injection

### Error Handling
Tests how the system handles edge cases:
- Empty values
- Exceptions during access
- Invalid values

### Integration Testing
Tests the complete environment system:
- Values flow correctly from .env files to repository
- Values are consistent throughout the system
- Proper validation is applied

## Mock Implementations

The tests use multiple types of test doubles:

- `MockEnvConfigRepository` - A mocktail-based mock for verifying calls
- `FakeEnvConfigRepository` - A predefined implementation for controlled testing
- `ErrorThrowingEnvConfigRepositoryImpl` - For testing exception handling
- `EmptyEnvConfigRepositoryImpl` - For testing empty value handling

## Running Tests

```bash
# Run all env feature tests
fvm flutter test test/features/env/

# Run specific test files
fvm flutter test test/features/env/domain/env_config_repository_test.dart
fvm flutter test test/features/env/infrastructure/env_config_repository_impl_test.dart
fvm flutter test test/features/env/env_development_test.dart

# Generate coverage report
fvm flutter test --coverage test/features/env/
genhtml coverage/lcov.info -o coverage/html
```

## Documentation

Detailed documentation for the environment testing is available at:

**[Environment Configuration Testing Guide](/docs/testing/ENV_TESTING.md)**

## Quick Reference

### Running Tests

```bash
# Using Make:
make test                 # Run all tests
make coverage             # Generate coverage reports and open in browser

# Using Flutter directly:
fvm flutter test test/features/env/
fvm flutter test --coverage test/features/env/
```

### Test Files Overview

- `domain/` - Tests for the repository interface
- `infrastructure/` - Tests for the implementation
- `env_development_test.dart` - Tests for environment variables
- `env_integration_test.dart` - End-to-end tests
- `env_edge_cases_test.dart` - Error handling tests
- `env_test_helpers.dart` - Helper classes for testing

### Mock Strategy

The tests use various mocking approaches:
- Mocktail for interfaces
- Custom implementations for testing edge cases

For complete details on test structure, coverage requirements, and troubleshooting, please refer to the [main documentation](/docs/testing/ENV_TESTING.md). 