import 'dart:io';

import 'package:hive/hive.dart';
import 'package:tridivya_spritual_wellness_app/features/auth/data/models/auth_api_model.dart';
import 'package:tridivya_spritual_wellness_app/features/auth/data/models/auth_hive_model.dart';

abstract interface class IAuthLocalDataSource {
  Future<AuthHiveModel> register(AuthHiveModel user);
  Future<AuthHiveModel?> login(String username, String password);
  Future<AuthHiveModel?> getCurrentUser();
  Future<bool> logout();
  Future<AuthHiveModel?> getUserById(String authId);
  Future<bool> updateUser(AuthHiveModel user);
  Future<bool> deleteUser(String authId);
  Future<AuthHiveModel?> getUserByEmail(String email);
}

abstract interface class IAuthRemoteDataSource {
  Future<AuthApiModel> register(AuthApiModel user);
  Future<AuthApiModel?> login(String username, String password);
  Future<AuthApiModel?> getUserById(String authId);
  Future<String> updateProfileImage(File image);
}

class AuthLocalDataSource implements IAuthLocalDataSource {
  @override
  Future<AuthHiveModel> register(AuthHiveModel user) async {
    final box = await Hive.openBox<AuthHiveModel>('auth_users');
    await box.put(user.authId, user);
    return user;
  }

  @override
  Future<AuthHiveModel?> login(String username, String password) async {
    final box = await Hive.openBox<AuthHiveModel>('auth_users');
    for (final user in box.values) {
      if (user.username == username && user.password == password) {
        return user;
      }
    }
    return null;
  }

  @override
  Future<AuthHiveModel?> getCurrentUser() async {
    final box = await Hive.openBox<AuthHiveModel>('auth_users');
    return box.get('current_user');
  }

  @override
  Future<bool> logout() async {
    final box = await Hive.openBox<AuthHiveModel>('auth_users');
    await box.delete('current_user');
    return true;
  }

  @override
  Future<AuthHiveModel?> getUserById(String authId) async {
    final box = await Hive.openBox<AuthHiveModel>('auth_users');
    return box.get(authId);
  }

  @override
  Future<bool> updateUser(AuthHiveModel user) async {
    final box = await Hive.openBox<AuthHiveModel>('auth_users');
    await box.put(user.authId, user);
    return true;
  }

  @override
  Future<bool> deleteUser(String authId) async {
    final box = await Hive.openBox<AuthHiveModel>('auth_users');
    await box.delete(authId);
    return true;
  }

  @override
  Future<AuthHiveModel?> getUserByEmail(String email) async {
    final box = await Hive.openBox<AuthHiveModel>('auth_users');
    try {
      for (final user in box.values) {
        if (user.email.toLowerCase() == email.toLowerCase()) {
          return user;
        }
      }
      return null;
    } finally {
      await box.close();
    }
  }
}