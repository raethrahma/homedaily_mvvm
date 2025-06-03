class CartItem {
  final String id; // Tambahkan ID untuk identifikasi unik
  final String image;
  final String title;
  final String price;
  final int quantity;

  CartItem({
    required this.id,
    required this.image,
    required this.title,
    required this.price,
    required this.quantity,
  });

  factory CartItem.fromJson(Map<String, dynamic> json) {
    return CartItem(
      id: json['id'] as String,
      image: json['image'] as String,
      title: json['title'] as String,
      price: json['price'] as String,
      quantity: json['quantity'] as int,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'image': image,
      'title': title,
      'price': price,
      'quantity': quantity,
    };
  }
}
