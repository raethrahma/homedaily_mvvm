import 'package:flutter/material.dart';
import 'package:homedaily_mvvm/models/product.dart';

class ExploreViewModel extends ChangeNotifier {
  final List<Product> _products = [
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

  final List<String> _filters = ['All', 'Furniture', 'Lampu', 'Dekorasi'];
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
        _filteredProducts =
            _products
                .where(
                  (product) => product.description.toLowerCase().contains(
                    _selectedFilter.toLowerCase(),
                  ),
                )
                .toList();
      }
    } else {
      _filteredProducts =
          _products
              .where(
                (product) =>
                    product.title.toLowerCase().contains(query.toLowerCase()),
              )
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
