import 'package:injectable/injectable.dart';
import 'package:ksk_app/core/services/local_storage_service.dart';
import 'package:ksk_app/features/onboarding/domain/repositories/onboarding_repository.dart';

/// Key to store onboarding state in local storage
const String _onboardingSeenKey = 'onboarding_seen';

/// Implementation of [OnboardingRepository] using [LocalStorageService]
@LazySingleton(as: OnboardingRepository)
class OnboardingRepositoryImpl implements OnboardingRepository {
  /// Constructor with dependency injection
  OnboardingRepositoryImpl(this._storageService);

  /// Local storage service for data persistence
  final LocalStorageService _storageService;

  @override
  Future<bool> checkIfOnboardingSeen() async {
    return _storageService.getBool(_onboardingSeenKey);
  }

  @override
  Future<void> markOnboardingAsSeen() async {
    await _storageService.setBool(_onboardingSeenKey, value: true);
  }
}
