class Product {
  final String id;
  final String image;
  final String title;
  final String description;
  final String price;
  final String type; // 'Produk' atau 'Jasa'
  final String category; // 'Produk' atau 'Jasa' saja

  Product({
    required this.id,
    required this.image,
    required this.title,
    required this.description,
    required this.price,
    required this.type,
    required this.category,
  });

  Product copyWith({
    String? id,
    String? image,
    String? title,
    String? description,
    String? price,
    String? type,
    String? category,
  }) {
    return Product(
      id: id ?? this.id,
      image: image ?? this.image,
      title: title ?? this.title,
      description: description ?? this.description,
      price: price ?? this.price,
      type: type ?? this.type,
      category: category ?? this.category,
    );
  }

  // Hapus factory fromJson dan toJson jika tidak menggunakan API/JSON
}