import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:tridivya_spritual_wellness_app/core/services/hive/hive_service.dart';
import 'package:tridivya_spritual_wellness_app/features/auth/data/models/auth_hive_model.dart';
import 'package:tridivya_spritual_wellness_app/features/auth/data/datasources/local/auth_local_datasource.dart';

void main() {
  group('HiveService integration', () {
    late Directory tmpDir;
    late HiveService hiveService;

    setUp(() async {
      tmpDir = await Directory.systemTemp.createTemp('hive_test');
      hiveService = HiveService();
      await hiveService.init(dbPath: tmpDir.path);
    });

    tearDown(() async {
      await hiveService.close();
      try {
        await tmpDir.delete(recursive: true);
      } catch (_) {}
    });

    test('register and login user using HiveService', () async {
      final user = AuthHiveModel(fullName: 'Integration', email: 'int@example.com', username: 'intg', password: 'pass');
      final registered = await hiveService.registerUser(user);
      expect(registered.email, 'int@example.com');

      final login = hiveService.loginUser('int@example.com', 'pass');
      expect(login, isNotNull);
      expect(login!.email, 'int@example.com');
    });
  });
}
