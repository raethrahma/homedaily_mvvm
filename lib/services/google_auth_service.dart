import 'package:google_sign_in/google_sign_in.dart';
import 'package:dio/dio.dart';
import 'package:flutter/services.dart';
import '../models/auth_model.dart';

class GoogleAuthService {
  final GoogleSignIn _googleSignIn = GoogleSignIn(
    scopes: ['email', 'profile'],
    // Remove extra scope as it's not needed
  );

  final Dio _dio = Dio();
  final String _baseUrl = 'http://10.0.2.2:8000/api';

  Future<AuthModel> signInWithGoogle() async {
    try {
      // Remove signOut to prevent sign in issues
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
      if (googleUser == null) throw Exception('Sign in cancelled');

      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;

      print('Debug: Starting Google Sign In');
      print('Debug: Got user ${googleUser.email}');

      final response = await _dio.post(
        '$_baseUrl/auth/google',
        data: {
          'google_id': googleUser.id,
          'email': googleUser.email,
          'name': googleUser.displayName,
        },
        options: Options(
          headers: {
            'Accept': 'application/json',
            'Content-Type': 'application/json',
          },
          validateStatus: (status) => status! < 500,
        ),
      );

      print('Debug: Backend response ${response.statusCode}');
      print('Debug: Response data ${response.data}');

      if (response.statusCode == 200 && response.data['status'] == true) {
        final token = response.data['token'];
        _dio.options.headers['Authorization'] = 'Bearer $token';
        return AuthModel.fromJson(response.data['user']);
      } else {
        throw Exception(response.data['message'] ?? 'Google sign in failed');
      }
    } on PlatformException catch (e) {
      print('Debug: Platform Exception - ${e.code}: ${e.message}');
      if (e.code == 'sign_in_failed') {
        throw Exception('Please check your Google Cloud Console configuration');
      }
      throw Exception(e.message ?? 'Google sign in failed');
    } on DioException catch (e) {
      print('Debug: Network Error - ${e.message}');
      throw Exception('Network error: ${e.message}');
    } catch (e) {
      print('Debug: General Error - $e');
      throw Exception('Authentication failed: $e');
    }
  }
}
