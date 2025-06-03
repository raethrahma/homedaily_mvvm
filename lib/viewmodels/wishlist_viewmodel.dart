import 'package:flutter/material.dart';
import 'package:homedaily_mvvm/models/product.dart';

class WishlistViewModel extends ChangeNotifier {
  final List<Product> _wishlistItems = [
    Product(
      id: '1', // Tambahkan ID unik untuk setiap produk
      image: 'https://images.unsplash.com/photo-1533090481720-856c6e3c1fdc',
      title: 'Meja Minimalis',
      description: 'Meja kayu berkualitas tinggi',
      price: 'Rp.247.50',
    ),
    Product(
      id: '2', // Tambahkan ID unik untuk setiap produk
      image: 'https://images.unsplash.com/photo-1586023492125-27b2c045efd7',
      title: 'Lampu Kuning Cantik',
      description: 'Lampu dekorasi estetik',
      price: 'Rp.247.50',
    ),
  ];

  List<Product> get wishlistItems => _wishlistItems;

  void addToWishlist(Product product) {
    if (!_wishlistItems.any((item) => item.id == product.id)) {
      _wishlistItems.add(product);
      notifyListeners();
    }
  }

  void removeFromWishlist(Product product) {
    _wishlistItems.removeWhere((item) => item.id == product.id);
    notifyListeners();
  }
}
