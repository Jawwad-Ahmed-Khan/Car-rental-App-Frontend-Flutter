import 'package:flutter/material.dart';
import '../features/auth/pages/phone_login_page.dart';
import '../features/auth/pages/otp_verification_page.dart';
import '../features/home/presentation/pages/home_page.dart';
import '../features/main/presentation/pages/main_page.dart';
import '../features/notification/presentation/pages/notification_page.dart';
import '../features/onboarding/onboarding_page.dart';
import '../features/auth/pages/login_page.dart';

/// Application routing configuration
/// 
/// TODO: Implement with go_router or auto_route package
class AppRouter {
  // Route names
  static const String home = '/';
  static const String login = '/login';
  static const String register = '/register';
  static const String phoneLogin = '/phone_login';
  static const String otpVerification = '/otp_verification';
  static const String notifications = '/notifications';

  static const String onboarding = '/onboarding';

  // Generate routes
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case home:
        return MaterialPageRoute(
          builder: (_) => const MainPage(),
        );
      case onboarding:
        return MaterialPageRoute(
          builder: (_) => const OnboardingPage(),
        );
      case login:
        return MaterialPageRoute(
          builder: (_) => const LoginPage(),
        );
      case register:
        return MaterialPageRoute(
          builder: (_) => const Placeholder(), // Replace with RegisterPage
        );
      case phoneLogin:
        return MaterialPageRoute(
          builder: (_) => const PhoneLoginPage(),
        );
      case otpVerification:
        return MaterialPageRoute(
          builder: (_) => const OtpVerificationPage(),
        );
      case notifications:
        return MaterialPageRoute(
          builder: (_) => const NotificationPage(),
        );
      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            body: Center(
              child: Text('No route defined for ${settings.name}'),
            ),
          ),
        );
    }
  }
}

