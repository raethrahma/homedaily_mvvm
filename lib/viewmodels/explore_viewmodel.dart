import 'package:flutter/material.dart';
import 'package:homedaily_mvvm/models/product.dart';

class ExploreViewModel extends ChangeNotifier {
  final List<Product> _products = [
    Product(
      id: '1',
      image: 'https://images.unsplash.com/photo-1533090481720-856c6e3c1fdc',
      title: 'Meja Minimalis',
      description: 'Meja kayu berkualitas tinggi',
      price: '247.50',
      type: 'Produk',
      category: 'Produk', // Sesuaikan kategori hanya 'Produk' atau 'Jasa'
    ),
    Product(
      id: '2',
      image: 'https://images.unsplash.com/photo-1586023492125-27b2c045efd7',
      title: 'Lampu Kuning Cantik',
      description: 'Lampu dekorasi estetik',
      price: '247.50',
      type: 'Produk',
      category: 'Produk',
    ),
    Product(
      id: '3',
      image: 'https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d',
      title: 'Cleaning Service',
      description: 'Jasa cleaning service profesional',
      price: '500.00',
      type: 'Jasa',
      category: 'Jasa',
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
        _filteredProducts =
            _products.where((product) => product.category == _selectedFilter).toList();
      }
    } else {
      _filteredProducts =
          _products.where((product) =>
              product.title.toLowerCase().contains(query.toLowerCase()) ||
              product.description.toLowerCase().contains(query.toLowerCase())
          ).toList();
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