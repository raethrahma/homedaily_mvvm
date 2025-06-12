import 'package:dio/dio.dart';
import '../models/auth_model.dart';

class AuthService {
  final Dio _dio = Dio();
  // For Android Emulator use 10.0.2.2 instead of localhost/IP
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
        data: {'email': email, 'password': password},
      );

      if (response.statusCode == 200) {
        if (response.data['status'] == true) {
          final userData = response.data['user'];
          final token = response.data['token'];

          // Add token to subsequent requests
          _dio.options.headers['Authorization'] = 'Bearer $token';

          return AuthModel.fromJson(userData);
        } else {
          throw Exception(response.data['message'] ?? 'Login failed');
        }
      } else {
        throw Exception('Login failed with status: ${response.statusCode}');
      }
    } on DioException catch (e) {
      if (e.type == DioExceptionType.connectionTimeout) {
        throw Exception(
          'Connection timed out. Please check your internet connection.',
        );
      }

      if (e.type == DioExceptionType.connectionError) {
        throw Exception(
          'Could not connect to the server. Please check your internet connection.',
        );
      }

      final response = e.response;
      if (response != null) {
        if (response.statusCode == 422) {
          final errors = response.data['errors'];
          if (errors != null && errors is Map) {
            final firstError = errors.values.first;
            if (firstError is List && firstError.isNotEmpty) {
              throw Exception(firstError.first);
            }
          }
        }

        if (response.statusCode == 401) {
          throw Exception('Invalid email or password');
        }
      }

      throw Exception('Connection failed. Please try again.');
    } catch (e) {
      throw Exception('An unexpected error occurred: ${e.toString()}');
    }
  }
}
