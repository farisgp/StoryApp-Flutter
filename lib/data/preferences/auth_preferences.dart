import 'package:shared_preferences/shared_preferences.dart';

class AuthPreferences {
  static const String _tokenKey = 'token';
  static const String _userIdKey = 'userId';
  static const String _nameKey = 'name';
  static const String _isLoggedInKey = 'isLoggedIn';

  Future saveAuthData(String token, String userId, String name) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_tokenKey, token);
    await prefs.setString(_userIdKey, userId);
    await prefs.setString(_nameKey, name);
    await prefs.setBool(_isLoggedInKey, true);
    return true;
  }

  Future getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_tokenKey);
  }

  Future getUserId() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_userIdKey);
  }

  Future getName() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_nameKey);
  }

  Future isLoggedIn() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_isLoggedInKey) ?? false;
  }

  Future<void> clearAuth() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.clear();
  }
}
