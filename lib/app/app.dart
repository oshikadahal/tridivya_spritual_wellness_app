import 'package:flutter/material.dart';
import 'package:tridivya_spritual_wellness_app/screens/button_screen_layout.dart';
import 'package:tridivya_spritual_wellness_app/screens/first_onboarding_screen.dart';

import 'package:tridivya_spritual_wellness_app/screens/login_screen.dart';
import 'package:tridivya_spritual_wellness_app/screens/second_onboarding_screen.dart';
import 'package:tridivya_spritual_wellness_app/screens/signup_screen.dart';
import 'package:tridivya_spritual_wellness_app/screens/splash_screen.dart';




class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Tridivya',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
        scaffoldBackgroundColor: Colors.white,
        // Example text theme — tweak to match Figma
        textTheme: const TextTheme(
          displayLarge: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
          bodyMedium: TextStyle(fontSize: 14),
        ),
        // ElevatedButton theme used by MyButton if you rely on ElevatedButton.styleFrom
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            elevation: 2,
          ),
        ),
      ),

      // initialRoute can be '/' or whatever you prefer
      initialRoute: '/',
      routes: {
        '/': (context) => const SplashScreen(),
        '/onboarding1': (context) => const FirstOnboardingScreen(),
         '/onboarding2': (context) => const SecondOnboardingScreen(),
         '/login': (context) => const LoginScreen(),
         '/register': (context) => const SignupScreen(),
         '/home': (context) => const BottomScreenLayout(),
      },
    );
  }
}
