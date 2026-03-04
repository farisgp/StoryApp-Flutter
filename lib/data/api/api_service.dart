import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import '../model/login_response.dart';
import '../model/register_response.dart';
import '../model/story.dart';
import '../model/upload_response.dart';

class ApiException implements Exception {
  final String message;
  ApiException(this.message);

  @override
  String toString() => message;
}

class ApiService {
  static const String baseUrl = 'https://story-api.dicoding.dev/v1';

  String _getErrorMessage(dynamic error) {
    if (error is SocketException) {
      return 'Unable to connect to the server. Please check your internet connection and try again.';
    } else if (error is HttpException) {
      return 'Unable to load data. Please try again later.';
    } else if (error is FormatException) {
      return 'Invalid data format received. Please try again.';
    } else if (error is http.ClientException) {
      return 'Network error occurred. Please check your connection and try again.';
    }
    return 'An unexpected error occurred. Please try again.';
  }

  Future<LoginResponse> login(String email, String password) async {
    try {
      final response = await http
          .post(
            Uri.parse('$baseUrl/login'),
            headers: {'Content-Type': 'application/json'},
            body: jsonEncode({'email': email, 'password': password}),
          )
          .timeout(
            const Duration(seconds: 30),
            onTimeout: () {
              throw ApiException(
                'Connection timeout. Please check your internet connection and try again.',
              );
            },
          );

      final responseData = jsonDecode(response.body);
      final loginResponse = LoginResponse.fromJson(responseData);

      if (response.statusCode == 200 || response.statusCode == 201) {
        return loginResponse;
      } else if (response.statusCode == 401) {
        throw ApiException('Invalid email or password. Please try again.');
      } else if (response.statusCode >= 500) {
        throw ApiException('Server error occurred. Please try again later.');
      } else {
        throw ApiException(
          loginResponse.message.isNotEmpty
              ? loginResponse.message
              : 'Login failed. Please try again.',
        );
      }
    } catch (e) {
      if (e is ApiException) {
        rethrow;
      }
      throw ApiException(_getErrorMessage(e));
    }
  }

  Future<RegisterResponse> register(
    String name,
    String email,
    String password,
  ) async {
    try {
      final response = await http
          .post(
            Uri.parse('$baseUrl/register'),
            headers: {'Content-Type': 'application/json'},
            body: jsonEncode({
              'name': name,
              'email': email,
              'password': password,
            }),
          )
          .timeout(
            const Duration(seconds: 30),
            onTimeout: () {
              throw ApiException(
                'Connection timeout. Please check your internet connection and try again.',
              );
            },
          );

      final responseData = jsonDecode(response.body);
      final registerResponse = RegisterResponse.fromJson(responseData);

      if (response.statusCode == 200 || response.statusCode == 201) {
        return registerResponse;
      } else if (response.statusCode == 400) {
        throw ApiException(
          'Email already registered. Please use a different email.',
        );
      } else if (response.statusCode >= 500) {
        throw ApiException('Server error occurred. Please try again later.');
      } else {
        throw ApiException(
          registerResponse.message.isNotEmpty
              ? registerResponse.message
              : 'Registration failed. Please try again.',
        );
      }
    } catch (e) {
      if (e is ApiException) {
        rethrow;
      }
      throw ApiException(_getErrorMessage(e));
    }
  }

  Future<StoryListResponse> getAllStories(
    String token, {
    int page = 1,
    int size = 10,
  }) async {
    try {
      final response = await http
          .get(
            Uri.parse('$baseUrl/stories?page=$page&size=$size'),
            headers: {'Authorization': 'Bearer $token'},
          )
          .timeout(
            const Duration(seconds: 30),
            onTimeout: () {
              throw ApiException(
                'Connection timeout. Please check your internet connection and try again.',
              );
            },
          );

      if (response.statusCode == 200) {
        return StoryListResponse.fromJson(jsonDecode(response.body));
      } else if (response.statusCode == 401) {
        throw ApiException('Session expired. Please login again.');
      } else if (response.statusCode >= 500) {
        throw ApiException('Server error occurred. Please try again later.');
      } else {
        throw ApiException('Unable to load stories. Please try again.');
      }
    } catch (e) {
      if (e is ApiException) {
        rethrow;
      }
      throw ApiException(_getErrorMessage(e));
    }
  }

  Future<StoryDetailResponse> getStoryDetail(String token, String id) async {
    try {
      final response = await http
          .get(
            Uri.parse('$baseUrl/stories/$id'),
            headers: {'Authorization': 'Bearer $token'},
          )
          .timeout(
            const Duration(seconds: 30),
            onTimeout: () {
              throw ApiException(
                'Connection timeout. Please check your internet connection and try again.',
              );
            },
          );

      if (response.statusCode == 200) {
        return StoryDetailResponse.fromJson(jsonDecode(response.body));
      } else if (response.statusCode == 401) {
        throw ApiException('Session expired. Please login again.');
      } else if (response.statusCode == 404) {
        throw ApiException('Story not found. It may have been deleted.');
      } else if (response.statusCode >= 500) {
        throw ApiException('Server error occurred. Please try again later.');
      } else {
        throw ApiException('Unable to load story details. Please try again.');
      }
    } catch (e) {
      if (e is ApiException) {
        rethrow;
      }
      throw ApiException(_getErrorMessage(e));
    }
  }

  Future<UploadResponse> uploadStory(
    String token,
    String description,
    File photo, {
        double? lat,
        double? lon,
      }) async {
    try {
      var request = http.MultipartRequest(
        'POST',
        Uri.parse('$baseUrl/stories'),
      );
      request.headers['Authorization'] = 'Bearer $token';
      request.fields['description'] = description;

      if (lat != null && lon != null) {
        request.fields['lat'] = lat.toString();
        request.fields['lon'] = lon.toString();
      }

      var multipartFile = await http.MultipartFile.fromPath(
        'photo',
        photo.path,
      );
      request.files.add(multipartFile);

      var streamedResponse = await request.send().timeout(
        const Duration(seconds: 60),
        onTimeout: () {
          throw ApiException(
            'Upload timeout. Please check your internet connection and try again.',
          );
        },
      );

      var response = await http.Response.fromStream(streamedResponse);
      final responseData = jsonDecode(response.body);
      final uploadResponse = UploadResponse.fromJson(responseData);

      if (response.statusCode == 200 || response.statusCode == 201) {
        return uploadResponse;
      } else if (response.statusCode == 401) {
        throw ApiException('Session expired. Please login again.');
      } else if (response.statusCode == 413) {
        throw ApiException(
          'File size too large. Please select a smaller image.',
        );
      } else if (response.statusCode >= 500) {
        throw ApiException('Server error occurred. Please try again later.');
      } else {
        throw ApiException(
          uploadResponse.message.isNotEmpty
              ? uploadResponse.message
              : 'Upload failed. Please try again.',
        );
      }
    } catch (e) {
      if (e is ApiException) {
        rethrow;
      }
      throw ApiException(_getErrorMessage(e));
    }
  }
}
