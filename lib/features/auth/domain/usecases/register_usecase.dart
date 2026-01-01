import 'package:dartz/dartz.dart';
import 'package:tridivya_spritual_wellness_app/core/error/failures.dart';
import 'package:tridivya_spritual_wellness_app/core/usecases/app_usecase.dart';
import 'package:tridivya_spritual_wellness_app/features/auth/domain/entities/auth_entity.dart';
import 'package:tridivya_spritual_wellness_app/features/auth/domain/repositories/auth_repository.dart';

class RegisterUseCaseParams {
  final String fullName;
  final String email;
  final String username;
  final String password;

  RegisterUseCaseParams({required this.fullName, required this.email, required this.username, required this.password});
}

class RegisterUseCase implements UseCaseWithParams<bool, RegisterUseCaseParams> {
  final IAuthRepository _authRepository;

  RegisterUseCase({required IAuthRepository authRepository}) : _authRepository = authRepository;

  @override
  Future<Either<Failure, bool>> call(RegisterUseCaseParams params) {
    final entity = AuthEntity(fullName: params.fullName, email: params.email, username: params.username, password: params.password);
    return _authRepository.registerUser(entity);
  }
}
