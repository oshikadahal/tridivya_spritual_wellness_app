class ApiEndpoints {
  static const String baseUrl = "https://your-api-url.com/api";

  // Auth endpoints
  static const String register = "$baseUrl/auth/register";
  static const String login = "$baseUrl/auth/login";
  static const String logout = "$baseUrl/auth/logout";
  static const String getCurrentUser = "$baseUrl/auth/me";

  // Wellness program endpoints
  static const String getAllPrograms = "$baseUrl/programs";
  static const String getProgramById = "$baseUrl/programs/:id";

  // User endpoints
  static const String getUserProfile = "$baseUrl/users/:id";
  static const String updateUserProfile = "$baseUrl/users/:id";

  // Booking endpoints
  static const String createBooking = "$baseUrl/bookings";
  static const String getUserBookings = "$baseUrl/bookings/user/:id";
  static const String cancelBooking = "$baseUrl/bookings/:id";
}
