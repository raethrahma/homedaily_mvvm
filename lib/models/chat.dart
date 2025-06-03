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

  factory Chat.fromJson(Map<String, dynamic> json) {
    return Chat(
      id: json['id'] as String,
      name: json['name'] as String,
      image: json['image'] as String,
      lastMessage: json['lastMessage'] as String,
      time: json['time'] as String,
      unread: json['unread'] as int,
      product: Product.fromJson(json['product'] as Map<String, dynamic>),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'image': image,
      'lastMessage': lastMessage,
      'time': time,
      'unread': unread,
      'product': product.toJson(),
    };
  }
}
