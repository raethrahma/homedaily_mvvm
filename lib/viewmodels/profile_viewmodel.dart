import 'package:flutter/material.dart';

class ProfileViewModel extends ChangeNotifier {
  String userName = 'Nama User';
  String userEmail = 'user@email.com';
  String userPhoto =
      'https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d';

  // Contoh method untuk membuka pengaturan
  void openSettings() {
    // Implementasi logika membuka pengaturan profil
    // Misal: Navigasi ke halaman pengaturan
  }

  // Contoh method untuk logout
  void logout(BuildContext context) {
    // Implementasi logika logout user
    // Misal: Navigator.pushReplacementNamed(context, '/login');
  }

  // Contoh method untuk update profil
  void updateProfile({String? name, String? email, String? photo}) {
    if (name != null) userName = name;
    if (email != null) userEmail = email;
    if (photo != null) userPhoto = photo;
    notifyListeners();
  }
}