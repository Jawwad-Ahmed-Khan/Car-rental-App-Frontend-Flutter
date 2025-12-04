/// Base exception class
class AppException implements Exception {
  final String message;
  final dynamic error;

  AppException(this.message, [this.error]);

  @override
  String toString() => message;
}

/// Server exception
class ServerException extends AppException {
  ServerException([String message = 'Server error', dynamic error]) 
      : super(message, error);
}

/// Cache exception
class CacheException extends AppException {
  CacheException([String message = 'Cache error', dynamic error]) 
      : super(message, error);
}

/// Network exception
class NetworkException extends AppException {
  NetworkException([String message = 'Network error', dynamic error]) 
      : super(message, error);
}

/// Validation exception
class ValidationException extends AppException {
  ValidationException([String message = 'Validation error', dynamic error]) 
      : super(message, error);
}
