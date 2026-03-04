import 'package:flutter/foundation.dart';
import '../data/api/api_service.dart';
import '../data/preferences/auth_preferences.dart';
import '../data/model/login_response.dart';

class AuthProvider with ChangeNotifier {
  final ApiService apiService;
  final AuthPreferences authPreferences;

  bool _isLoading = false;
  String? _errorMessage;
  LoginResult? _loginResult;

  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;
  LoginResult? get loginResult => _loginResult;

  AuthProvider({required this.apiService, required this.authPreferences});

  Future login(String email, String password) async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      final response = await apiService.login(email, password);

      if (!response.error && response.loginResult != null) {
        _loginResult = response.loginResult;
        await authPreferences.saveAuthData(
          response.loginResult!.token,
          response.loginResult!.userId,
          response.loginResult!.name,
        );
        _isLoading = false;
        notifyListeners();
        return true;
      } else {
        _errorMessage = response.message;
        _isLoading = false;
        notifyListeners();
        return false;
      }
    } catch (e) {
      _errorMessage = e.toString();
      _isLoading = false;
      notifyListeners();
      return false;
    }
  }

  Future register(String name, String email, String password) async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      final response = await apiService.register(name, email, password);

      if (!response.error) {
        _isLoading = false;
        notifyListeners();
        return true;
      } else {
        _errorMessage = response.message;
        _isLoading = false;
        notifyListeners();
        return false;
      }
    } catch (e) {
      _errorMessage = e.toString();
      _isLoading = false;
      notifyListeners();
      return false;
    }
  }

  Future logout() async {
    await authPreferences.clearAuth();
    _loginResult = null;
    notifyListeners();
    return true;
  }

  Future isLoggedIn() async {
    return await authPreferences.isLoggedIn();
  }

  Future getToken() async {
    return await authPreferences.getToken();
  }
}
