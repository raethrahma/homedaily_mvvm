import 'package:flutter/material.dart';

class ProfileViewModel extends ChangeNotifier {
  String _userName = 'John Doe';
  String _userEmail = 'john.doe@example.com';

  String get userName => _userName;
  String get userEmail => _userEmail;

  void openSettings() {
    // Implement settings logic
    print('Opening settings');
  }

  void logout() {
    // Implement logout logic
    print('User logged out');
  }
}
