import 'package:flutter/material.dart';
import '../models/auth_model.dart';
import '../services/auth_service.dart';
import '../services/google_auth_service.dart';
import '../services/token_manager.dart';

class AuthViewModel extends ChangeNotifier {
  final AuthService _authService = AuthService();
  final GoogleAuthService _googleAuthService = GoogleAuthService();
  final TokenManager _tokenManager = TokenManager();
  bool _isLoading = false;
  String? _error;
  AuthModel? _currentUser;

  bool get isLoading => _isLoading;
  String? get error => _error;
  AuthModel? get currentUser => _currentUser;

  Future<bool> register({
    required String name,
    required String email,
    required String password,
  }) async {
    try {
      _isLoading = true;
      _error = null;
      notifyListeners();

      final user = AuthModel(name: name, email: email);

      _currentUser = await _authService.register(user, password);

      _isLoading = false;
      notifyListeners();
      return true;
    } catch (e) {
      _isLoading = false;
      _error = e.toString().replaceAll('Exception: ', '');
      notifyListeners();
      return false;
    }
  }

  Future<bool> login(String email, String password) async {
    try {
      _isLoading = true;
      _error = null;
      notifyListeners();

      _currentUser = await _authService.login(email, password);
      
      // Debug print untuk memastikan token tersimpan
      final token = await _tokenManager.getToken();
      print('Debug: Token after login: $token');

      _isLoading = false;
      notifyListeners();
      return true;
    } catch (e) {
      _error = e.toString();
      _isLoading = false;
      notifyListeners();
      return false;
    }
  }

  Future<bool> signInWithGoogle() async {
    try {
      _isLoading = true;
      _error = null;
      notifyListeners();

      _currentUser = await _googleAuthService.signInWithGoogle();

      _isLoading = false;
      notifyListeners();
      return true;
    } catch (e) {
      _isLoading = false;
      _error = e.toString().replaceAll('Exception: ', '');
      print('Google Sign In Error in ViewModel: $_error');
      notifyListeners();
      return false;
    }
  }

  void clearError() {
    _error = null;
    notifyListeners();
  }

  void logout() {
    _currentUser = null;
    notifyListeners();
  }
}
