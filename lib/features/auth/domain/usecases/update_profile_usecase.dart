import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tridivya_spritual_wellness_app/core/error/failures.dart';
import 'package:tridivya_spritual_wellness_app/features/auth/data/repositories/auth_repository.dart';
import 'package:tridivya_spritual_wellness_app/features/auth/domain/repositories/auth_repository.dart';

class UpdateProfileParams extends Equatable {
  final String imagePath;

  const UpdateProfileParams({required this.imagePath});

  @override
  List<Object?> get props => [imagePath];
}

final updateProfileUsecaseProvider = Provider<UpdateProfileUseCase>((ref) {
  final authRepository = ref.read(authRepositoryProvider);
  return UpdateProfileUseCase(authRepository: authRepository);
});

class UpdateProfileUseCase {
  final IAuthRepository _authRepository;

  UpdateProfileUseCase({required IAuthRepository authRepository})
      : _authRepository = authRepository;

  Future<Either<Failure, String>> call(UpdateProfileParams params) async {
    return _authRepository.updateProfileImage(params.imagePath);
  }
}
