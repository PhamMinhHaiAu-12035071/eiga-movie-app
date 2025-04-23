import 'package:ksk_app/widgetbook/components/onboarding/dot_indicator_component.dart';
import 'package:ksk_app/widgetbook/components/onboarding/onboarding_component.dart';
import 'package:ksk_app/widgetbook/components/onboarding/onboarding_header_component.dart';
import 'package:widgetbook/widgetbook.dart';
// import 'components/login/login_page_component.dart';
// import 'components/login/login_view_component.dart';
// import 'components/shared/responsive_initializer_component.dart';

/// List of all widgetbook components organized by feature
final List<WidgetbookComponent> directories = [
  // Onboarding components
  getOnboardingPageComponent(),
  getDotIndicatorComponent(),
  getOnboardingHeaderComponent(),
  // Login and shared components removed as requested
];
