import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tridivya_spritual_wellness_app/core/error/failures.dart';
import 'package:tridivya_spritual_wellness_app/features/auth/data/datasources/auth_datasource.dart';
import 'package:tridivya_spritual_wellness_app/features/auth/data/datasources/local/auth_local_datasource.dart';
import 'package:tridivya_spritual_wellness_app/features/auth/data/datasources/remote/auth_remote_datasource.dart';
import 'package:tridivya_spritual_wellness_app/features/auth/data/models/auth_hive_model.dart';
import 'package:tridivya_spritual_wellness_app/features/auth/domain/entities/auth_entity.dart';
import 'package:tridivya_spritual_wellness_app/features/auth/domain/repositories/auth_repository.dart';

final authRepositoryProvider = Provider<IAuthRepository>((ref) {
  final remoteDatasource = ref.read(authRemoteDatasourceProvider);
  final localDatasource = ref.read(authLocalDatasourceProvider);
  return AuthRepository(
    remoteDatasource: remoteDatasource,
    localDatasource: localDatasource,
  );
});

class AuthRepository implements IAuthRepository {
  final IAuthDataSource _remoteDatasource;
  final IAuthDataSource _localDatasource;

  AuthRepository({
    required IAuthDataSource remoteDatasource,
    required IAuthDataSource localDatasource,
  })  : _remoteDatasource = remoteDatasource,
        _localDatasource = localDatasource;

  @override
  Future<Either<Failure, bool>> registerUser(AuthEntity user) async {
    try {
      final authModel = AuthHiveModel.fromEntity(user);
      
      // Try to register via API
      final result = await _remoteDatasource.registerUser(authModel);
      
      if (result) {
        // Save to local database
        await _localDatasource.registerUser(authModel);
        return const Right(true);
      }

      return const Left(ApiFailure(message: "Failed to create your account, Please try again!"));
    } catch (e) {
      return Left(ApiFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, AuthEntity>> loginUser(String email, String password) async {
    try {
      // Try to login via API
      final user = await _remoteDatasource.loginUser(email, password);

      if (user != null) {
        // Save to local database
        await _localDatasource.registerUser(user);
        final userEntity = user.toEntity();
        return Right(userEntity);
      }

      return const Left(ApiFailure(message: "Your email or password is incorrect, please try again!"));
    } catch (e) {
      return Left(ApiFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, bool>> logoutUser() async {
    try {
      await _remoteDatasource.logoutUser();
      await _localDatasource.logoutUser();
      return const Right(true);
    } catch (e) {
      return Left(ApiFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, AuthEntity>> getCurrentUser() async {
    try {
      final user = await _remoteDatasource.getCurrentUser();
      if (user != null) return Right(user.toEntity());
      return const Left(ApiFailure(message: "No current user"));
    } catch (e) {
      return Left(ApiFailure(message: e.toString()));
    }
  }
}
