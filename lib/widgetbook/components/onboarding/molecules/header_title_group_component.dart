import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart' show GetIt;
import 'package:ksk_app/core/styles/colors/app_colors.dart' show AppColors;
import 'package:ksk_app/features/onboarding/presentation/widgets/molecules/header_title_group.dart';
import 'package:widgetbook/widgetbook.dart';

/// Returns a WidgetbookComponent for HeaderTitleGroup
WidgetbookComponent getHeaderTitleGroupComponent() {
  return WidgetbookComponent(
    name: 'HeaderTitleGroup',
    useCases: [
      WidgetbookUseCase(
        name: 'Default',
        builder: (context) {
          // Create mocks for the component
          final appColors = GetIt.I<AppColors>();

          // Add knobs for customizing the title group
          final title = context.knobs.string(
            label: 'Title',
            description: 'Main title text',
            initialValue: 'EIGA',
          );

          final subtitle = context.knobs.string(
            label: 'Subtitle',
            description: 'Subtitle text',
            initialValue: 'CINEMA UI KIT.',
          );

          return Scaffold(
            backgroundColor: appColors.white,
            body: Center(
              child: Padding(
                padding: const EdgeInsets.all(24),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Use the header title group with proper styling
                    HeaderTitleGroup(
                      title: title,
                      subtitle: subtitle,
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    ],
  );
}
