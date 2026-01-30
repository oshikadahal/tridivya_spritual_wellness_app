import 'dart:io';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tridivya_spritual_wellness_app/features/auth/domain/usecases/register_usecase.dart';
import 'package:tridivya_spritual_wellness_app/features/auth/domain/usecases/login_usecase.dart';
import 'package:tridivya_spritual_wellness_app/features/auth/domain/usecases/update_profile_usecase.dart';
import 'package:tridivya_spritual_wellness_app/features/auth/presentation/state/auth_state.dart';
import 'package:tridivya_spritual_wellness_app/features/auth/data/repositories/auth_repository.dart';
import 'package:tridivya_spritual_wellness_app/features/auth/domain/repositories/auth_repository.dart' as domain_repo;

final authViewModelProvider = StateNotifierProvider<AuthViewModel, AuthState>((ref) {
  final repo = ref.read(authRepositoryProvider);
  return AuthViewModel(repo);
});

class AuthViewModel extends StateNotifier<AuthState> {
  final domain_repo.IAuthRepository _authRepository;

  AuthViewModel(this._authRepository) : super(const AuthState());

  Future<void> register({
    required String fullName,
    required String email,
    required String username,
    required String password,
    String profilePicture = '',
  }) async {
    state = state.copyWith(status: AuthStatus.loading, errorMessage: null);

    final result = await RegisterUseCase(authRepository: _authRepository)(
      RegisterParams(
        fullName: fullName,
        email: email,
        username: username,
        password: password,
      ),
    );

    result.fold(
      (failure) => state = state.copyWith(
        status: AuthStatus.error,
        errorMessage: failure.message,
      ),
      (success) => state = state.copyWith(
        status: AuthStatus.registered,
        errorMessage: null,
      ),
    );
  }

  Future<void> login({
    required String email,
    required String password,
  }) async {
    state = state.copyWith(status: AuthStatus.loading, errorMessage: null);

    final result = await LoginUseCase(authRepository: _authRepository)(
      LoginParams(email: email, password: password),
    );

    result.fold(
      (failure) => state = state.copyWith(
        status: AuthStatus.error,
        errorMessage: failure.message,
      ),
      (user) => state = state.copyWith(
        status: AuthStatus.authenticated,
        errorMessage: null,
      ),
    );
  }

  Future<String?> updateProfileImage(File image) async {
    state = state.copyWith(status: AuthStatus.loading, errorMessage: null);

    final result = await UpdateProfileUseCase(authRepository: _authRepository)(
      UpdateProfileParams(imagePath: image.path),
    );

    return result.fold(
      (failure) {
        state = state.copyWith(
          status: AuthStatus.error,
          errorMessage: failure.message,
        );
        return null;
      },
      (imagePath) {
        state = state.copyWith(status: AuthStatus.initial, errorMessage: null);
        return imagePath.isNotEmpty ? imagePath : null;
      },
    );
  }

  void resetState() {
    state = const AuthState();
  }
}
