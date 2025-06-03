import 'package:flutter/material.dart';
import 'package:homedaily_mvvm/models/product.dart';

class ProductDetailViewModel extends ChangeNotifier {
  final Product product;
  bool _isFavorite = false;

  ProductDetailViewModel({required this.product});

  bool get isFavorite => _isFavorite;

  void toggleFavorite() {
    _isFavorite = !_isFavorite;
    notifyListeners();
  }

  void shareProduct() {
    // Implement share functionality
    print('Sharing product: ${product.title}');
  }

  void addToCart() {
    // Implement add to cart logic
    print('Added ${product.title} to cart');
  }
}
