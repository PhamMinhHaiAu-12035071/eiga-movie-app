import 'package:flutter/material.dart';

/// A collection of keys used in widget tests to find specific widgets
///
/// Using centralized keys helps make tests more maintainable by avoiding
/// string duplication across test files.
class TestKeys {
  // Onboarding feature keys
  static const onboardingPage = Key('onboarding_page');
  static const onboardingPageView = Key('onboarding_page_view');
  static const onboardingNextButton = Key('onboarding_next_button');
  static const onboardingSkipButton = Key('onboarding_skip_button');
  static const onboardingDotIndicator = Key('onboarding_dot_indicator');
  static const onboardingHeader = Key('onboarding_header');

  // Environment feature keys
  static const envConfigPage = Key('env_config_page');

  // Storage feature keys
  static const storageWidget = Key('storage_widget');
}
