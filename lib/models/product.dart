class Product {
  final int id;
  final String name;
  final String? description;
  final String price;
  final int stock;
  final String categoryName;
  final List<String> images;

  Product({
    required this.id,
    required this.name,
    this.description,
    required this.price,
    required this.stock,
    required this.categoryName,
    required this.images,
  });

  // Getter untuk memudahkan filter jasa/produk
  bool get isService => categoryName.toLowerCase() == 'jasa';
  String get type => isService ? 'jasa' : 'produk';

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'] ?? 0,
      name: json['name'] ?? 'Unknown',
      description: json['description'],
      price: json['price'] ?? '0.0',
      stock: json['stock'] ?? 0,
      categoryName: json['category']?['name'] ?? 'Unknown',
      images: (json['images'] as List<dynamic>)
          .map((image) => image['path'] as String)
          .toList(),
    );
  }
}