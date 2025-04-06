# Environment Configuration Tests

This directory contains unit and integration tests for the environment configuration system.

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
fvm flutter test test/core/env/
fvm flutter test --coverage test/core/env/
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
