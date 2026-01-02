import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tridivya_spritual_wellness_app/core/error/failures.dart';
import 'package:tridivya_spritual_wellness_app/features/auth/data/datasources/auth_datasource.dart';
import 'package:tridivya_spritual_wellness_app/features/auth/data/datasources/local/auth_local_datasource.dart';
import 'package:tridivya_spritual_wellness_app/features/auth/data/models/auth_hive_model.dart';
import 'package:tridivya_spritual_wellness_app/features/auth/domain/entities/auth_entity.dart';
import 'package:tridivya_spritual_wellness_app/features/auth/domain/repositories/auth_repository.dart';

final authRepositoryProvider = Provider<IAuthRepository>((ref) {
  final authDatasource = ref.read(authLocalDatasourceProvider);
  return AuthRepository(authDatasource: authDatasource);
});

class AuthRepository implements IAuthRepository {
  final IAuthDataSource _authDataSource;

  AuthRepository({required IAuthDataSource authDatasource}) : _authDataSource = authDatasource;

  @override
  Future<Either<Failure, bool>> registerUser(AuthEntity user) async {
    try {
      final existingUser = await _authDataSource.getUserByEmail(user.email);
      if (existingUser != null) {
        return const Left(LocalDatabaseFailure(message: "This email has already been used!"));
      }

      final authModel = AuthHiveModel.fromEntity(user);
      final result = await _authDataSource.registerUser(authModel);

      if (result) {
        return const Right(true);
      }

      return Left(LocalDatabaseFailure(message: "Failed to create your account, Please try again!"));
    } catch (e) {
      return Left(LocalDatabaseFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, AuthEntity>> loginUser(String email, String password) async {
    try {
      final user = await _authDataSource.loginUser(email, password);

      if (user != null) {
        final userEntity = user.toEntity();
        return Right(userEntity);
      }

      return const Left(LocalDatabaseFailure(message: "Your email or password is incorrect, please try again!"));
    } catch (e) {
      return Left(LocalDatabaseFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, bool>> logoutUser() async {
    try {
      final result = await _authDataSource.logoutUser();
      return Right(result);
    } catch (e) {
      return Left(LocalDatabaseFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, AuthEntity>> getCurrentUser() async {
    try {
      final user = await _authDataSource.getCurrentUser();
      if (user != null) return Right(user.toEntity());
      return const Left(LocalDatabaseFailure(message: "No current user"));
    } catch (e) {
      return Left(LocalDatabaseFailure(message: e.toString()));
    }
  }
}
