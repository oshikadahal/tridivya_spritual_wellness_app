import 'package:flutter/material.dart';
import 'package:tridivya_spritual_wellness_app/features/auth/presentation/pages/login_page.dart';
import 'package:tridivya_spritual_wellness_app/features/auth/presentation/pages/signup_page.dart';
import 'package:tridivya_spritual_wellness_app/features/splash/presentation/pages/splash_page.dart';
import 'package:tridivya_spritual_wellness_app/features/onboarding/presentation/pages/first_onboarding_page.dart';
import 'package:tridivya_spritual_wellness_app/features/onboarding/presentation/pages/second_onboarding_page.dart';
import 'package:tridivya_spritual_wellness_app/features/dashboard/presentation/pages/bottom_screen_layout.dart';

class Routes {
  Routes._();

  static const splash = '/';
  static const onboarding1 = '/onboarding1';
  static const onboarding2 = '/onboarding2';
  static const login = '/login';
  static const register = '/register';
  static const home = '/home';
}

class AppRouter {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case Routes.splash:
        return MaterialPageRoute(builder: (_) => const SplashScreen());
      case Routes.onboarding1:
        return MaterialPageRoute(builder: (_) => const FirstOnboardingScreen());
      case Routes.onboarding2:
        return MaterialPageRoute(builder: (_) => const SecondOnboardingScreen());
      case Routes.login:
        return MaterialPageRoute(builder: (_) => const LoginPage());
      case Routes.register:
        return MaterialPageRoute(builder: (_) => const SignupPage());
      case Routes.home:
        return MaterialPageRoute(builder: (_) => const BottomScreenLayout());
      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            body: Center(child: Text('No route defined for ${settings.name}')),
          ),
        );
    }
  }
}
