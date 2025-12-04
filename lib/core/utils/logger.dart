import 'package:flutter/foundation.dart';

/// App-wide logger utility
class Logger {
  static void log(String message, {String tag = 'APP'}) {
    if (kDebugMode) {
      print('[$tag] $message');
    }
  }

  static void error(String message, {String tag = 'ERROR', dynamic error, StackTrace? stackTrace}) {
    if (kDebugMode) {
      print('[$tag] $message');
      if (error != null) print('Error: $error');
      if (stackTrace != null) print('StackTrace: $stackTrace');
    }
  }

  static void debug(String message, {String tag = 'DEBUG'}) {
    if (kDebugMode) {
      print('[$tag] $message');
    }
  }
}
