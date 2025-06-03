import 'product.dart';

class ChatMessage {
  final String id; // Tambahkan ID untuk identifikasi unik
  final String text;
  final String time;
  final bool isMe;
  final Product? product;

  ChatMessage({
    required this.id,
    required this.text,
    required this.time,
    required this.isMe,
    this.product,
  });

  factory ChatMessage.fromJson(Map<String, dynamic> json) {
    return ChatMessage(
      id: json['id'] as String,
      text: json['text'] as String,
      time: json['time'] as String,
      isMe: json['isMe'] as bool,
      product:
          json['product'] != null
              ? Product.fromJson(json['product'] as Map<String, dynamic>)
              : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'text': text,
      'time': time,
      'isMe': isMe,
      'product': product?.toJson(),
    };
  }
}
