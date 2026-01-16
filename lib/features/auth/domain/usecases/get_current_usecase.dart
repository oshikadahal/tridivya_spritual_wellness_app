import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tridivya_spritual_wellness_app/core/error/failures.dart';
import 'package:tridivya_spritual_wellness_app/features/auth/data/repositories/auth_repository.dart';
import 'package:tridivya_spritual_wellness_app/features/auth/domain/entities/auth_entity.dart';
import 'package:tridivya_spritual_wellness_app/features/auth/domain/repositories/auth_repository.dart';


// Create Provider
final getCurrentUserUsecaseProvider = Provider<GetCurrentUserUseCase>((ref) {
  final authRepository = ref.read(authRepositoryProvider);
  return GetCurrentUserUseCase(authRepository: authRepository);
});

class GetCurrentUserUseCase {
  final IAuthRepository _authRepository;

  GetCurrentUserUseCase({required IAuthRepository authRepository})
      : _authRepository = authRepository;

  Future<Either<Failure, AuthEntity>> call() async {
    return await _authRepository.getCurrentUser();
  }
}