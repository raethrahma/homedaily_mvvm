import 'package:flutter/material.dart';
import 'package:homedaily_mvvm/models/cart_item.dart';

class CartViewModel extends ChangeNotifier {
  // Use const for static data
  static const String FILTER_PRODUK = 'Produk';
  static const String FILTER_JASA = 'Jasa';

  final List<CartItem> _items = [];
  String _selectedFilter = FILTER_PRODUK;
  final List<String> _filters = const [FILTER_PRODUK, FILTER_JASA];

  // Lazy loading of filtered items
  late final filteredCartItems =
      _items.where((item) => item.type == _selectedFilter).toList();

  List<String> get filters => _filters;
  String get selectedFilter => _selectedFilter;

  // Optimize calculations
  double _total = 0;
  bool _isDirty = true;

  String getTotal() {
    if (_isDirty) {
      _total = filteredCartItems.fold(
        0,
        (sum, item) =>
            sum + ((double.tryParse(item.price) ?? 0) * item.quantity),
      );
      _isDirty = false;
    }
    return 'Rp ${_total.toStringAsFixed(2)}';
  }

  void updateFilter(String filter) {
    if (_filters.contains(filter) && _selectedFilter != filter) {
      _selectedFilter = filter;
      _isDirty = true;
      notifyListeners();
    }
  }

  void removeFromCart(CartItem item) {
    _items.remove(item);
    _isDirty = true;
    notifyListeners();
  }

  void updateQuantity(CartItem item, int qty) {
    if (qty > 0) {
      final index = _items.indexOf(item);
      if (index != -1) {
        _items[index] = _items[index].copyWith(quantity: qty);
        _isDirty = true;
        notifyListeners();
      }
    }
  }
}
