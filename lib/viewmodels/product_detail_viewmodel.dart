import 'package:flutter/material.dart';
import 'package:homedaily_mvvm/models/product.dart';

class ProductDetailViewModel extends ChangeNotifier {
  final Product product;
  bool _isFavorite = false;

  ProductDetailViewModel({required this.product});

  bool get isFavorite => _isFavorite;

  String get type => product.type; // 'Produk' atau 'Jasa'
  String get category => product.category; // 'Produk' atau 'Jasa'

  void toggleFavorite() {
    _isFavorite = !_isFavorite;
    notifyListeners();
  }

  void shareProduct() {
    // Implementasi fitur share (misal: menggunakan package share_plus)
    // Share.share('Cek produk ini: ${product.title}');
    debugPrint('Sharing product: ${product.title}');
  }

  void addToCart() {
    // Implementasi logika tambah ke cart
    debugPrint('Added ${product.title} to cart');
    // notifyListeners(); // Jika ingin update state
  }
}