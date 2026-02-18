import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tridivya_spritual_wellness_app/core/api/api_client.dart';
import 'package:tridivya_spritual_wellness_app/core/api/api_endpoints.dart';
import 'package:tridivya_spritual_wellness_app/core/services/storage/user_session_service.dart';
import 'package:tridivya_spritual_wellness_app/features/auth/data/datasources/auth_datasource.dart';
import 'package:tridivya_spritual_wellness_app/features/auth/data/models/auth_api_model.dart';


//Create Provider
final authRemoteDatasourceProvider = Provider<IAuthRemoteDataSource>((ref) {
  return AuthRemoteDatasource(
    apiClient: ref.read(apiClientProvider),
    userSessionService: ref.read(userSessionServiceProvider),
  );
});
  

class AuthRemoteDatasource implements IAuthRemoteDataSource {
  final ApiClient _apiClient;
  final UserSessionService _userSessionService;

  AuthRemoteDatasource({
    required ApiClient apiClient,
    required UserSessionService userSessionService,
  })  : _apiClient = apiClient,
        _userSessionService = userSessionService;


  @override
  Future<AuthApiModel?> login(String username, String password) async {
    final response = await _apiClient.post(
      ApiEndpoints.login,
      data: {
        'email': username,
        'password': password,
      },
    );

    if (response.data['success'] == true) {
      final data = response.data['data'] as Map<String, dynamic>;
      final user = AuthApiModel.fromJson(data);
      // Save token to session
      await _userSessionService.saveUserSession(
        userId: user.id!,
        email: user.email,
        fullName: user.fullName,
        username: user.username,
      );
      return user;
    }
    return null;
  }

  @override
  Future<AuthApiModel> register(AuthApiModel user) async {
    final response = await _apiClient.post(
      ApiEndpoints.register,
      data: user.toJson(),
    );

    if (response.data['success'] == true) {
      final data = response.data['data'] as Map<String, dynamic>;
      final registeredUser = AuthApiModel.fromJson(data);
      return registeredUser;
    }
    return user;
  }

  @override
  Future<AuthApiModel?> getUserById(String authId) {
    // TODO: implement getUserById
    throw UnimplementedError();
  }

  @override
  Future<String> updateProfileImage(File image) async {
    try {
      final fileName = image.path.split(Platform.isWindows ? '\\' : '/').last;

      final formData = FormData.fromMap({
        'profilePicture': await MultipartFile.fromFile(
          image.path,
          filename: fileName,
        ),
      });

      final response = await _apiClient.put(
        ApiEndpoints.updateProfile,
        data: formData,
        options: Options(contentType: 'multipart/form-data'),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        final responseData = response.data;
        
        // Handle different response structures
        if (responseData is Map<String, dynamic>) {
          if (responseData['success'] == true && responseData['data'] != null) {
            final data = responseData['data'] as Map<String, dynamic>;
            final profilePath = (data['profilePicture'] ?? data['image'] ?? data['path'] ?? '') as String;
            if (profilePath.isNotEmpty) {
              return profilePath;
            }
          }
          // If we got here but success is true, return the image path as fallback
          if (responseData['success'] == true) {
            return image.path;
          }
        }
      }

      throw Exception('Failed to update profile image: Invalid response');
    } catch (e) {
      throw Exception('Error uploading profile image: ${e.toString()}');
    }
  }
  

}