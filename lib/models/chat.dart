import 'product.dart';

class Chat {
  final String id;
  final String name;
  final String image;
  final String lastMessage;
  final String time;
  final int unread;
  final Product product;

  Chat({
    required this.id,
    required this.name,
    required this.image,
    required this.lastMessage,
    required this.time,
    required this.unread,
    required this.product,
  });

  // Hapus fromJson dan toJson karena tidak menggunakan API/JSON
}