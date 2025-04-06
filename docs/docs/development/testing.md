---
sidebar_position: 1
title: Testing
description: Testing strategy and implementation for the KSK App
---

# Testing

This document outlines the testing strategy for the KSK App, including unit tests, widget tests, and integration tests.

## Testing Strategy

The KSK App follows a comprehensive testing approach:

1. **Unit Tests**: Test individual components in isolation
2. **Widget Tests**: Test UI components and their interactions
3. **Integration Tests**: Test the integration between different parts of the application
4. **E2E Tests**: Test the application as a whole from a user's perspective

## Test Coverage

The project aims for high test coverage:

- Domain Layer: 100% coverage
- Application Layer: 100% coverage
- Infrastructure Layer: 80%+ coverage
- Presentation Layer: 70%+ coverage

Overall target: **>= 95%** test coverage

## Unit Testing

### Domain Layer

Domain layer tests focus on entities, value objects, and business rules.

Example:

```dart
void main() {
  group('Order', () {
    test('should calculate total correctly', () {
      final order = Order(
        id: '1',
        items: [
          OrderItem(productId: '1', quantity: 2, price: 10.0),
          OrderItem(productId: '2', quantity: 1, price: 20.0),
        ],
        status: OrderStatus.pending,
        createdAt: DateTime.now(),
      );
      
      expect(order.total, 40.0);
    });
  });
}
```

### Application Layer

Application layer tests focus on use cases and state management (Bloc/Cubit).

Example:

```dart
void main() {
  late MockOrderRepository repository;
  late GetOrdersUseCase useCase;
  
  setUp(() {
    repository = MockOrderRepository();
    useCase = GetOrdersUseCase(repository);
  });
  
  test('should get orders from the repository', () async {
    // Arrange
    final orders = [Order(id: '1'), Order(id: '2')];
    final filter = OrderFilter();
    when(repository.getOrders(filter))
        .thenAnswer((_) async => Right(orders));
    
    // Act
    final result = await useCase(filter);
    
    // Assert
    expect(result, Right(orders));
    verify(repository.getOrders(filter)).called(1);
  });
}
```

### Infrastructure Layer

Infrastructure layer tests focus on repository implementations and API services.

Example:

```dart
void main() {
  late OrderRepositoryImpl repository;
  late MockOrderApiClient apiClient;
  late MockOrderLocalDataSource localDataSource;
  late MockNetworkInfo networkInfo;
  
  setUp(() {
    apiClient = MockOrderApiClient();
    localDataSource = MockOrderLocalDataSource();
    networkInfo = MockNetworkInfo();
    repository = OrderRepositoryImpl(
      apiClient: apiClient,
      localDataSource: localDataSource,
      networkInfo: networkInfo,
    );
  });
  
  group('getOrders', () {
    test('should return remote data when the device is online', () async {
      // Test implementation...
    });
    
    test('should return local data when the device is offline', () async {
      // Test implementation...
    });
  });
}
```

## Widget Testing

Widget tests focus on UI components and their interactions.

Example:

```dart
void main() {
  testWidgets('OrderListItem should display order information', (WidgetTester tester) async {
    // Build the widget
    final order = Order(
      id: '1',
      customerId: 'customer-1',
      items: [OrderItem(productId: '1', quantity: 2, price: 10.0)],
      status: OrderStatus.completed,
      createdAt: DateTime.now(),
    );
    
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: OrderListItem(order: order),
        ),
      ),
    );
    
    // Verify that the widget displays the order ID
    expect(find.text('Order #1'), findsOneWidget);
    
    // Verify that the widget displays the order status
    expect(find.text('Completed'), findsOneWidget);
    
    // Verify that the widget displays the order total
    expect(find.text('\$20.00'), findsOneWidget);
  });
}
```

## Integration Testing

Integration tests focus on the integration between different parts of the application.

Example:

```dart
void main() {
  late MockOrderRepository repository;
  late OrdersBloc bloc;
  
  setUp(() {
    repository = MockOrderRepository();
    bloc = OrdersBloc(repository);
  });
  
  testWidgets('OrdersPage should display a list of orders', (WidgetTester tester) async {
    // Arrange
    final orders = [
      Order(id: '1', customerId: 'customer-1', status: OrderStatus.pending),
      Order(id: '2', customerId: 'customer-2', status: OrderStatus.completed),
    ];
    
    when(repository.getOrders(any)).thenAnswer((_) async => Right(orders));
    
    // Act
    await tester.pumpWidget(
      MaterialApp(
        home: BlocProvider.value(
          value: bloc,
          child: OrdersPage(),
        ),
      ),
    );
    
    // Trigger the bloc event
    bloc.add(OrdersEvent.fetchOrders());
    await tester.pumpAndSettle();
    
    // Assert
    expect(find.text('Order #1'), findsOneWidget);
    expect(find.text('Order #2'), findsOneWidget);
    expect(find.text('Pending'), findsOneWidget);
    expect(find.text('Completed'), findsOneWidget);
  });
}
```

## Running Tests

### Unit and Widget Tests

```bash
# Run all tests
fvm flutter test

# Run tests with coverage
fvm flutter test --coverage

# Generate coverage report
genhtml coverage/lcov.info -o coverage/
open coverage/index.html
```

### Integration Tests

```bash
# Run integration tests
fvm flutter test integration_test
```

## Mocking

The project uses `mocktail` for mocking dependencies in tests.

Example:

```dart
class MockOrderRepository extends Mock implements OrderRepository {}

// In tests
final repository = MockOrderRepository();
when(repository.getOrders(any)).thenAnswer((_) async => Right(orders));
```

## Continuous Integration

The project uses GitHub Actions for continuous integration, which runs all tests on every pull request and push to the main branch.

The CI pipeline:

1. Sets up Flutter
2. Installs dependencies
3. Analyzes the code
4. Runs tests with coverage
5. Uploads coverage reports
6. Fails if coverage is below the threshold 