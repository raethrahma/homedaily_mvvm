import 'product.dart';

class Wishlist {
  final String id;
  final Product product;
  final DateTime addedAt;

  Wishlist({
    required this.id,
    required this.product,
    required this.addedAt,
  });
}