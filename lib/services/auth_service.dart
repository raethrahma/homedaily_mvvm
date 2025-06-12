import 'package:dio/dio.dart';
import '../models/auth_model.dart';

class AuthService {
  final Dio _dio = Dio();
  final String _baseUrl =
      'http://192.168.18.153:8000/api'; // Sesuaikan dengan URL API Laravel Anda

  Future<AuthModel> register(AuthModel user) async {
    try {
      final response = await _dio.post(
        '$_baseUrl/register',
        data: user.toJson(),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        return AuthModel.fromJson(response.data['data']);
      } else {
        throw Exception(response.data['message'] ?? 'Registration failed');
      }
    } on DioException catch (e) {
      throw Exception(e.response?.data['message'] ?? 'Registration failed');
    }
  }

  Future<AuthModel> login(String email, String password) async {
    try {
      final response = await _dio.post(
        '$_baseUrl/login',
        data: {'email': email, 'password': password},
      );

      if (response.statusCode == 200) {
        return AuthModel.fromJson(response.data['data']);
      } else {
        throw Exception(response.data['message'] ?? 'Login failed');
      }
    } on DioException catch (e) {
      throw Exception(e.response?.data['message'] ?? 'Login failed');
    }
  }
}
