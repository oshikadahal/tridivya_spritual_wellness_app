import 'package:flutter/material.dart';
import 'package:tridivya_spritual_wellness_app/app/routes/app_routes.dart';
import 'package:tridivya_spritual_wellness_app/app/routes/app_router.dart';




class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: AppRoutes.navigatorKey,
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
      initialRoute: Routes.splash,
      onGenerateRoute: AppRouter.generateRoute,
    );
  }
}
