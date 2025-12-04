import 'package:flutter/material.dart';
import 'third_onboarding_screen.dart';

class SecondOnboardingScreen extends StatelessWidget {
  const SecondOnboardingScreen({super.key});

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
              "assets/images/onboard2.png",
              height: 280,
            ),

            const SizedBox(height: 30),

            const Text(
              "Meditation Made Easy",
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: Color(0xFF0C7272),
              ),
              textAlign: TextAlign.center,
            ),

            const SizedBox(height: 15),

            const Text(
              "Calm your mind with simple guided\n"
              "meditation sessions.",
              style: TextStyle(
                fontSize: 16,
                color: Colors.black54,
              ),
              textAlign: TextAlign.center,
            ),

            const SizedBox(height: 40),

            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const ThirdOnboardingScreen(),
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
                "Next",
                style: TextStyle(fontSize: 18, color: Colors.white),
              ),
            ),

          ],
        ),
      ),
    );
  }
}
