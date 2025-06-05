import 'package:flutter/material.dart';
import 'package:homedaily_mvvm/models/chat_message.dart';
import 'package:homedaily_mvvm/models/product.dart';
import 'package:intl/intl.dart';

class ChatDetailViewModel extends ChangeNotifier {
  final Product product;
  final TextEditingController _messageController = TextEditingController();
  final List<ChatMessage> _messages = [];

  ChatDetailViewModel({required this.product}) {
    // Pesan awal: info produk
    _messages.add(
      ChatMessage(
        id: '1',
        text: 'Produk: ${product.title}\nHarga: Rp ${product.price}',
        time: DateFormat('HH:mm').format(DateTime.now()),
        isMe: false,
        product: product,
      ),
    );
    // Contoh pesan user
    _messages.add(
      ChatMessage(
        id: '2',
        text: 'Apakah produk ini ready?',
        time: DateFormat('HH:mm').format(DateTime.now()),
        isMe: true,
      ),
    );
    // Contoh balasan
    _messages.add(
      ChatMessage(
        id: '3',
        text: 'Iya, produk ${product.title} masih tersedia.',
        time: DateFormat('HH:mm').format(DateTime.now()),
        isMe: false,
      ),
    );
  }

  TextEditingController get messageController => _messageController;
  List<ChatMessage> get messages => _messages;

  void sendMessage() {
    final text = _messageController.text.trim();
    if (text.isNotEmpty) {
      _messages.add(
        ChatMessage(
          id: DateTime.now().millisecondsSinceEpoch.toString(),
          text: text,
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