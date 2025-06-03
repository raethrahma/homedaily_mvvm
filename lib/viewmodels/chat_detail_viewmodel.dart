import 'package:flutter/material.dart';
import 'package:homedaily_mvvm/models/chat_message.dart';
import 'package:homedaily_mvvm/models/product.dart';
import 'package:intl/intl.dart';

class ChatDetailViewModel extends ChangeNotifier {
  final Product product;
  final TextEditingController _messageController = TextEditingController();
  final List<ChatMessage> _messages = [];

  ChatDetailViewModel({required this.product}) {
    _messages.add(
      ChatMessage(
        id: '1', // Tambahkan ID unik untuk setiap pesan
        text: '',
        time: '00:00',
        isMe: true,
        product: product,
      ),
    );
    _messages.add(
      ChatMessage(
        id: '2', // Tambahkan ID unik untuk setiap pesan
        text: 'Ini produknya ya?',
        time: '00:49',
        isMe: true,
      ),
    );
    _messages.add(
      ChatMessage(
        id: '3', // Tambahkan ID unik untuk setiap pesan
        text: 'Iya, produk ${product.title} harga Rp.1000',
        time: '01:52',
        isMe: false,
      ),
    );
  }

  TextEditingController get messageController => _messageController;
  List<ChatMessage> get messages => _messages;

  void sendMessage() {
    if (_messageController.text.isNotEmpty) {
      _messages.add(
        ChatMessage(
          id:
              DateTime.now().millisecondsSinceEpoch
                  .toString(), // ID unik berdasarkan timestamp
          text: _messageController.text,
          time: DateFormat('HH:mm').format(DateTime.now()),
          isMe: true,
        ),
      );
      _messageController.clear();
      notifyListeners();
    }
  }

  @override
  void dispose() {
    _messageController.dispose();
    super.dispose();
  }
}
