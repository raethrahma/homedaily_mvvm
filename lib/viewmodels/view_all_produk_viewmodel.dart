import 'package:flutter/material.dart';
import 'package:homedaily_mvvm/models/product.dart';
import 'package:homedaily_mvvm/services/api_service.dart';

class ViewAllProdukViewModel extends ChangeNotifier {
  final ApiService _apiService = ApiService();

  List<Product> _products = []; // Semua produk dari API
  bool _isLoading = false;
  String _errorMessage = '';

  // Getter untuk semua produk (tanpa filter)
  List<Product> get allProducts => _products;

  bool get isLoading => _isLoading;
  String get errorMessage => _errorMessage;

  Future<void> fetchProducts() async {
    _isLoading = true;
    notifyListeners();

    try {
      _products = await _apiService.fetchProducts();
      print('Produk dari API: ${_products.map((e) => '${e.name} (${e.categoryName})').toList()}');
      _errorMessage = '';
    } catch (e) {
      _errorMessage = 'Failed to fetch products: $e';
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}