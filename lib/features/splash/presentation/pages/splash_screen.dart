import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tridivya_spritual_wellness_app/app/routes/app_routes.dart';
import 'package:tridivya_spritual_wellness_app/core/services/storage/user_session_service.dart';
import 'package:tridivya_spritual_wellness_app/features/auth/presentation/pages/login_page.dart';
import 'package:tridivya_spritual_wellness_app/features/dashboard/presentation/pages/bottom_screen_layout.dart';
import 'package:tridivya_spritual_wellness_app/features/onboarding/presentation/pages/first_onboarding_screen.dart';

class SplashScreen extends ConsumerStatefulWidget {
  const SplashScreen({super.key});

  @override
  ConsumerState<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends ConsumerState<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _navigateToNext();
  }

  Future<void> _navigateToNext() async {
    await Future.delayed(const Duration(seconds: 2));
    if (!mounted) return;
    final session = ref.read(userSessionServiceProvider);
    if (session.isLoggedIn()) {
      AppRoutes.pushReplacement(const BottomScreenLayout());
      return;
    }

    if (session.hasCompletedOnboarding()) {
      AppRoutes.pushReplacement(const LoginPage());
    } else {
      AppRoutes.pushReplacement(
        FirstOnboardingScreen(
          onNext: () {},
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFFA5D8FF), Color(0xFFE1C4FF)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // App Logo
              Image.asset(
                'assets/images/logo.png',
                height: 160,
                width: 160,
              ),
              SizedBox(height: 20),
              // App Name
              Text(
                'Tridivya',
                style: TextStyle(
                  fontSize: 34,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              SizedBox(height: 8),
              // Subtitle
              Text(
                'Yoga . Meditate . Mantra',
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
