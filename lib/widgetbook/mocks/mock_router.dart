import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

// Giả sử AppRouter kế thừa từ RootStackRouter,
// nếu không hãy thay thế bằng lớp cha đúng
// Kiểm tra lại lib/core/router/app_router.dart để chắc chắn lớp cha là RootStackRouter
// Nếu AppRouter extends <T> extends RootStackRouter thì cần điều chỉnh lại
class MockAppRouter extends RootStackRouter {
  MockAppRouter() : super(navigatorKey: GlobalKey<NavigatorState>());

  Map<String, AutoRoutePage<dynamic>> get pagesMap =>
      {}; // Sửa PageFactory thành AutoRoutePage<dynamic>

  @override
  List<AutoRoute> get routes => []; // Không cần thiết cho mock

  @override
  Future<T?> replace<T extends Object?>(
    PageRouteInfo route, {
    OnNavigationFailure? onFailure,
  }) async {
    debugPrint(
      'Widgetbook: Navigating (replace) to ${route.routeName} - Mocked',
    );
    // Không làm gì cả để tránh lỗi
    return null;
  }

  @override
  Future<T?> push<T extends Object?>(
    PageRouteInfo route, {
    OnNavigationFailure? onFailure,
  }) async {
    debugPrint('Widgetbook: Navigating (push) to ${route.routeName} - Mocked');
    return null;
  }

  @override
  Future<bool> pop<T extends Object?>([T? result]) async {
    debugPrint('Widgetbook: Popping route - Mocked');
    return true; // Giả lập thành công
  }
}

// Widget helper để cung cấp mock router
class MockRouterProvider extends StatelessWidget {
  const MockRouterProvider({
    required this.child,
    super.key,
  });
  final Widget child;

  @override
  Widget build(BuildContext context) {
    // Cung cấp mock router thông qua StackRouterScope
    return StackRouterScope(
      controller: MockAppRouter(), // Sử dụng mock router của bạn
      stateHash: 0, // Giá trị tùy ý, dùng 0 cho đơn giản
      child: child,
    );
  }
}
