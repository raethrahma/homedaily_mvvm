import 'package:flutter/material.dart';
import 'package:homedaily_mvvm/models/cart_item.dart';

class CartViewModel extends ChangeNotifier {
  final List<CartItem> _items = [
    CartItem(
      id: '1',
      image: 'https://images.unsplash.com/photo-1533090481720-856c6e3c1fdc',
      title: 'Meja Minimalis',
      price: '247.50',
      quantity: 1,
      type: 'Produk', // Pastikan konsisten 'Produk'
    ),
    CartItem(
      id: '2',
      image: 'https://images.unsplash.com/photo-1586023492125-27b2c045efd7',
      title: 'Lampu Kuning Cantik',
      price: '247.50',
      quantity: 1,
      type: 'Produk', // Pastikan konsisten 'Produk'
    ),
    CartItem(
      id: '3',
      image: 'https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d',
      title: 'Cleaning Service',
      price: '500.00',
      quantity: 1,
      type: 'Jasa', // Pastikan konsisten 'Jasa'
    ),
  ];

  String _selectedFilter = 'Produk';
  final List<String> _filters = ['Produk', 'Jasa'];

  List<CartItem> get filteredCartItems {
    return _items.where((item) => item.type == _selectedFilter).toList();
  }

  List<String> get filters => _filters;
  String get selectedFilter => _selectedFilter;

  void updateFilter(String filter) {
    if (_filters.contains(filter)) {
      _selectedFilter = filter;
      notifyListeners();
    }
  }

  void removeFromCart(CartItem item) {
    _items.remove(item);
    notifyListeners();
  }

  void updateQuantity(CartItem item, int qty) {
    final index = _items.indexOf(item);
    if (index != -1 && qty > 0) {
      _items[index] = _items[index].copyWith(quantity: qty);
      notifyListeners();
    }
  }

  String getTotal() {
    double total = filteredCartItems.fold(
      0,
      (sum, item) => sum + (double.tryParse(item.price) ?? 0 * item.quantity),
    );
    return 'Rp ${total.toStringAsFixed(2)}';
  }
}