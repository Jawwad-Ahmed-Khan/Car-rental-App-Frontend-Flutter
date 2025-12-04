/// Environment configurations
/// 
/// Define different configurations for dev, staging, and prod
class AppConfig {
  final String apiBaseUrl;
  final String environment;
  final bool debugMode;

  AppConfig({
    required this.apiBaseUrl,
    required this.environment,
    required this.debugMode,
  });

  /// Development configuration
  static AppConfig get dev => AppConfig(
        apiBaseUrl: 'https://dev-api.example.com',
        environment: 'development',
        debugMode: true,
      );

  /// Staging configuration
  static AppConfig get staging => AppConfig(
        apiBaseUrl: 'https://staging-api.example.com',
        environment: 'staging',
        debugMode: true,
      );

  /// Production configuration
  static AppConfig get prod => AppConfig(
        apiBaseUrl: 'https://api.example.com',
        environment: 'production',
        debugMode: false,
      );
}
