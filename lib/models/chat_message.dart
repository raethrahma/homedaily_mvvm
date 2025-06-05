import 'product.dart';

class ChatMessage {
  final String id; // ID unik pesan
  final String text;
  final String time;
  final bool isMe;
  final Product? product; // Produk/Jasa terkait pesan (opsional)

  ChatMessage({
    required this.id,
    required this.text,
    required this.time,
    required this.isMe,
    this.product,
  });

  // Hapus fromJson dan toJson karena tidak menggunakan API/JSON
}