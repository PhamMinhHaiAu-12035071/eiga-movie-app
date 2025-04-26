import 'package:ksk_app/widgetbook/components/onboarding/atoms/dot_indicator_atom_component.dart'
    show getDotIndicatorAtomComponent;
import 'package:ksk_app/widgetbook/components/onboarding/atoms/header_subtitle_component.dart';
import 'package:ksk_app/widgetbook/components/onboarding/atoms/header_title_component.dart';
import 'package:ksk_app/widgetbook/components/onboarding/atoms/onboarding_logo_component.dart';
import 'package:ksk_app/widgetbook/components/onboarding/dot_indicator_component.dart';
import 'package:ksk_app/widgetbook/components/onboarding/molecules/dot_indicator_row_component.dart'
    show getDotIndicatorRowComponent;
import 'package:ksk_app/widgetbook/components/onboarding/molecules/header_title_group_component.dart';
import 'package:ksk_app/widgetbook/components/onboarding/onboarding_component.dart';
import 'package:ksk_app/widgetbook/components/onboarding/onboarding_next_button_component.dart';
import 'package:ksk_app/widgetbook/components/onboarding/organisms/onboarding_header_component.dart';
import 'package:widgetbook/widgetbook.dart';
// import 'components/login/login_page_component.dart';
// import 'components/login/login_view_component.dart';
// import 'components/shared/responsive_initializer_component.dart';

/// List of all widgetbook components and folders organized by feature
final List<WidgetbookNode> directories = [
  // Onboarding components
  WidgetbookFolder(
    name: 'Onboarding',
    children: [
      // Atoms
      WidgetbookFolder(
        name: 'Atoms',
        children: [
          getOnboardingLogoComponent(),
          getHeaderTitleComponent(),
          getHeaderSubtitleComponent(),
          getDotIndicatorAtomComponent(),
        ],
      ),
      // Molecules
      WidgetbookFolder(
        name: 'Molecules',
        children: [
          getHeaderTitleGroupComponent(),
          getDotIndicatorRowComponent(),
        ],
      ),
      // Organisms
      WidgetbookFolder(
        name: 'Organisms',
        children: [
          getOnboardingHeaderComponent(),
        ],
      ),
      // Pages and other components
      getOnboardingPageComponent(),
      getDotIndicatorComponent(),
      getOnboardingNextButtonComponent(),
    ],
  ),
];
