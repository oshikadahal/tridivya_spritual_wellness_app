import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tridivya_spritual_wellness_app/core/error/failures.dart';
import 'package:tridivya_spritual_wellness_app/features/auth/data/repositories/auth_repository.dart';
import 'package:tridivya_spritual_wellness_app/features/auth/domain/repositories/auth_repository.dart';

// Create Provider
final logoutUsecaseProvider = Provider<LogoutUseCase>((ref) {
  final authRepository = ref.read(authRepositoryProvider);
  return LogoutUseCase(authRepository: authRepository);
});

class LogoutUseCase {
  final IAuthRepository _authRepository;

  LogoutUseCase({required IAuthRepository authRepository})
      : _authRepository = authRepository;

  Future<Either<Failure, bool>> call() async {
    return await _authRepository.logout();
  }
}
