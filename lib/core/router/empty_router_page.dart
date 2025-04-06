import 'package:auto_route/auto_route.dart' show AutoRouter, RoutePage;
import 'package:flutter/material.dart';

@RoutePage()
class EmptyRouterPage extends StatelessWidget {
  const EmptyRouterPage({super.key});

  @override
  Widget build(BuildContext context) => const AutoRouter();
}
