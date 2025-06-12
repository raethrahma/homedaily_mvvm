import 'package:flutter/material.dart';
import 'package:homedaily_mvvm/models/chat.dart';
import 'package:homedaily_mvvm/models/product.dart';

class ChatViewModel extends ChangeNotifier {
  final List<Chat> _sellers = [
    Chat(
      id: '1',
      name: 'Seller A',
      image: 'https://via.placeholder.com/150',
      lastMessage: 'Hello, how can I help you?',
      time: '10:30 AM',
      unread: 2,
      product: Product(
        id: 101,
        name: 'Meja Minimalis',
        description: 'Meja kayu berkualitas tinggi',
        price: 'Rp 247.500',
        stock: 5,
        categoryName: 'Produk',
        images: ['https://via.placeholder.com/150'],
      ),
    ),
    Chat(
      id: '2',
      name: 'Seller B',
      image: 'https://via.placeholder.com/150',
      lastMessage: 'Thank you for your purchase!',
      time: 'Yesterday',
      unread: 0,
      product: Product(
        id: 102,
        name: 'Cleaning Service',
        description: 'Jasa cleaning service profesional.',
        price: 'Rp 500.000',
        stock: 0,
        categoryName: 'Jasa',
        images: ['https://via.placeholder.com/150'],
      ),
    ),
  ];

  List<Chat> get sellers => _sellers;
}
