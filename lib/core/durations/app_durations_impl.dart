import 'package:injectable/injectable.dart';
import 'package:ksk_app/core/durations/app_durations.dart';

/// Implementation of application durations
/// that can be injected and mocked for testing
@LazySingleton(as: AppDurations)
class AppDurationsImpl implements AppDurations {
  const AppDurationsImpl();

  @override
  Duration get veryShort => const Duration(milliseconds: 100);

  @override
  Duration get short => const Duration(milliseconds: 200);

  @override
  Duration get medium => const Duration(milliseconds: 300);

  @override
  Duration get long => const Duration(milliseconds: 500);

  @override
  Duration get extraLong => const Duration(milliseconds: 800);

  @override
  Duration get oneSecond => const Duration(seconds: 1);
}
