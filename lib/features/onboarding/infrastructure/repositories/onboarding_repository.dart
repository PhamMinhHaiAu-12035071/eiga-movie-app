import 'package:injectable/injectable.dart';
import 'package:ksk_app/features/onboarding/domain/repositories/i_onboarding_repository.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// Key to store onboarding state in SharedPreferences
const String _onboardingSeenKey = 'onboarding_seen';

/// Implementation of [IOnboardingRepository] using SharedPreferences
@LazySingleton(as: IOnboardingRepository)
class OnboardingRepository implements IOnboardingRepository {
  /// Constructor with dependency injection
  OnboardingRepository(this._prefs);

  /// SharedPreferences instance for data storage
  final SharedPreferences _prefs;

  @override
  Future<bool> checkIfOnboardingSeen() async {
    return _prefs.getBool(_onboardingSeenKey) ?? false;
  }

  @override
  Future<void> markOnboardingAsSeen() async {
    await _prefs.setBool(_onboardingSeenKey, true);
  }
}
