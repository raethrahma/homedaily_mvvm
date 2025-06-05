import 'package:flutter/material.dart';
import 'package:homedaily_mvvm/models/product.dart';
import 'package:homedaily_mvvm/models/wishlist.dart';

class WishlistViewModel extends ChangeNotifier {
  final List<Wishlist> _wishlistItems = [
    Wishlist(
      id: 'w1',
      product: Product(
        id: '1',
        image: 'https://images.unsplash.com/photo-1533090481720-856c6e3c1fdc',
        title: 'Meja Minimalis',
        description: 'Meja kayu berkualitas tinggi',
        price: 'Rp 247.500',
        type: 'Produk',
        category: 'Produk',
      ),
      addedAt: DateTime.now().subtract(const Duration(days: 2)),
    ),
    Wishlist(
      id: 'w2',
      product: Product(
        id: '2',
        image: 'https://images.unsplash.com/photo-1586023492125-27b2c045efd7',
        title: 'Lampu Kuning Cantik',
        description: 'Lampu dekorasi estetik',
        price: 'Rp 150.000',
        type: 'Produk',
        category: 'Produk',
      ),
      addedAt: DateTime.now().subtract(const Duration(days: 1)),
    ),
    Wishlist(
      id: 'w3',
      product: Product(
        id: '3',
        image: 'https://images.unsplash.com/photo-1519125323398-675f0ddb6308',
        title: 'Laundry Kiloan',
        description: 'Layanan laundry kiloan, pakaian bersih dan wangi.',
        price: 'Rp 50.000',
        type: 'Jasa',
        category: 'Jasa',
      ),
      addedAt: DateTime.now(),
    ),
    Wishlist(
      id: 'w4',
      product: Product(
        id: '4',
        image: 'https://images.unsplash.com/photo-1519985176271-adb1088fa94c',
        title: 'Tukang Listrik',
        description: 'Perbaikan instalasi listrik rumah Anda, aman dan terpercaya.',
        price: 'Rp 200.000',
        type: 'Jasa',
        category: 'Jasa',
      ),
      addedAt: DateTime.now().subtract(const Duration(hours: 5)),
    ),
  ];

  List<Wishlist> get wishlistItems => List.unmodifiable(_wishlistItems);

  void addToWishlist(Product product) {
    if (!_wishlistItems.any((item) => item.product.id == product.id)) {
      _wishlistItems.add(
        Wishlist(
          id: DateTime.now().millisecondsSinceEpoch.toString(),
          product: product,
          addedAt: DateTime.now(),
        ),
      );
      notifyListeners();
    }
  }

  void removeFromWishlist(Product product) {
    _wishlistItems.removeWhere((item) => item.product.id == product.id);
    notifyListeners();
  }
}