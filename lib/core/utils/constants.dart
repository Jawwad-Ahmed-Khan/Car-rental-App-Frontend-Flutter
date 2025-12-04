/// App-wide constants
class AppConstants {
  // API constants
  static const String baseUrl = 'https://api.example.com';
  static const String apiVersion = 'v1';
  
  // Cache keys
  static const String userTokenKey = 'user_token';
  static const String userDataKey = 'user_data';
  
  // Timeouts
  static const int connectionTimeout = 30000;
  static const int receiveTimeout = 30000;
  
  // Pagination
  static const int defaultPageSize = 20;
}
