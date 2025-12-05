import 'package:flutter/material.dart';
import 'package:tridivya_spritual_wellness_app/screens/third_onboarding_screen.dart';

class SecondOnboardingScreen extends StatelessWidget {
  const SecondOnboardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
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
        child: SafeArea(
          child: Column(
            children: [
              const SizedBox(height: 70),

              // Logo or image for second screen
              Image.asset(
                "assets/images/onboarding2.png", // change your image here
                height: 250,
                width: 250,
              ),

              const SizedBox(height: 50),

              // Title
              const Text(
                "Tridivya Wellness",
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF5A4DB7),
                ),
              ),

              const SizedBox(height: 10),

              // Small title description
              const Text(
                "Enhance your mind and soul",
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.black87,
                  fontWeight: FontWeight.w500,
                ),
              ),

              const SizedBox(height: 20),

              // Paragraph text
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 40),
                child: Text(
                  "Explore meditation exercises and mindful practices to rejuvenate your inner self",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.black54,
                    height: 1.4,
                  ),
                ),
              ),

              const Spacer(),

              // Next Button
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 40),
                child: SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFFCCAFFF),
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (_) => const ThirdOnboardingScreen()),
                      );
                    },
                    child: const Text(
                      "Next",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
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
