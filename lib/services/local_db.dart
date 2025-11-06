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

  Future<bool> resetPassword(String email, String newPassword) async {
    final user = await getUserByEmail(email);
    if (user == null) return false;
    
    user['password'] = newPassword;
    await _box.put(email, user);
    return true;
  }

  // Clear currently logged in user session
  Future<void> logout() async {
    // Here you would typically clear any session data, tokens, etc.
    // For now we'll just ensure the box is properly closed
    if (_box.isOpen) {
      // You might want to clear specific session data here
      // await _box.clear(); // Be careful with this as it clears ALL data
      // Instead you might want to just clear current session info:
      // await _box.delete('current_session');
    }
  }
}
