import 'package:fpdart/fpdart.dart';
import 'package:ksk_app/features/storage/domain/errors/storage_failure.dart';
import 'package:ksk_app/features/storage/storage.dart';

/// Interface defining operations related to Onboarding
abstract class OnboardingRepository {
  /// Checks if the user has seen the onboarding
  ///
  /// Returns Either with Right(true) if seen, Right(false) if not seen,
  /// or Left(StorageFailure) on failure
  Future<Either<StorageFailure, bool>> checkIfOnboardingSeen();

  /// Marks that the user has seen the onboarding
  ///
  /// Writes true value to local storage
  /// Returns Either with Right(true) on success or Left(StorageFailure) failure
  Future<Either<StorageFailure, bool>> markOnboardingAsSeen();
}
