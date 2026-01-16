import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';
import 'package:tridivya_spritual_wellness_app/core/constants/hive_table_constant.dart';
import 'package:tridivya_spritual_wellness_app/features/auth/data/models/auth_hive_model.dart';

final hiveServiceProvider = Provider<HiveService>((ref) {
  return HiveService.instance;
});

class HiveService {
  static final HiveService _instance = HiveService._internal();

  HiveService._internal();

  static HiveService get instance => _instance;

  /// Initialize Hive. If [dbPath] is provided it will be used instead of the
  /// platform-specific documents directory. This makes testing easier.
  Future<void> init({String? dbPath}) async {
    final path = dbPath ?? '${(await getApplicationDocumentsDirectory()).path}/${HiveTableConstant.dbName}';
    Hive.init(path);

    _registerAdapters();
    await _openBoxes();
  }

  void _registerAdapters() {
    if (!Hive.isAdapterRegistered(HiveTableConstant.userTypeId)) {
      Hive.registerAdapter(AuthHiveModelAdapter());
    }
  }

  Future<void> _openBoxes() async {
    await Hive.openBox<AuthHiveModel>(HiveTableConstant.userTable);
  }

  Future<void> close() async {
    await Hive.close();
  }

  // ====================Authentication Queries=====================
  Box<AuthHiveModel> get _authBox => Hive.box<AuthHiveModel>(HiveTableConstant.userTable);

  Future<AuthHiveModel> registerUser(AuthHiveModel user) async {
    await _authBox.put(user.authId, user);
    return user;
  }

  AuthHiveModel? loginUser(String email, String password) {
    try {
      return _authBox.values.firstWhere(
        (user) => user.email == email && user.password == password,
      );
    } catch (e) {
      return null;
    }
  }

  Future<void> logoutUser() async {}

  AuthHiveModel? getCurrentUser() {
    // Optional: implement using a 'current_user' key; placeholder for now
    return null;
  }

  AuthHiveModel? getUserById(String authId) {
    return _authBox.get(authId);
  }

  AuthHiveModel? getUserByEmail(String email) {
    try {
      return _authBox.values.firstWhere((user) => user.email == email);
    } catch (e) {
      return null;
    }
  }

  Future<bool> updateUser(AuthHiveModel user) async {
    if (_authBox.containsKey(user.authId)) {
      await _authBox.put(user.authId, user);
      return true;
    }
    return false;
  }

  Future<void> deleteUser(String authId) async {
    await _authBox.delete(authId);
  }

  bool doesEmailExist(String email) {
    final users = _authBox.values.where((user) => user.email == email);
    bool emailExists = users.isNotEmpty;
    return emailExists;
  }
}