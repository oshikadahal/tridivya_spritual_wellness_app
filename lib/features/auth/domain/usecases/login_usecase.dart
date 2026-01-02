import 'package:dartz/dartz.dart';
import 'package:tridivya_spritual_wellness_app/core/error/failures.dart';
import 'package:tridivya_spritual_wellness_app/core/usecases/app_usecase.dart';
import 'package:tridivya_spritual_wellness_app/features/auth/domain/entities/auth_entity.dart';
import 'package:tridivya_spritual_wellness_app/features/auth/domain/repositories/auth_repository.dart';

class LoginUseCaseParams {
  final String email;
  final String password;

  LoginUseCaseParams({required this.email, required this.password});
}

class LoginUseCase implements UseCaseWithParams<AuthEntity, LoginUseCaseParams> {
  final IAuthRepository _authRepository;

  LoginUseCase({required IAuthRepository authRepository}) : _authRepository = authRepository;

  @override
  Future<Either<Failure, AuthEntity>> call(LoginUseCaseParams params) {
    return _authRepository.loginUser(params.email, params.password);
  }
}
