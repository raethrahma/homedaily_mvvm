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
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  fontSize: 20,
                ),
              ),
              backgroundColor: Colors.orange,
              centerTitle: true,
              elevation: 0,
              iconTheme: const IconThemeData(color: Colors.white),
            ),
            backgroundColor: Colors.grey[50],
            body: ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: viewModel.sellers.length,
              itemBuilder: (context, index) {
                final chat = viewModel.sellers[index];
                return Card(
                  color: Colors.white,
                  elevation: 2,
                  margin: const EdgeInsets.only(bottom: 12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: ListTile(
                    leading: CircleAvatar(
                      backgroundImage: NetworkImage(chat.image),
                      radius: 26,
                    ),
                    title: Text(
                      chat.name,
                      style: const TextStyle(
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                        color: Colors.black87,
                      ),
                    ),
                    subtitle: Text(
                      chat.lastMessage,
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        color: Colors.grey[600],
                        fontSize: 13,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    trailing: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          chat.time,
                          style: const TextStyle(
                            fontFamily: 'Poppins',
                            fontSize: 12,
                            color: Colors.grey,
                          ),
                        ),
                        if (chat.unread > 0)
                          Container(
                            margin: const EdgeInsets.only(top: 4),
                            padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                            decoration: BoxDecoration(
                              color: Colors.red,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Text(
                              chat.unread.toString(),
                              style: const TextStyle(
                                fontFamily: 'Poppins',
                                color: Colors.white,
                                fontSize: 10,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                      ],
                    ),
                    onTap: () {
                      Navigator.pushNamed(
                        context,
                        '/chat_detail',
                        arguments: chat,
                      );
                    },
                  ),
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