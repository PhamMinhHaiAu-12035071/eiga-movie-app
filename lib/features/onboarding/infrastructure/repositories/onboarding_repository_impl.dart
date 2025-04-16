import 'package:fpdart/fpdart.dart';
import 'package:injectable/injectable.dart';
import 'package:ksk_app/features/onboarding/domain/repositories/onboarding_repository.dart';
import 'package:ksk_app/features/storage/storage.dart';

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
  Future<Either<StorageFailure, bool>> checkIfOnboardingSeen() async {
    // Get the value from storage service
    final result = await _storageService.getBool(_onboardingSeenKey);

    // Map the result, handling null case with default value false
    return result.map((value) => value ?? false);
  }

  @override
  Future<Either<StorageFailure, bool>> markOnboardingAsSeen() {
    // No need for async/await since we're just passing through the Either
    return _storageService.setBool(_onboardingSeenKey, value: true);
  }
}
