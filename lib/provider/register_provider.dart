// import 'dart:io';

// import 'package:flutter/material.dart';
// import 'package:storyapp/data/api/api_service.dart';

// class RegisterProvider extends ChangeNotifier {
//   ApiService apiService;
//   RegisterProvider({required this.apiService});

//   bool _isRegistering = false;
//   bool _isSuccess = false;
//   String _message = "";

//   bool get isRegistering => _isRegistering;
//   bool get isSuccess => _isSuccess;
//   String get message => _message;

//   Future<void> register(String name, String email, String password) async {
//     try {
//       _isRegistering = true;
//       notifyListeners();

//       final response = await apiService.register(name, email, password);
//       _message = response.message;
//       _isSuccess = true;
//       notifyListeners();
//     } on SocketException catch (_) {
//       _isSuccess = false;
//       _message = "No internet connection";
//       notifyListeners();
//     } catch (e) {
//       _isSuccess = false;
//       _message = e.toString();
//       notifyListeners();
//     } finally {
//       _isRegistering = false;
//       notifyListeners();
//     }
//   }
// }
