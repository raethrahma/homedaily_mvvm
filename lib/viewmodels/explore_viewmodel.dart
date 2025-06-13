import 'package:flutter/material.dart';
import 'package:homedaily_mvvm/models/product.dart';
import 'package:homedaily_mvvm/services/api_service.dart';

class ExploreViewModel extends ChangeNotifier {
  final ApiService _apiService = ApiService();

  List<Product> _products = [];
  final List<String> _filters = ['All', 'Produk', 'Jasa'];
  String _selectedFilter = 'All';
  final List<String> _searchHistory = [];
  List<Product> _filteredProducts = [];
  bool _isLoading = false;
  String? _errorMessage;

  ExploreViewModel() {
    fetchProducts();
  }

  List<Product> get products => _products;
  List<Product> get filteredProducts => _filteredProducts;
  List<String> get filters => _filters;
  String get selectedFilter => _selectedFilter;
  List<String> get searchHistory => _searchHistory;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;

  Future<void> fetchProducts() async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();
    try {
      _products = await _apiService.fetchProducts();
      filterProducts('');
    } catch (e) {
      _errorMessage = e.toString();
      _products = [];
      _filteredProducts = [];
      notifyListeners();
    }
    _isLoading = false;
    notifyListeners();
  }

  void updateFilter(String filter) {
    if (_filters.contains(filter)) {
      _selectedFilter = filter;
      filterProducts('');
      notifyListeners();
    }
  }

  void filterProducts(String query) {
    List<Product> baseList;
    if (_selectedFilter == 'All') {
      baseList = _products;
    } else {
      baseList = _products
          .where((product) => product.categoryName.toLowerCase() == _selectedFilter.toLowerCase())
          .toList();
    }

    if (query.isEmpty) {
      _filteredProducts = baseList;
    } else {
      _filteredProducts = baseList
          .where((product) =>
              product.name.toLowerCase().contains(query.toLowerCase()) ||
              (product.description?.toLowerCase().contains(query.toLowerCase()) ?? false))
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