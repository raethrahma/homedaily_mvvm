import 'package:flutter/material.dart';
import 'package:homedaily_mvvm/models/cart_item.dart';

class CartViewModel extends ChangeNotifier {
  List<CartItem> _items = [
    CartItem(
      id: '1',
      image: 'https://images.unsplash.com/photo-1533090481720-856c6e3c1fdc',
      title: 'Meja Minimalis',
      price: '247.50',
      quantity: 1,
    ),
    CartItem(
      id: '2',
      image: 'https://images.unsplash.com/photo-1586023492125-27b2c045efd7',
      title: 'Lampu Kuning Cantik',
      price: '247.50',
      quantity: 1,
    ),
  ];

  String _selectedFilter = 'All';
  List<String> _filters = ['All', 'Furniture', 'Lampu', 'Dekorasi'];
  List<CartItem> _filteredItems = [];

  CartViewModel() {
    _filteredItems = _items;
  }

  List<CartItem> get filteredItems => _filteredItems;
  List<String> get filters => _filters;
  String get selectedFilter => _selectedFilter;

  void updateFilter(String filter) {
    _selectedFilter = filter;
    if (filter == 'All') {
      _filteredItems = _items;
    } else {
      _filteredItems =
          _items
              .where(
                (item) =>
                    item.title.toLowerCase().contains(filter.toLowerCase()),
              )
              .toList();
    }
    notifyListeners();
  }

  String getTotal() {
    double total = _filteredItems.fold(
      0,
      (sum, item) => sum + (double.parse(item.price) * item.quantity),
    );
    return 'Rp ${total.toStringAsFixed(2)}';
  }
}
