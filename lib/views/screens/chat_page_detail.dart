import 'package:flutter/material.dart';
import 'package:homedaily_mvvm/models/product.dart';
import 'package:homedaily_mvvm/viewmodels/chat_detail_viewmodel.dart';
import 'package:provider/provider.dart';

class ChatPageDetail extends StatelessWidget {
  final Product product;

  const ChatPageDetail({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => ChatDetailViewModel(product: product),
      child: Consumer<ChatDetailViewModel>(
        builder: (context, viewModel, child) {
          return Scaffold(
            appBar: AppBar(
              title: Text(
                product.title,
                style: const TextStyle(
                  fontFamily: 'CustomFont', // Menggunakan font kustom
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              backgroundColor: Colors.deepOrange,
            ),
            body: Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    padding: const EdgeInsets.all(16),
                    itemCount: viewModel.messages.length,
                    itemBuilder: (context, index) {
                      final message = viewModel.messages[index];
                      final isMe = message.isMe;
                      return Align(
                        alignment:
                            isMe ? Alignment.centerRight : Alignment.centerLeft,
                        child: Container(
                          margin: const EdgeInsets.symmetric(
                            vertical: 4,
                            horizontal: 8,
                          ),
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: isMe ? Colors.deepOrange : Colors.grey[300],
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Column(
                            crossAxisAlignment:
                                isMe
                                    ? CrossAxisAlignment.end
                                    : CrossAxisAlignment.start,
                            children: [
                              if (message.product != null)
                                Image.network(
                                  message.product!.image,
                                  width: 100,
                                  height: 100,
                                  fit: BoxFit.cover,
                                  errorBuilder:
                                      (context, error, stackTrace) =>
                                          const Icon(Icons.broken_image),
                                ),
                              if (message.text.isNotEmpty)
                                Text(
                                  message.text,
                                  style: TextStyle(
                                    fontFamily:
                                        'CustomFont', // Menggunakan font kustom
                                    color: isMe ? Colors.white : Colors.black,
                                  ),
                                ),
                              Text(
                                message.time,
                                style: TextStyle(
                                  fontFamily:
                                      'CustomFont', // Menggunakan font kustom
                                  fontSize: 12,
                                  color: isMe ? Colors.white70 : Colors.grey,
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(8),
                  color: Colors.white,
                  child: Row(
                    children: [
                      Expanded(
                        child: TextField(
                          controller: viewModel.messageController,
                          decoration: InputDecoration(
                            hintText: 'Ketik pesan...',
                            hintStyle: const TextStyle(
                              fontFamily:
                                  'CustomFont', // Menggunakan font kustom
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 8),
                      CircleAvatar(
                        backgroundColor: Colors.deepOrange,
                        child: IconButton(
                          icon: const Icon(Icons.send, color: Colors.white),
                          onPressed: viewModel.sendMessage,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
