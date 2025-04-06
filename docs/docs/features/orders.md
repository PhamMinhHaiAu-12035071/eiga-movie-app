---
sidebar_position: 2
title: Orders
description: Order management in the KSK App
---

# Orders

The Orders module is the core feature of the KSK App, allowing workers to manage order data efficiently.

## Features

- Create new orders
- Update existing orders
- View order details
- Filter and search orders
- Offline support
- Synchronize with the backend

## Architecture

### Domain Layer

#### Entities

- `Order` - Represents an order in the system
- `OrderItem` - Represents an item within an order
- `OrderStatus` - Enum representing the status of an order
- `OrderFilter` - Contains filter parameters for order queries

#### Repository Interface

```dart
abstract class OrderRepository {
  Future<Either<OrderFailure, List<Order>>> getOrders(OrderFilter filter);
  Future<Either<OrderFailure, Order>> getOrderById(String id);
  Future<Either<OrderFailure, Unit>> createOrder(Order order);
  Future<Either<OrderFailure, Unit>> updateOrder(Order order);
  Future<Either<OrderFailure, Unit>> deleteOrder(String id);
  Stream<List<Order>> watchOrders(OrderFilter filter);
}
```

### Application Layer

#### UseCases

- `GetOrdersUseCase` - Retrieves orders based on filter criteria
- `GetOrderByIdUseCase` - Retrieves a specific order
- `CreateOrderUseCase` - Creates a new order
- `UpdateOrderUseCase` - Updates an existing order
- `DeleteOrderUseCase` - Deletes an order
- `WatchOrdersUseCase` - Provides a stream of orders

#### State Management

The orders state is managed using the Bloc pattern:

```dart
class OrdersBloc extends Bloc<OrdersEvent, OrdersState> {
  final GetOrdersUseCase _getOrdersUseCase;
  final CreateOrderUseCase _createOrderUseCase;
  final UpdateOrderUseCase _updateOrderUseCase;
  final DeleteOrderUseCase _deleteOrderUseCase;
  final WatchOrdersUseCase _watchOrdersUseCase;
  
  // Implementation details...
}
```

### Infrastructure Layer

#### Repository Implementation

```dart
@Injectable(as: OrderRepository)
class OrderRepositoryImpl implements OrderRepository {
  final OrderApiClient _apiClient;
  final OrderLocalDataSource _localDataSource;
  final NetworkInfo _networkInfo;
  
  // Implementation details...
}
```

#### Local Data Source

The app uses a local database to store orders for offline access:

```dart
abstract class OrderLocalDataSource {
  Future<List<OrderModel>> getOrders(OrderFilterModel filter);
  Future<OrderModel> getOrderById(String id);
  Future<void> cacheOrders(List<OrderModel> orders);
  Future<void> cacheOrder(OrderModel order);
  Future<void> deleteOrder(String id);
  Stream<List<OrderModel>> watchOrders(OrderFilterModel filter);
}
```

### Presentation Layer

The orders UI includes:

- Order list screen
- Order details screen
- Order creation form
- Order update form

## Offline Support

The Orders module provides offline support through:

1. Local caching of order data
2. Background synchronization when connectivity is restored
3. Conflict resolution for concurrent edits
4. Optimistic UI updates

## Data Synchronization

The app implements a two-way synchronization mechanism:

1. Pull synchronization: Fetches the latest order data from the server
2. Push synchronization: Sends local changes to the server when connectivity is available

The synchronization process follows these steps:

1. Check for connectivity
2. Fetch server changes
3. Detect conflicts
4. Resolve conflicts using a last-write-wins strategy
5. Push local changes
6. Update local cache

## Usage Example

Creating a new order:

```dart
final order = Order(
  id: uuid.v4(),
  customerId: 'customer-123',
  items: [
    OrderItem(productId: 'product-1', quantity: 2, price: 25.0),
    OrderItem(productId: 'product-2', quantity: 1, price: 15.0),
  ],
  status: OrderStatus.pending,
  createdAt: DateTime.now(),
);

final result = await orderRepository.createOrder(order);
result.fold(
  (failure) => // Handle failure,
  (_) => // Order created successfully
);
``` 