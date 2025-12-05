import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'di/injection_container.dart';
import 'features/auth/presentation/blocs/auth_bloc.dart';
import 'features/onboarding/onboarding_page.dart';
import 'routes/app_router.dart';
import 'shared/themes/app_theme.dart';

/// MaterialApp wrapper with routing and global Bloc providers
class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [BlocProvider(create: (_) => sl<AuthBloc>())],
      child: MaterialApp(
        title: 'Car Rental',
        debugShowCheckedModeBanner: false,
        theme: AppTheme.lightTheme,
        onGenerateRoute: AppRouter.generateRoute,
        initialRoute: AppRouter.splash,
      ),
    );
  }
}
