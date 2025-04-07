import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:ksk_app/core/env/env_development.dart';
import 'package:ksk_app/core/router/app_router.dart' show AppRouter;
import 'package:ksk_app/core/themes/app_theme.dart';
import 'package:ksk_app/shared/widgets/responsive_initializer.dart';

class App extends StatelessWidget {
  const App({required this.appRouter, super.key});
  final AppRouter appRouter;

  @override
  Widget build(BuildContext context) {
    return ResponsiveInitializer(
      designSize: kIsWeb ? const Size(1024, 768) : const Size(375, 812),
      builder: (context) => MaterialApp.router(
        routerConfig: appRouter.config(),
        theme: AppTheme.light(ThemeData.light()).themeData,
        darkTheme: AppTheme.dark(ThemeData.dark()).themeData,
      ),
    );
  }
}

class CounterPage extends StatefulWidget {
  const CounterPage({super.key});

  @override
  State<CounterPage> createState() => _CounterPageState();
}

class _CounterPageState extends State<CounterPage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(EnvDev.appName),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            const SizedBox(height: 40),
            Text('Environment: ${EnvDev.environmentName}'),
            const SizedBox(height: 16),
            Text('API URL: ${EnvDev.apiUrl}'),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}
