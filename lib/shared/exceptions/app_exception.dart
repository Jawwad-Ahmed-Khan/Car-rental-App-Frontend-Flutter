/// App-wide custom exceptions
class AppException implements Exception {
  final String message;
  final String? code;
  final dynamic details;

  AppException({
    required this.message,
    this.code,
    this.details,
  });

  @override
  String toString() {
    if (code != null) {
      return 'AppException [$code]: $message';
    }
    return 'AppException: $message';
  }
}

/// Unauthorized exception (401)
class UnauthorizedException extends AppException {
  UnauthorizedException({String message = 'Unauthorized access'})
      : super(message: message, code: '401');
}

/// Not found exception (404)
class NotFoundException extends AppException {
  NotFoundException({String message = 'Resource not found'})
      : super(message: message, code: '404');
}

/// Bad request exception (400)
class BadRequestException extends AppException {
  BadRequestException({String message = 'Bad request', dynamic details})
      : super(message: message, code: '400', details: details);
}

/// Internal server error (500)
class InternalServerException extends AppException {
  InternalServerException({String message = 'Internal server error'})
      : super(message: message, code: '500');
}
