import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tridivya_spritual_wellness_app/core/services/storage/user_session_service.dart';
import 'package:tridivya_spritual_wellness_app/features/auth/presentation/pages/login_page.dart';

class ThirdOnboardingScreen extends ConsumerWidget {
  const ThirdOnboardingScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color(0xFFFCE1F8), // top light pink
              Color(0xFFD1E8F2), // bottom light blue
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                "assets/images/onboarding.png",
                height: 280,
              ),

              const SizedBox(height: 30),

              const Text(
                "Start Your Journey",
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Colors.deepPurple, // same as 2nd onboarding
                ),
                textAlign: TextAlign.center,
              ),

              const SizedBox(height: 15),

              const Text(
                "Improve your lifestyle with daily\nyoga and meditation practices.",
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.black87, // matches second screen subtitle
                ),
                textAlign: TextAlign.center,
              ),

              const SizedBox(height: 40),

              ElevatedButton(
                onPressed: () async {
                  await ref.read(userSessionServiceProvider).setOnboardingComplete();
                  if (context.mounted) {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const LoginPage(),
                      ),
                    );
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.deepPurpleAccent,
                  padding: const EdgeInsets.symmetric(
                      horizontal: 60, vertical: 14),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25),
                  ),
                ),

                
                child: const Text(
                  "Get Started",
                  style: TextStyle(
                    fontSize: 18,
                    color:Colors.white, // matches 2nd onboarding button text
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
