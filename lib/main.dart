import 'package:flutter/material.dart';
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
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.orange),
        scaffoldBackgroundColor: Colors.grey[50],
        fontFamily: 'Poppins',
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.orange,
          centerTitle: true,
          elevation: 0,
          titleTextStyle: TextStyle(
            fontFamily: 'Poppins',
            fontWeight: FontWeight.bold,
            color: Colors.white,
            fontSize: 20,
          ),
          iconTheme: IconThemeData(color: Colors.white),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.orange,
            foregroundColor: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(12)),
            ),
            textStyle: const TextStyle(
              fontFamily: 'Poppins',
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        outlinedButtonTheme: OutlinedButtonThemeData(
          style: OutlinedButton.styleFrom(
            side: const BorderSide(color: Colors.orange),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(12)),
            ),
            textStyle: const TextStyle(
              fontFamily: 'Poppins',
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        inputDecorationTheme: InputDecorationTheme(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(12)),
          ),
          filled: true,
          fillColor: Colors.grey[50],
          labelStyle: const TextStyle(fontFamily: 'Poppins'),
        ),
        cardTheme: CardThemeData(
          color: Colors.white,
          elevation: 2,
          surfaceTintColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        bottomNavigationBarTheme: const BottomNavigationBarThemeData(
          backgroundColor: Colors.white,
          selectedItemColor: Colors.orange,
          unselectedItemColor: Colors.grey,
          selectedLabelStyle: TextStyle(
            fontFamily: 'Poppins',
            fontWeight: FontWeight.bold,
          ),
          unselectedLabelStyle: TextStyle(
            fontFamily: 'Poppins',
            fontWeight: FontWeight.normal,
          ),
          showUnselectedLabels: true,
          type: BottomNavigationBarType.fixed,
        ),
      ),
      debugShowCheckedModeBanner: false,
      initialRoute: '/login',
      onGenerateRoute: (settings) {
        // Route untuk detail produk
        if (settings.name == '/product_detail') {
          final product = settings.arguments as Product;
          return MaterialPageRoute(
            builder: (_) => ProductDetailPage(product: product),
          );
        }
        // Route untuk detail chat
        if (settings.name == '/chat_detail') {
          final args = settings.arguments;
          if (args is Chat) {
            return MaterialPageRoute(
              builder: (_) => ChatDetailPage(chat: args),
            );
          } else if (args is Product) {
            // Jika dari detail produk langsung ke chat, buat Chat dummy dari Product
            return MaterialPageRoute(
              builder: (_) => ChatDetailPage(
                chat: Chat(
                  id: args.id,
                  name: args.title,
                  image: args.image,
                  lastMessage: '',
                  time: '',
                  unread: 0,
                  product: args,
                ),
              ),
            );
          }
        }
        // Route lain
        switch (settings.name) {
          case '/login':
            return MaterialPageRoute(builder: (_) => const LoginPage());
          case '/home':
            return MaterialPageRoute(builder: (_) => const HomePage());
          case '/wishlist':
            return MaterialPageRoute(builder: (_) => const WishlistPage());
          case '/transaction':
            return MaterialPageRoute(builder: (_) => const TransactionPage());
          case '/explore':
            return MaterialPageRoute(builder: (_) => const ExplorePage());
          case '/cart':
            return MaterialPageRoute(builder: (_) => const CartPage());
          case '/profile':
            return MaterialPageRoute(builder: (_) => const ProfilePage());
          case '/chat_list':
            return MaterialPageRoute(builder: (_) => const ChatListPage());
          default:
            return null;
        }
      },
    );
  }
}