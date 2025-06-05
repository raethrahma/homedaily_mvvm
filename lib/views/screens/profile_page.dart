import 'package:flutter/material.dart';
import 'package:homedaily_mvvm/viewmodels/profile_viewmodel.dart';
import 'package:provider/provider.dart';
import 'package:homedaily_mvvm/views/screens/widgets/custom_bottom_navbar.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => ProfileViewModel(),
      child: Consumer<ProfileViewModel>(
        builder: (context, viewModel, child) {
          return Scaffold(
            appBar: AppBar(
              title: const Text(
                'Profile',
                style: TextStyle(
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              backgroundColor: Colors.deepOrange,
            ),
            body: SingleChildScrollView(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(16),
                    child: Row(
                      children: [
                        const CircleAvatar(
                          radius: 50,
                          backgroundImage: NetworkImage(
                            'https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d',
                          ),
                        ),
                        const SizedBox(width: 16),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              viewModel.userName,
                              style: const TextStyle(
                                fontFamily: 'Poppins',
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                              ),
                            ),
                            Text(
                              viewModel.userEmail,
                              style: TextStyle(
                                fontFamily: 'Poppins',
                                color: Colors.grey[600],
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const Divider(),
                  ListTile(
                    leading: const Icon(
                      Icons.location_on,
                      color: Colors.deepOrange,
                    ),
                    title: const Text(
                      'Manage Addresses',
                      style: TextStyle(
                        fontFamily: 'Poppins',
                      ),
                    ),
                    onTap: () {
                      Navigator.pushNamed(context, '/address_management');
                    },
                  ),
                  ListTile(
                    leading: const Icon(
                      Icons.settings,
                      color: Colors.deepOrange,
                    ),
                    title: const Text(
                      'Settings',
                      style: TextStyle(
                        fontFamily: 'Poppins',
                      ),
                    ),
                    onTap: viewModel.openSettings,
                  ),
                  ListTile(
                    leading: const Icon(Icons.logout, color: Colors.deepOrange),
                    title: const Text(
                      'Logout',
                      style: TextStyle(
                        fontFamily: 'Poppins',
                      ),
                    ),
                    onTap: () {
                      Navigator.pushReplacementNamed(context, '/login');
                    },
                  ),
                ],
              ),
            ),
            bottomNavigationBar: CustomBottomNavBar(currentIndex: 5),
          );
        },
      ),
    );
  }
}