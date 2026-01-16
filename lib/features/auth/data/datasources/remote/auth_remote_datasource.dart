import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tridivya_spritual_wellness_app/core/api/api_client.dart';
import 'package:tridivya_spritual_wellness_app/core/api/api_endpoints.dart';
import 'package:tridivya_spritual_wellness_app/features/auth/data/datasources/auth_datasource.dart';
import 'package:tridivya_spritual_wellness_app/features/auth/data/models/auth_api_model.dart';
import 'package:tridivya_spritual_wellness_app/features/auth/data/models/auth_hive_model.dart';

final authRemoteDatasourceProvider = Provider<IAuthDataSource>((ref) {
  final apiClient = ref.read(apiClientProvider);
  return AuthRemoteDatasource(apiClient: apiClient);
});

class AuthRemoteDatasource implements IAuthDataSource {
  final ApiClient _apiClient;

  AuthRemoteDatasource({required ApiClient apiClient}) : _apiClient = apiClient;

  @override
  Future<bool> registerUser(AuthHiveModel user) async {
    try {
      final response = await _apiClient.post(
        ApiEndpoints.register,
        data: {
          'name': user.fullName,
          'email': user.email,
          'username': user.username,
          'password': user.password,
        },
      );

      if (response.statusCode == 201 || response.statusCode == 200) {
        return true;
      }
      throw Exception('Failed to register user');
    } catch (e) {
      throw Exception('Registration error: ${e.toString()}');
    }
  }

  @override
  Future<AuthHiveModel?> loginUser(String email, String password) async {
    try {
      final response = await _apiClient.post(
        ApiEndpoints.login,
        data: {
          'email': email,
          'password': password,
        },
      );

      if (response.statusCode == 200) {
        final data = response.data['data'] ?? response.data;
        return AuthHiveModel.fromJson(data);
      }
      return null;
    } catch (e) {
      throw Exception('Login error: ${e.toString()}');
    }
  }

  @override
  Future<AuthHiveModel?> getCurrentUser() async {
    try {
      final response = await _apiClient.get(ApiEndpoints.getCurrentUser);

      if (response.statusCode == 200) {
        final data = response.data['data'] ?? response.data;
        return AuthHiveModel.fromJson(data);
      }
      return null;
    } catch (e) {
      throw Exception('Get current user error: ${e.toString()}');
    }
  }

  @override
  Future<bool> logoutUser() async {
    try {
      final response = await _apiClient.post(ApiEndpoints.logout);
      return response.statusCode == 200;
    } catch (e) {
      throw Exception('Logout error: ${e.toString()}');
    }
  }

  @override
  Future<bool> doesEmailExist(String email) async {
    try {
      final response = await _apiClient.get(
        ApiEndpoints.getCurrentUser,
        queryParameters: {'email': email},
      );
      return response.statusCode == 200;
    } catch (e) {
      return false;
    }
  }

  @override
  Future<AuthHiveModel?> getUserById(String authId) async {
    try {
      final response = await _apiClient.get('${ApiEndpoints.getCurrentUser}/$authId');
      if (response.statusCode == 200) {
        final data = response.data['data'] ?? response.data;
        return AuthHiveModel.fromJson(data);
      }
      return null;
    } catch (e) {
      throw Exception('Get user error: ${e.toString()}');
    }
  }

  @override
  Future<AuthHiveModel?> getUserByEmail(String email) async {
    try {
      final response = await _apiClient.get(
        ApiEndpoints.getCurrentUser,
        queryParameters: {'email': email},
      );
      if (response.statusCode == 200) {
        final data = response.data['data'] ?? response.data;
        return AuthHiveModel.fromJson(data);
      }
      return null;
    } catch (e) {
      return null;
    }
  }

  @override
  Future<bool> updateUser(AuthHiveModel user) async {
    try {
      final response = await _apiClient.put(
        '${ApiEndpoints.getCurrentUser}/${user.id}',
        data: {
          'name': user.fullName,
          'email': user.email,
          'username': user.username,
        },
      );
      return response.statusCode == 200;
    } catch (e) {
      throw Exception('Update user error: ${e.toString()}');
    }
  }

  @override
  Future<bool> deleteUser(String authId) async {
    try {
      final response = await _apiClient.delete(
        '${ApiEndpoints.getCurrentUser}/$authId',
      );
      return response.statusCode == 200;
    } catch (e) {
      throw Exception('Delete user error: ${e.toString()}');
    }
  }
}


