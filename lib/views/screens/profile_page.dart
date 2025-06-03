import 'package:flutter/material.dart';
import 'package:homedaily_mvvm/viewmodels/profile_viewmodel.dart';
import 'package:provider/provider.dart';

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
                  fontFamily: 'CustomFont', // Menggunakan font kustom
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
                                fontFamily:
                                    'CustomFont', // Menggunakan font kustom
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                              ),
                            ),
                            Text(
                              viewModel.userEmail,
                              style: TextStyle(
                                fontFamily:
                                    'CustomFont', // Menggunakan font kustom
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
                        fontFamily: 'CustomFont', // Menggunakan font kustom
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
                        fontFamily: 'CustomFont', // Menggunakan font kustom
                      ),
                    ),
                    onTap: viewModel.openSettings,
                  ),
                  ListTile(
                    leading: const Icon(Icons.logout, color: Colors.deepOrange),
                    title: const Text(
                      'Logout',
                      style: TextStyle(
                        fontFamily: 'CustomFont', // Menggunakan font kustom
                      ),
                    ),
                    onTap: () {
                      Navigator.pushReplacementNamed(context, '/login');
                    },
                  ),
                ],
              ),
            ),
            bottomNavigationBar: BottomNavigationBar(
              type: BottomNavigationBarType.fixed,
              items: const [
                BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
                BottomNavigationBarItem(
                  icon: Icon(Icons.search),
                  label: 'Explore',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.receipt_long),
                  label: 'Transaksi',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.shopping_cart),
                  label: 'Cart',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.favorite_border),
                  label: 'Wishlist',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.person),
                  label: 'Profile',
                ),
              ],
              currentIndex: 5,
              selectedItemColor: Colors.deepOrange,
              unselectedItemColor: Colors.grey,
              showUnselectedLabels: true,
              onTap: (index) {
                switch (index) {
                  case 0:
                    Navigator.pushNamed(context, '/home');
                    break;
                  case 1:
                    Navigator.pushNamed(context, '/explore');
                    break;
                  case 2:
                    Navigator.pushNamed(context, '/transaction');
                    break;
                  case 3:
                    Navigator.pushNamed(context, '/cart');
                    break;
                  case 4:
                    Navigator.pushNamed(context, '/wishlist');
                    break;
                  case 5:
                    break;
                }
              },
            ),
          );
        },
      ),
    );
  }
}
