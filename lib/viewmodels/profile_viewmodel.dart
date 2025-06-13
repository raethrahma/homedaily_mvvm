import 'package:flutter/material.dart';
import '../services/profile_service.dart';
import '../models/address.dart';
import '../services/token_manager.dart';

class ProfileViewModel extends ChangeNotifier {
  final ProfileService _profileService = ProfileService();
  final TokenManager _tokenManager = TokenManager();
  
  String userName = 'Loading...';
  String userEmail = 'Loading...';
  String userPhone = 'Not Available';
  String? userPhoto; // Add this for profile photo
  List<AddressModel> addresses = [];
  bool isLoading = false;
  String? error;

  // Add getter for addressData
  Map<String, String> get addressData {
    if (addresses.isEmpty) {
      return {
        'Street': 'No address available',
        'City': '',
        'Province': '',
        'Detail Address': '',
      };
    }

    final address = addresses.first;
    return {
      'Street': address.fullAddress,
      'City': address.city,
      'Province': address.province,
      'Detail Address': '${address.fullAddress}\nPostal Code: ${address.postalCode}',
    };
  }

  Future<void> loadProfile() async {
    try {
      isLoading = true;
      notifyListeners();

      final response = await _profileService.getProfile();
      print('Debug - Profile Response: $response'); // Debug print
      
      if (response['status'] == 'success' && response['data'] != null) {
        final userData = response['data'];
        userName = userData['name'] ?? 'No Name';
        userEmail = userData['email'] ?? 'No Email';
        userPhone = userData['phone_number'] ?? 'Not Available';
        userPhoto = userData['profile_picture']; // Handle profile photo
        
        // Clear existing addresses
        addresses.clear();
        
        // Parse addresses with null check and type casting
        if (userData['addresses'] != null && userData['addresses'] is List) {
          addresses = (userData['addresses'] as List)
              .map((addr) {
                try {
                  return AddressModel.fromJson(addr as Map<String, dynamic>);
                } catch (e) {
                  print('Error parsing address: $e');
                  return null;
                }
              })
              .where((addr) => addr != null)
              .cast<AddressModel>()
              .toList();
          
          print('Debug - Loaded ${addresses.length} addresses'); // Debug print
        }
      }
    } catch (e) {
      error = e.toString();
      print('Debug - Error loading profile: $e'); // Debug print
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  Future<void> logout() async {
    try {
      await _tokenManager.removeToken();
      addresses.clear();
      userName = 'Loading...';
      userEmail = 'Loading...';
      userPhone = 'Not Available';
      userPhoto = null;
      notifyListeners();
    } catch (e) {
      error = e.toString();
      notifyListeners();
    }
  }

  Future<bool> addAddress({
    required String recipientName,
    required String phoneNumber,
    required String fullAddress,
    required String postalCode,
    required String city,
    required String province,
  }) async {
    try {
      isLoading = true;
      notifyListeners();

      final response = await _profileService.addAddress(
        recipientName: recipientName,
        phoneNumber: phoneNumber,
        fullAddress: fullAddress,
        postalCode: postalCode,
        city: city,
        province: province,
      );

      if (response['status'] == 'success') {
        await loadProfile();
        return true;
      } else {
        throw Exception(response['message'] ?? 'Failed to add address');
      }
    } catch (e) {
      error = e.toString();
      debugPrint('Error adding address: $e');
      return false;
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  Future<bool> deleteAddress(int addressId) async {
    try {
      isLoading = true;
      notifyListeners();

      final response = await _profileService.deleteAddress(addressId);

      if (response['status'] == 'success') {
        await loadProfile();
        return true;
      } else {
        throw Exception(response['message'] ?? 'Failed to delete address');
      }
    } catch (e) {
      error = e.toString();
      return false;
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  Future<bool> updateAddress({
    required int addressId,
    required String recipientName,
    required String phoneNumber,
    required String fullAddress,
    required String postalCode,
    required String city,
    required String province,
  }) async {
    try {
      isLoading = true;
      notifyListeners();

      final response = await _profileService.updateAddress(
        addressId: addressId,
        recipientName: recipientName,
        phoneNumber: phoneNumber,
        fullAddress: fullAddress,
        postalCode: postalCode,
        city: city,
        province: province,
      );

      if (response['status'] == 'success') {
        await loadProfile(); // Refresh the addresses list
        return true;
      }
      throw Exception(response['message'] ?? 'Failed to update address');
    } catch (e) {
      error = e.toString();
      debugPrint('Error updating address: $e');
      return false;
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }
}