import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter/services.dart';
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

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(
    MultiProvider(
      providers: [ChangeNotifierProvider(create: (_) => AuthViewModel())],
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
      theme: _buildTheme(),
      debugShowCheckedModeBanner: false,
      initialRoute: '/login',
      onGenerateRoute: _generateRoute,
    );
  }

  // Extract theme building to separate method
  ThemeData _buildTheme() {
    const primaryColor = Colors.orange;
    const fontFamily = 'Poppins';
    final borderRadius = BorderRadius.circular(12);

    return ThemeData(
      colorScheme: const ColorScheme.light(primary: primaryColor),
      scaffoldBackgroundColor: Colors.grey[50],
      fontFamily: fontFamily,
      useMaterial3: true, // Enable Material 3
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
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
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
    );
  }

  // Extract route generation to separate method
  Route<dynamic>? _generateRoute(RouteSettings settings) {
    // Cache the arguments to avoid multiple access
    final args = settings.arguments;

    switch (settings.name) {
      case '/product_detail':
        if (args is! Product) return null;
        return _buildRoute(ProductDetailPage(product: args));

      case '/chat_detail':
        if (args is Chat) {
          return _buildRoute(ChatDetailPage(chat: args));
        } else if (args is Product) {
          return _buildRoute(
            ChatDetailPage(
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
        return null;

      case '/login':
        return _buildRoute(const LoginPage());
      case '/home':
        return _buildRoute(const HomePage());
      case '/wishlist':
        return _buildRoute(const WishlistPage());
      case '/transaction':
        return _buildRoute(const TransactionPage());
      case '/explore':
        return _buildRoute(const ExplorePage());
      case '/cart':
        return _buildRoute(const CartPage());
      case '/profile':
        return _buildRoute(const ProfilePage());
      case '/chat_list':
        return _buildRoute(const ChatListPage());
      default:
        return null;
    }
  }

  // Helper method to create routes with consistent transitions
  PageRoute _buildRoute(Widget page) {
    return MaterialPageRoute(builder: (_) => page);
  }
}
