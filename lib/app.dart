import 'package:flutter/material.dart';
import 'features/onboarding/onboarding_page.dart';
import 'shared/themes/app_theme.dart';
// Import your routing, and global providers here

/// MaterialApp wrapper with routing and global Bloc providers
class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Car Rental',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      home: const OnboardingPage(),
    );
  }
}
