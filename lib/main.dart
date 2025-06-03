import 'package:flutter/material.dart';
import 'package:homedaily_mvvm/views/screens/login_page.dart';
import 'package:homedaily_mvvm/views/screens/home_page.dart';
import 'package:homedaily_mvvm/views/screens/wishlist_page.dart';
import 'package:homedaily_mvvm/views/screens/transaction_page.dart';
import 'package:homedaily_mvvm/views/screens/explore_page.dart';
import 'package:homedaily_mvvm/views/screens/cart_page.dart';
import 'package:homedaily_mvvm/views/screens/profile_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'HomeDaily',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepOrange),
        fontFamily: 'CustomFont', // Menggunakan font kustom
      ),
      debugShowCheckedModeBanner: false,
      initialRoute: '/login',
      routes: {
        '/login': (context) => const LoginPage(),
        '/home': (context) => const HomePage(),
        '/wishlist': (context) => const WishlistPage(),
        '/transaction': (context) => const TransactionPage(),
        '/explore': (context) => const ExplorePage(),
        '/cart': (context) => const CartPage(),
        '/profile': (context) => const ProfilePage(),
      },
    );
  }
}
