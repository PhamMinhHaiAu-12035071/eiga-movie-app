import 'package:flutter/material.dart';
import 'package:ksk_app/core/router/app_router.dart' show AppRouter;
import 'package:ksk_app/core/themes/themes.dart';
import 'package:ksk_app/shared/widgets/responsive_initializer.dart';

class App extends StatelessWidget {
  const App({required this.appRouter, super.key});
  final AppRouter appRouter;

  @override
  Widget build(BuildContext context) {
    return ResponsiveInitializer(
      builder: (context) => MaterialApp.router(
        routerConfig: appRouter.config(),
        theme: AppTheme.light(ThemeData.light()).themeData,
        darkTheme: AppTheme.dark(ThemeData.dark()).themeData,
      ),
    );
  }
}
