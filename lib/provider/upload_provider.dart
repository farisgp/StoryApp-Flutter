import 'dart:io';
import 'package:flutter/foundation.dart';
import '../data/api/api_service.dart';

class UploadProvider with ChangeNotifier {
  final ApiService apiService;

  bool _isLoading = false;
  String? _errorMessage;
  String? _successMessage;

  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;
  String? get successMessage => _successMessage;

  UploadProvider({required this.apiService});

  Future<bool> uploadStory(
    String token,
    String description,
    File photo, {
    double? lat,
    double? lon,
  }) async {
    _isLoading = true;
    _errorMessage = null;
    _successMessage = null;
    notifyListeners();

    try {
      final fileSize = await photo.length();
      if (fileSize > 1024 * 1024) {
        _errorMessage = 'File size must be less than 1MB';
        _isLoading = false;
        notifyListeners();
        return false;
      }

      final response = await apiService.uploadStory(token, description, photo, lat: lat, lon: lon);

      if (!response.error) {
        _successMessage = response.message;
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

  void clearMessages() {
    _errorMessage = null;
    _successMessage = null;
    notifyListeners();
  }
}
