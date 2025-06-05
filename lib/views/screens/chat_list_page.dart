import 'package:flutter/material.dart';
import 'package:homedaily_mvvm/viewmodels/chat_viewmodel.dart';
import 'package:provider/provider.dart';
import 'package:homedaily_mvvm/views/screens/widgets/custom_bottom_navbar.dart';

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
            bottomNavigationBar: CustomBottomNavBar(currentIndex: 0),
          );
        },
      ),
    );
  }
}
