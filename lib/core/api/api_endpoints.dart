// class ApiEndpoints {
//   ApiEndpoints._();


//   static const String baseUrl = 'http://10.0.2.2:5050/api';
//   //static const String baseUrl = "http://localhost:5050";
  
//   // Timeout configurations
//   static const Duration connectionTimeout = Duration(seconds: 30);
//   static const Duration receiveTimeout = Duration(seconds: 30);
  
//   // Auth endpoints
//   static const String getCurrentUser = "/auth/current";
//   static const String register = '/auth/register';
//   static const String login = '/auth/login';
//   static const String logout = "/auth/logout";
//   static String userById(String id) => '/auth/$id';

// }

import 'package:flutter/foundation.dart';

class ApiEndpoints {
  // ============== BASE URL ==============
  // Use host loopback on web/desktop; use Android emulator loopback on Android.
  // Adjust `_localPort` to match your backend port.
  static const int _localPort = 5051;
  static const String _androidEmulatorHost = 'http://10.0.2.2';
  static const String _localhostHost = 'http://localhost';

  // Getter (not const) so we can switch per platform without importing dart:io on web.
  static String get baseUrl {
    // Web/desktop hit localhost; Android emulator hits 10.0.2.2
    final host = kIsWeb ? _localhostHost : _androidEmulatorHost;
    return '$host:$_localPort';
  }
  // For production (uncomment and set your deployed API URL)
  // static const String baseUrl = "https://yourapp.example.com";

  // ============== TIMEOUTS ==============
  static const Duration connectionTimeout = Duration(seconds: 10);
  static const Duration receiveTimeout = Duration(seconds: 10);
  static const Duration sendTimeout = Duration(seconds: 10);

  // ============== AUTH ENDPOINTS ==============
  static const String register = "/api/auth/register";
  static const String login = "/api/auth/login";
  static const String logout = "/api/auth/logout";
  static const String refreshToken = "/api/auth/refresh";
  static const String forgotPassword = "/api/auth/forgot-password";
  static const String resetPassword = "/api/auth/reset-password";

  // ============== USER ENDPOINTS ==============
  static const String getUserProfile = "/api/users/profile";
  static const String updateProfile = "/api/users/profile";
  static const String getUserById = "/api/users";
  static const String changePassword = "/api/users/change-password";

  // ============== WELLNESS ENDPOINTS ==============
  // Add your other endpoints here as you build features
  // static const String getWellnessPrograms = "/api/programs";
  // static const String getUserPrograms = "/api/users/programs";
  // static const String enrollProgram = "/api/users/programs/enroll";

  // ============== HELPER METHOD ==============
  /// Get full URL for an endpoint
  static String getFullUrl(String endpoint) => "$baseUrl$endpoint";
}