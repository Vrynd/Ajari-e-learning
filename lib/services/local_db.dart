import 'package:hive_flutter/hive_flutter.dart';

class LocalDB {
  static final LocalDB _instance = LocalDB._internal();
  factory LocalDB() => _instance;
  LocalDB._internal();

  Box get _box => Hive.box('users');

  Future<void> insertUser(Map<String, dynamic> user) async {
    final email = user['email'] as String;
    // store entire user map keyed by email
    await _box.put(email, user);
  }

  Future<Map<String, dynamic>?> getUserByEmail(String email) async {
    final data = _box.get(email);
    if (data == null) return null;
    // hive returns dynamic; ensure Map<String, dynamic>
    return Map<String, dynamic>.from(data as Map);
  }

  Future<bool> authenticate(String email, String password) async {
    final user = await getUserByEmail(email);
    if (user == null) return false;
    return user['password'] == password;
  }
}
