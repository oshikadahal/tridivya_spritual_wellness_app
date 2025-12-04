import 'package:flutter/material.dart';
import 'package:tridivya_spritual_wellness_app/screens/login_screen.dart';


class ThirdOnboardingScreen extends StatelessWidget {
  const ThirdOnboardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [

            Image.asset(
              "assets/images/onboard3.png",
              height: 280,
            ),

            const SizedBox(height: 30),

            const Text(
              "Start Your Journey",
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: Color(0xFF0C7272),
              ),
              textAlign: TextAlign.center,
            ),

            const SizedBox(height: 15),

            const Text(
              "Improve your lifestyle with daily\n"
              "yoga and meditation practices.",
              style: TextStyle(
                fontSize: 16,
                color: Colors.black54,
              ),
              textAlign: TextAlign.center,
            ),

            const SizedBox(height: 40),

            ElevatedButton(
              onPressed: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const LoginScreen(),
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF0C7272),
                padding:
                    const EdgeInsets.symmetric(horizontal: 60, vertical: 14),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25)),
              ),
              child: const Text(
                "Get Started",
                style: TextStyle(fontSize: 18, color: Colors.white),
              ),
            ),

          ],
        ),
      ),
    );
  }
}
