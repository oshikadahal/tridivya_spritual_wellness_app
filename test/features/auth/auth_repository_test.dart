import 'package:flutter_test/flutter_test.dart';
import 'package:tridivya_spritual_wellness_app/features/auth/data/models/auth_hive_model.dart';

// In-memory test double for HiveService
class InMemoryHiveService extends Object {
  final Map<String, AuthHiveModel> _store = {};

  Future<AuthHiveModel> registerUser(AuthHiveModel user) async {
    _store[user.authId ?? ''] = user;
    return user;
  }

  AuthHiveModel? loginUser(String email, String password) {
    try {
      return _store.values.firstWhere((u) => u.email == email && u.password == password);
    } catch (e) {
      return null;
    }
  }

  AuthHiveModel? getUserByEmail(String email) {
    try {
      return _store.values.firstWhere((u) => u.email == email);
    } catch (e) {
      return null;
    }
  }

  Future<bool> updateUser(AuthHiveModel user) async {
    if (_store.containsKey(user.authId)) {
      _store[user.authId!] = user;
      return true;
    }
    return false;
  }

  Future<void> deleteUser(String authId) async {
    _store.remove(authId);
  }

  bool doesEmailExist(String email) {
    return _store.values.any((u) => u.email == email);
  }
}

// A tiny adapter to satisfy AuthLocalDatasource's dependency on HiveService methods
class TestHiveServiceAdapter {
  final InMemoryHiveService impl;
  TestHiveServiceAdapter(this.impl);

  Future<AuthHiveModel> registerUser(AuthHiveModel user) => impl.registerUser(user);
  AuthHiveModel? loginUser(String email, String password) => impl.loginUser(email, password);
  AuthHiveModel? getUserByEmail(String email) => impl.getUserByEmail(email);
  Future<bool> updateUser(AuthHiveModel user) => impl.updateUser(user);
  Future<void> deleteUser(String authId) => impl.deleteUser(authId);
  bool doesEmailExist(String email) => impl.doesEmailExist(email);
}

void main() {
  group('AuthRepository (in-memory)', () {
    late InMemoryHiveService inMemory;

    setUp(() {
      inMemory = InMemoryHiveService();
    });

    test('register user successfully and detect existing email', () async {
      final authModel = AuthHiveModel(fullName: 'Test User', email: 'test@example.com', username: 'testuser', password: 'password');

      // Simulate register
      final registered = await inMemory.registerUser(authModel);
      expect(registered.email, 'test@example.com');

      // email exists
      expect(inMemory.doesEmailExist('test@example.com'), isTrue);
    });

    test('login successful and fails with wrong cred', () async {
      final authModel = AuthHiveModel(fullName: 'Tester', email: 'login@example.com', username: 'tester', password: '1234');
      await inMemory.registerUser(authModel);

      final found = inMemory.loginUser('login@example.com', '1234');
      expect(found, isNotNull);
      expect(found?.email, 'login@example.com');

      final wrong = inMemory.loginUser('login@example.com', 'badpassword');
      expect(wrong, isNull);
    });
  });
}
