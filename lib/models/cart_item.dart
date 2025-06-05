class CartItem {
  final String id;
  final String image;
  final String title;
  final String price;
  final int quantity;
  final String type; // 'Produk' atau 'Jasa'

  CartItem({
    required this.id,
    required this.image,
    required this.title,
    required this.price,
    required this.quantity,
    required this.type,
  });

  CartItem copyWith({
    String? id,
    String? image,
    String? title,
    String? price,
    int? quantity,
    String? type,
  }) {
    return CartItem(
      id: id ?? this.id,
      image: image ?? this.image,
      title: title ?? this.title,
      price: price ?? this.price,
      quantity: quantity ?? this.quantity,
      type: type ?? this.type,
    );
  }
}