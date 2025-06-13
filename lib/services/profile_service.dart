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

  Future<Map<String, dynamic>> addAddress({
    required String recipientName,
    required String phoneNumber,
    required String fullAddress,
    required String postalCode,
    required String city,
    required String province,
  }) async {
    try {
      final token = await _tokenManager.getToken();
      if (token == null) throw Exception('Not authenticated');

      print('Debug - Sending address data: {recipient_name: $recipientName, phone_number: $phoneNumber}'); // Debug print

      final response = await _dio.post(
        '$_baseUrl/profile/address',
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
            'Accept': 'application/json',
            'Content-Type': 'application/json',
          },
        ),
        data: {
          'recipient_name': recipientName,
          'phone_number': phoneNumber,
          'full_address': fullAddress,
          'postal_code': postalCode,
          'city': city,
          'province': province,
        },
      );

      print('Debug - Address API Response: ${response.data}'); // Debug print

      if (response.statusCode == 201) {
        final Map<String, dynamic> responseData = response.data;
        if (responseData['status'] == 'success') {
          return responseData;
        }
        throw Exception(responseData['message'] ?? 'Failed to add address');
      }
      
      throw Exception('Failed to add address');
    } catch (e) {
      print('Debug - Error in addAddress: $e'); // Debug print
      rethrow;
    }
  }

  Future<Map<String, dynamic>> deleteAddress(int addressId) async {
    try {
      final token = await _tokenManager.getToken();
      if (token == null) throw Exception('Not authenticated');

      final response = await _dio.delete(
        '$_baseUrl/profile/address/$addressId',
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
            'Accept': 'application/json',
          },
        ),
      );

      print('Debug - Delete Address Response: ${response.data}');

      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = response.data;
        if (responseData['status'] == 'success') {
          return responseData;
        }
        throw Exception(responseData['message'] ?? 'Failed to delete address');
      }
      
      throw Exception('Failed to delete address');
    } catch (e) {
      print('Debug - Error in deleteAddress: $e');
      rethrow;
    }
  }

  Future<Map<String, dynamic>> updateAddress({
    required int addressId,
    required String recipientName,
    required String phoneNumber,
    required String fullAddress,
    required String postalCode,
    required String city,
    required String province,
  }) async {
    try {
      final token = await _tokenManager.getToken();
      if (token == null) throw Exception('Not authenticated');

      final response = await _dio.put(
        '$_baseUrl/profile/address/$addressId',
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
            'Accept': 'application/json',
            'Content-Type': 'application/json',
          },
        ),
        data: {
          'recipient_name': recipientName,
          'phone_number': phoneNumber,
          'full_address': fullAddress,
          'postal_code': postalCode,
          'city': city,
          'province': province,
        },
      );

      print('Debug - Update Address Response: ${response.data}');

      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = response.data;
        if (responseData['status'] == 'success') {
          return responseData;
        }
        throw Exception(responseData['message'] ?? 'Failed to update address');
      }
      
      throw Exception('Failed to update address');
    } catch (e) {
      print('Debug - Error in updateAddress: $e');
      rethrow;
    }
  }
}