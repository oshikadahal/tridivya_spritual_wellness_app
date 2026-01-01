import 'package:dartz/dartz.dart';
import 'package:tridivya_spritual_wellness_app/core/error/failures.dart';
import 'package:tridivya_spritual_wellness_app/features/auth/domain/entities/auth_entity.dart';

abstract interface class IAuthRepository {
  Future<Either<Failure, bool>> registerUser(AuthEntity user);
  Future<Either<Failure, AuthEntity>> loginUser(String email, String password);
  Future<Either<Failure, bool>> logoutUser();
  Future<Either<Failure, AuthEntity>> getCurrentUser();
}
