import 'package:flutter/material.dart';
import 'package:homedaily_mvvm/viewmodels/chat_viewmodel.dart';
import 'package:provider/provider.dart';

class ChatListPage extends StatelessWidget {
  const ChatListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => ChatViewModel(),
      child: Consumer<ChatViewModel>(
        builder: (context, viewModel, child) {
          return Scaffold(
            appBar: AppBar(
              title: const Text(
                'Chats',
                style: TextStyle(
                  fontFamily: 'CustomFont', // Menggunakan font kustom
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              backgroundColor: Colors.deepOrange,
            ),
            body: ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: viewModel.sellers.length,
              itemBuilder: (context, index) {
                final chat = viewModel.sellers[index];
                return ListTile(
                  leading: CircleAvatar(
                    backgroundImage: NetworkImage(chat.image),
                  ),
                  title: Text(
                    chat.name,
                    style: const TextStyle(
                      fontFamily: 'CustomFont', // Menggunakan font kustom
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  subtitle: Text(
                    chat.lastMessage,
                    style: TextStyle(
                      fontFamily: 'CustomFont', // Menggunakan font kustom
                      color: Colors.grey[600],
                    ),
                  ),
                  trailing: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        chat.time,
                        style: const TextStyle(
                          fontFamily: 'CustomFont', // Menggunakan font kustom
                          fontSize: 12,
                        ),
                      ),
                      if (chat.unread > 0)
                        CircleAvatar(
                          backgroundColor: Colors.red,
                          radius: 10,
                          child: Text(
                            chat.unread.toString(),
                            style: const TextStyle(
                              fontFamily:
                                  'CustomFont', // Menggunakan font kustom
                              color: Colors.white,
                              fontSize: 10,
                            ),
                          ),
                        ),
                    ],
                  ),
                  onTap: () {
                    Navigator.pushNamed(
                      context,
                      '/chat_detail',
                      arguments: chat.product.toJson(),
                    );
                  },
                );
              },
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
                  icon: Icon(Icons.person_outline),
                  label: 'Profile',
                ),
              ],
              currentIndex: 0,
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
                    Navigator.pushNamed(context, '/profile');
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
