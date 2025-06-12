import 'package:flutter/material.dart';
import 'package:homedaily_mvvm/models/product.dart';

class ExploreViewModel extends ChangeNotifier {
  final List<Product> _products = [
    Product(
      id: 1,
      name: 'Meja Minimalis',
      description: 'Meja kayu berkualitas tinggi',
      price: '247.50',
      stock: 5,
      categoryName: 'Produk',
      images: ['https://images.unsplash.com/photo-1533090481720-856c6e3c1fdc'],
    ),
    Product(
      id: 2,
      name: 'Lampu Kuning Cantik',
      description: 'Lampu dekorasi estetik',
      price: '247.50',
      stock: 10,
      categoryName: 'Produk',
      images: ['https://images.unsplash.com/photo-1586023492125-27b2c045efd7'],
    ),
    Product(
      id: 3,
      name: 'Cleaning Service',
      description: 'Jasa cleaning service profesional',
      price: '500.00',
      stock: 0,
      categoryName: 'Jasa',
      images: ['https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d'],
    ),
  ];

  final List<String> _filters = ['All', 'Produk', 'Jasa'];
  String _selectedFilter = 'All';
  final List<String> _searchHistory = [];
  List<Product> _filteredProducts = [];

  ExploreViewModel() {
    _filteredProducts = _products;
  }

  List<Product> get products => _products;
  List<Product> get filteredProducts => _filteredProducts;
  List<String> get filters => _filters;
  String get selectedFilter => _selectedFilter;
  List<String> get searchHistory => _searchHistory;

  void updateFilter(String filter) {
    if (_filters.contains(filter)) {
      _selectedFilter = filter;
      filterProducts('');
      notifyListeners();
    }
  }

  void filterProducts(String query) {
    if (query.isEmpty) {
      if (_selectedFilter == 'All') {
        _filteredProducts = _products;
      } else {
        _filteredProducts = _products
            .where((product) => product.categoryName == _selectedFilter)
            .toList();
      }
    } else {
      _filteredProducts = _products
          .where((product) =>
              product.name.toLowerCase().contains(query.toLowerCase()) ||
              (product.description?.toLowerCase().contains(query.toLowerCase()) ??
                  false))
          .toList();
    }
    notifyListeners();
  }

  void addToSearchHistory(String query) {
    if (query.isNotEmpty && !_searchHistory.contains(query)) {
      _searchHistory.add(query);
      notifyListeners();
    }
  }

  void removeSearchHistory(String query) {
    _searchHistory.remove(query);
    notifyListeners();
  }
}
