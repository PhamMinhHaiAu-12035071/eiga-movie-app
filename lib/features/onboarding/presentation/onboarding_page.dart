import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

/// OnboardingPage hiển thị các nội dung giới thiệu cho ứng dụng.
@RoutePage()
class OnboardingPage extends StatelessWidget {
  const OnboardingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      // Bạn có thể thiết kế giao diện Onboarding theo ý muốn
      body: Center(
        child: Text(
          'Welcome to Onboarding!',
        ),
      ),
    );
  }
}
