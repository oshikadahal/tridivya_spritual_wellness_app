import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tridivya_spritual_wellness_app/core/error/failures.dart';
import 'package:tridivya_spritual_wellness_app/features/auth/data/repositories/auth_repository.dart';
import 'package:tridivya_spritual_wellness_app/features/auth/domain/entities/auth_entity.dart';
import 'package:tridivya_spritual_wellness_app/features/auth/domain/repositories/auth_repository.dart';


class RegisterParams extends Equatable {
  final String fullName;
  final String email;
  final String username;
  final String password;
  final String? profilePicture;

  const RegisterParams({
    required this.fullName,
    required this.email,
    required this.username,
    required this.password,
    this.profilePicture,
  });

  @override
  List<Object?> get props => [
        fullName,
        email,
        username,
        password,
        profilePicture,
      ];
}

// Create Provider
final registerUsecaseProvider = Provider<RegisterUseCase>((ref) {
  final authRepository = ref.read(authRepositoryProvider);
  return RegisterUseCase(authRepository: authRepository);
});

class RegisterUseCase {
  final IAuthRepository _authRepository;

  RegisterUseCase({required IAuthRepository authRepository})
      : _authRepository = authRepository;

  Future<Either<Failure, bool>> call(RegisterParams params) async {
    final authEntity = AuthEntity(
      fullName: params.fullName,
      email: params.email,
      username: params.username,
      password: params.password,
      
    );

    return await _authRepository.register(authEntity);
  }
}