import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:ksk_app/core/durations/app_durations.dart' show AppDurations;
import 'package:ksk_app/core/sizes/app_sizes.dart';
import 'package:ksk_app/core/styles/app_text_styles.dart' show AppTextStyles;
import 'package:ksk_app/core/styles/colors/app_colors.dart' show AppColors;

extension AppTheme on BuildContext {
  AppSizes get sizes => GetIt.I<AppSizes>();
  AppDurations get durations => GetIt.I<AppDurations>();
  AppColors get colors => GetIt.I<AppColors>();
  AppTextStyles get textStyles => GetIt.I<AppTextStyles>();
}
