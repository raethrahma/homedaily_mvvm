import 'package:flutter/material.dart';
import 'package:homedaily_mvvm/models/product.dart';

class ProductDetailViewModel extends ChangeNotifier {
  final Product product;
  bool _isFavorite = false;

  ProductDetailViewModel({required this.product});

  bool get isFavorite => _isFavorite;

  // Getter label kategori, konsisten dengan HomeViewModel
  String get typeLabel => product.type == 'jasa' ? 'Jasa' : 'Produk';
  String get category => product.categoryName;

  void toggleFavorite() {
    _isFavorite = !_isFavorite;
    notifyListeners();
  }

  void shareProduct() {
    debugPrint('Sharing product: ${product.name}');
  }

  void addToCart() {
    debugPrint('Added ${product.name} to cart');
  }
}