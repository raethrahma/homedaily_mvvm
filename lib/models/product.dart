class Product {
  final String id; // Tambahkan ID untuk identifikasi unik
  final String image;
  final String title;
  final String description;
  final String price;

  Product({
    required this.id,
    required this.image,
    required this.title,
    required this.description,
    required this.price,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'] as String,
      image: json['image'] as String,
      title: json['title'] as String,
      description: json['description'] as String,
      price: json['price'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'image': image,
      'title': title,
      'description': description,
      'price': price,
    };
  }
}
