import 'package:dio/dio.dart';
import '../models/auth_model.dart';
import 'token_manager.dart';

class AuthService {
  final Dio _dio = Dio();
  final TokenManager _tokenManager = TokenManager();
  final String _baseUrl = 'http://10.0.2.2:8000/api';

  AuthService() {
    _dio.options = BaseOptions(
      baseUrl: _baseUrl,
      connectTimeout: const Duration(seconds: 5),
      receiveTimeout: const Duration(seconds: 3),
      headers: {
        'Accept': 'application/json',
        'Content-Type': 'application/json',
      },
    );

    // Add logging interceptor for debugging
    if (true) {
      // Change to false in production
      _dio.interceptors.add(
        LogInterceptor(requestBody: true, responseBody: true, error: true),
      );
    }
  }

  Future<AuthModel> register(AuthModel user, String password) async {
    try {
      final response = await _dio.post(
        '$_baseUrl/register',
        data: {
          'name': user.name,
          'email': user.email,
          'password': password,
          'password_confirmation': password,
        },
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        if (response.data['status'] == true) {
          final userData = response.data['user'];
          final token = response.data['token'];

          // Add token to subsequent requests
          _dio.options.headers['Authorization'] = 'Bearer $token';

          return AuthModel.fromJson(userData);
        } else {
          throw Exception(response.data['message'] ?? 'Registration failed');
        }
      } else {
        throw Exception(
          'Registration failed with status: ${response.statusCode}',
        );
      }
    } on DioException catch (e) {
      if (e.response?.statusCode == 422) {
        final errors = e.response?.data['errors'];
        if (errors != null && errors is Map) {
          final firstError = errors.values.first;
          if (firstError is List && firstError.isNotEmpty) {
            throw Exception(firstError.first);
          }
        }
      }
      throw Exception(e.response?.data['message'] ?? 'Registration failed');
    }
  }

  Future<AuthModel> login(String email, String password) async {
    try {
      final response = await _dio.post(
        '/login',
        data: {
          'email': email,
          'password': password,
        },
      );

      print('Login Response: ${response.data}'); // Debug print

      if (response.statusCode == 200 && response.data['status'] == true) {
        final token = response.data['token'];
        
        // Save token
        await _tokenManager.saveToken(token);

        // Update Dio headers for subsequent requests
        _dio.options.headers['Authorization'] = 'Bearer $token';

        // Create AuthModel from user data with token
        final userData = response.data['user'];
        final user = AuthModel.fromJson(userData, token: token);
        
        return user;
      }
      throw Exception(response.data['message'] ?? 'Login failed');
    } on DioException catch (e) {
      print('Login Error: ${e.response?.data}'); // Debug print
      throw Exception(e.response?.data['message'] ?? 'Login failed');
    }
  }
}
