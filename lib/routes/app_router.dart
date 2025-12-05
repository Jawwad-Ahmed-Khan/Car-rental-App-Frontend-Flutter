import 'package:flutter/material.dart';
import '../features/auth/pages/phone_login_page.dart';
import '../features/auth/pages/otp_verification_page.dart';
import '../features/booking_details/presentation/pages/booking_details_page.dart';
import '../features/car_detail/presentation/pages/car_detail_page.dart';
import '../features/confirmation/presentation/pages/confirmation_page.dart';
import '../features/main/presentation/pages/main_page.dart';
import '../features/notification/presentation/pages/notification_page.dart';
import '../features/onboarding/onboarding_page.dart';
import '../features/auth/pages/login_page.dart';
import '../features/payment_states/presentation/pages/payment_states_page.dart';
import '../features/reviews/presentation/pages/reviews_page.dart';
import '../features/payment_methods/presentation/pages/payment_methods_page.dart';
import '../features/profile/presentation/pages/profile_page.dart';
import '../features/profile/presentation/pages/favorites_page.dart';
import '../features/splash/presentation/pages/splash_screen.dart';
import '../features/search/presentation/pages/search_page.dart';
import '../features/booking/domain/entities/booking.dart';

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
  static const String carDetails = '/car_details';
  static const String reviews = '/reviews';
  static const String bookingDetails = '/booking_details';
  static const String paymentMethods = '/payment_methods';
  static const String confirmation = '/confirmation';
  static const String paymentStates = '/payment_states';
  static const String profile = '/profile';
  static const String favorites = '/favorites';
  static const String splash = '/splash';
  static const String search = '/search';

  static const String onboarding = '/onboarding';

  // Generate routes
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case splash:
        return MaterialPageRoute(builder: (_) => const SplashScreen());
      case search:
        return MaterialPageRoute(builder: (_) => const SearchPage());
      case home:
        return MaterialPageRoute(builder: (_) => const MainPage());
      case onboarding:
        return MaterialPageRoute(builder: (_) => const OnboardingPage());
      case login:
        return MaterialPageRoute(builder: (_) => const LoginPage());
      case register:
        return MaterialPageRoute(
          builder: (_) => const Placeholder(), // Replace with RegisterPage
        );
      case phoneLogin:
        return MaterialPageRoute(builder: (_) => const PhoneLoginPage());
      case otpVerification:
        return MaterialPageRoute(builder: (_) => const OtpVerificationPage());
      case notifications:
        return MaterialPageRoute(builder: (_) => const NotificationPage());
      case carDetails:
        final args = settings.arguments as Map<String, dynamic>?;
        final carId = args?['carId']?.toString() ?? '1';
        return MaterialPageRoute(builder: (_) => CarDetailPage(carId: carId));
      case reviews:
        final args = settings.arguments as Map<String, dynamic>?;
        final carId = args?['carId'] as String? ?? '1';
        final rating = args?['rating'] as double? ?? 5.0;
        final reviewCount = args?['reviewCount'] as int? ?? 0;
        return MaterialPageRoute(
          builder: (_) => ReviewsPage(
            carId: carId,
            rating: rating,
            reviewCount: reviewCount,
          ),
        );
      case bookingDetails:
        final args = settings.arguments as Map<String, dynamic>?;
        final carId = args?['carId'] as String? ?? '1';
        final price = args?['price'] as double? ?? 0.0;
        final carName = args?['carName'] as String? ?? '';
        final carImageUrl = args?['carImageUrl'] as String? ?? '';
        return MaterialPageRoute(
          builder: (_) => BookingDetailsPage(
            carId: carId,
            price: price,
            carName: carName,
            carImageUrl: carImageUrl,
          ),
        );
      case paymentMethods:
        final args = settings.arguments as Map<String, dynamic>?;
        final totalAmount = args?['totalAmount'] as double? ?? 0.0;
        final booking = args?['booking'] as Booking?;
        // Pass through booking and car details for confirmation page
        return MaterialPageRoute(
          builder: (_) => PaymentMethodsPage(
            booking: booking,
            totalAmount: totalAmount,
            userName: args?['userName'] as String? ?? '',
            pickupDate: args?['pickupDate'] as DateTime? ?? DateTime.now(),
            returnDate:
                args?['returnDate'] as DateTime? ??
                DateTime.now().add(const Duration(days: 3)),
            pickupLocation: args?['pickupLocation'] as String? ?? '',
            returnLocation: args?['returnLocation'] as String? ?? '',
            carId: args?['carId'] as String? ?? '',
            carName: args?['carName'] as String? ?? '',
            carDescription: args?['carDescription'] as String? ?? '',
            carImageUrl: args?['carImageUrl'] as String? ?? '',
            carRating: args?['carRating'] as double? ?? 5.0,
            reviewCount: args?['reviewCount'] as int? ?? 100,
            pricePerDay: args?['pricePerDay'] as double? ?? 0.0,
          ),
        );
      case confirmation:
        final args = settings.arguments as Map<String, dynamic>?;
        return MaterialPageRoute(
          builder: (_) => ConfirmationPage(
            userName: args?['userName'] as String? ?? '',
            pickupDate: args?['pickupDate'] as DateTime? ?? DateTime.now(),
            returnDate:
                args?['returnDate'] as DateTime? ??
                DateTime.now().add(const Duration(days: 3)),
            pickupLocation: args?['pickupLocation'] as String? ?? '',
            returnLocation: args?['returnLocation'] as String? ?? '',
            carId: args?['carId'] as String? ?? '',
            carName: args?['carName'] as String? ?? '',
            carDescription: args?['carDescription'] as String? ?? '',
            carImageUrl: args?['carImageUrl'] as String? ?? '',
            carRating: args?['carRating'] as double? ?? 5.0,
            reviewCount: args?['reviewCount'] as int? ?? 100,
            amount: args?['amount'] as double? ?? 0.0,
            serviceFee: args?['serviceFee'] as double? ?? 15.0,
            paymentMethod: args?['paymentMethod'] as String? ?? 'Mastercard',
            paymentMethodIcon: args?['paymentMethodIcon'] as String? ?? '',
            pricePerDay: args?['pricePerDay'] as double? ?? 0.0,
          ),
        );
      case paymentStates:
        final args = settings.arguments as Map<String, dynamic>?;
        return MaterialPageRoute(
          builder: (_) => PaymentStatesPage(
            carName: args?['carName'] as String? ?? '',
            pickupDate: args?['pickupDate'] as DateTime? ?? DateTime.now(),
            returnDate:
                args?['returnDate'] as DateTime? ??
                DateTime.now().add(const Duration(days: 3)),
            userName: args?['userName'] as String? ?? '',
            transactionId: args?['transactionId'] as String? ?? '',
            paymentMethod: args?['paymentMethod'] as String? ?? 'Mastercard',
            amount: args?['amount'] as double? ?? 0.0,
            serviceFee: args?['serviceFee'] as double? ?? 15.0,
            totalAmount: args?['totalAmount'] as double? ?? 0.0,
            pricePerDay: args?['pricePerDay'] as double? ?? 0.0,
          ),
        );
      case profile:
        return MaterialPageRoute(builder: (_) => const ProfilePage());
      case favorites:
        return MaterialPageRoute(builder: (_) => const FavoritesPage());
      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            body: Center(child: Text('No route defined for ${settings.name}')),
          ),
        );
    }
  }
}
