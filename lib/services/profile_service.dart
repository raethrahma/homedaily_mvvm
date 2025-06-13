import 'package:dio/dio.dart';
import '../services/token_manager.dart';

class ProfileService {
  final Dio _dio = Dio();
  final TokenManager _tokenManager = TokenManager();
  final String _baseUrl = 'http://10.0.2.2:8000/api';

  Future<Map<String, dynamic>> getProfile() async {
    try {
      final token = await _tokenManager.getToken();
      print('Debug - Token: $token'); // Debug print
      
      if (token == null) throw Exception('Not authenticated');

      final response = await _dio.get(
        '$_baseUrl/profile',
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
            'Accept': 'application/json',
          },
        ),
      );

      print('Debug - Raw Response: ${response.data}'); // Debug print

      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = response.data;
        
        if (responseData['status'] == 'success') {
          print('Debug - Profile Data: ${responseData['data']}'); // Debug print
          return responseData;
        }
        
        throw Exception('Profile request failed');
      }
      
      throw Exception('Failed to load profile');
    } catch (e) {
      print('Debug - Error in getProfile: $e'); // Debug print
      rethrow;
    }
  }
}