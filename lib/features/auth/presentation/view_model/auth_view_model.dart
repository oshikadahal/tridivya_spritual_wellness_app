import 'dart:io';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tridivya_spritual_wellness_app/features/auth/domain/usecases/register_usecase.dart';
import 'package:tridivya_spritual_wellness_app/features/auth/domain/usecases/login_usecase.dart';
import 'package:tridivya_spritual_wellness_app/features/auth/domain/usecases/get_current_usecase.dart';
import 'package:tridivya_spritual_wellness_app/features/auth/domain/usecases/update_profile_usecase.dart';
import 'package:tridivya_spritual_wellness_app/features/auth/domain/usecases/logout_usecase.dart';
import 'package:tridivya_spritual_wellness_app/features/auth/presentation/state/auth_state.dart';
import 'package:tridivya_spritual_wellness_app/features/auth/data/repositories/auth_repository.dart';
import 'package:tridivya_spritual_wellness_app/features/auth/domain/repositories/auth_repository.dart' as domain_repo;
import 'package:tridivya_spritual_wellness_app/core/services/storage/user_session_service.dart';

final authViewModelProvider = StateNotifierProvider<AuthViewModel, AuthState>((ref) {
  final repo = ref.read(authRepositoryProvider);
  final sessionService = ref.read(userSessionServiceProvider);
  return AuthViewModel(repo, sessionService);
});

class AuthViewModel extends StateNotifier<AuthState> {
  final domain_repo.IAuthRepository _authRepository;
  final UserSessionService _sessionService;

  AuthViewModel(this._authRepository, this._sessionService) : super(const AuthState());

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

    if (result.isRight()) {
      // Login successful
      try {
        // After successful login, fetch current user to get profile picture
        final currentUserResult = await GetCurrentUserUseCase(authRepository: _authRepository)();
        
        currentUserResult.fold(
          (failure) {
            // Login succeeded but couldn't fetch current user, that's okflutter 
            state = state.copyWith(
              status: AuthStatus.authenticated,
              errorMessage: null,
            );
          },
          (currentUser) {
            // Update session with profile picture from current user
            if (currentUser.profilePicture != null && currentUser.profilePicture!.isNotEmpty) {
              _sessionService.updateProfilePicture(currentUser.profilePicture);
            }
            state = state.copyWith(
              status: AuthStatus.authenticated,
              errorMessage: null,
            );
          },
        );
      } catch (e) {
        // If fetching current user fails, still consider login successful
        state = state.copyWith(
          status: AuthStatus.authenticated,
          errorMessage: null,
        );
      }
    } else {
      // Login failed
      result.fold(
        (failure) => state = state.copyWith(
          status: AuthStatus.error,
          errorMessage: failure.message,
        ),
        (user) {},
      );
    }
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

  Future<void> logout() async {
    state = state.copyWith(status: AuthStatus.loading, errorMessage: null);
    
    final result = await LogoutUseCase(authRepository: _authRepository)();
    
    result.fold(
      (failure) => state = state.copyWith(
        status: AuthStatus.error,
        errorMessage: failure.message,
      ),
      (success) {
        state = const AuthState();
      },
    );
  }
}
