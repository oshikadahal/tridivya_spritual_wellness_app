import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tridivya_spritual_wellness_app/app/app.dart';
import 'package:tridivya_spritual_wellness_app/core/services/hive/hive_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await HiveService().init();
  runApp(const ProviderScope(child: App()));
}
