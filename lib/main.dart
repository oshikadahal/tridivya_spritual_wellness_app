import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tridivya_spritual_wellness_app/app.dart';
import 'package:tridivya_spritual_wellness_app/core/providers/shared_preferences_provider.dart';
import 'package:tridivya_spritual_wellness_app/core/services/hive/hive_service.dart';




Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.pinkAccent,
      statusBarIconBrightness: Brightness.dark,
      systemNavigationBarColor: Colors.white,
      systemNavigationBarIconBrightness: Brightness.dark,
    ),
  );

  // Initialize Hive database
  await HiveService.instance.init();

  // Initialize SharedPreferences
  // This is required because SharedPreferences is async,
  // but Riverpod providers are sync by default.
  // So we initialize it here and override the provider.
  final sharedPreferences = await SharedPreferences.getInstance();

  runApp(
    ProviderScope(
      overrides: [
        sharedPreferencesProvider.overrideWithValue(sharedPreferences),
      ],
      child: const MyApp(),
    ),
  );
} 
// void main() async {
//   WidgetsFlutterBinding.ensureInitialized();

//   // Initialize Hive
//   final hiveService = HiveService();
//   await hiveService.init();

//   // Initialize SharedPreferences
//   final prefs = await SharedPreferences.getInstance();

//   runApp(
//     ProviderScope(
//       overrides: [
//         sharedPreferencesProvider.overrideWithValue(prefs),
//         hiveServiceProvider.overrideWithValue(hiveService),
//       ],
//       child: const MyApp(),
//     ),
//   );
// }
