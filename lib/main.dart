import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter/services.dart';
import 'services/token_manager.dart'; // Add this import
import 'package:homedaily_mvvm/views/screens/login_page.dart';
import 'package:homedaily_mvvm/views/screens/home_page.dart';
import 'package:homedaily_mvvm/views/screens/wishlist_page.dart';
import 'package:homedaily_mvvm/views/screens/transaction_page.dart';
import 'package:homedaily_mvvm/views/screens/explore_page.dart';
import 'package:homedaily_mvvm/views/screens/cart_page.dart';
import 'package:homedaily_mvvm/views/screens/profile_page.dart';
import 'package:homedaily_mvvm/views/screens/detail_product_page.dart';
import 'package:homedaily_mvvm/views/screens/chat_list_page.dart';
import 'package:homedaily_mvvm/views/screens/chat_page_detail.dart';
import 'package:homedaily_mvvm/models/product.dart';
import 'package:homedaily_mvvm/models/chat.dart';
import 'package:homedaily_mvvm/viewmodels/auth_viewmodel.dart';
import 'package:homedaily_mvvm/viewmodels/profile_viewmodel.dart';
import 'package:homedaily_mvvm/views/screens/address_management_page.dart';


void main() {
  WidgetsFlutterBinding.ensureInitialized();
  
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthViewModel()),
        ChangeNotifierProvider(create: (_) => ProfileViewModel()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'HomeDaily',
      theme: ThemeData(
        primarySwatch: Colors.orange,
        fontFamily: 'Poppins',
      ),
      initialRoute: '/login',  // Always start with login
      routes: {
        '/login': (context) => const LoginPage(),
        '/home': (context) => const HomePage(),
        '/profile': (context) => const ProfilePage(),
        '/address': (context) => const AddressManagementPage(), // Add this route
      },
    );
  }
}

