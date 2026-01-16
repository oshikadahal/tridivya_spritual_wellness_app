import 'package:flutter/material.dart';
import 'package:tridivya_spritual_wellness_app/app/routes/app_routes.dart';
import 'package:tridivya_spritual_wellness_app/app/theme/theme_data.dart';
import 'package:tridivya_spritual_wellness_app/features/splash/presentation/pages/splash_screen.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      navigatorKey: AppRoutes.navigatorKey,
      theme: getApplicationTheme(),
      title: 'Tridivya Wellness',
      home: const SplashScreen(),
    );
  }
}
