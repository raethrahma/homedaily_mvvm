import 'package:flutter/material.dart';
import 'package:homedaily_mvvm/models/product.dart';
import 'package:homedaily_mvvm/services/api_service.dart';

class ViewAllProdukViewModel extends ChangeNotifier {
  final ApiService _apiService = ApiService();

  List<Product> _products = []; // Produk dari API
  bool _isLoading = false;
  String _errorMessage = '';

  // Getter
  List<Product> get products => _products;
  bool get isLoading => _isLoading;
  String get errorMessage => _errorMessage;

  // Fungsi untuk mengambil data dari API
  Future<void> fetchProducts() async {
    _isLoading = true;
    notifyListeners();

    try {
      _products = await _apiService.fetchProducts();
      _errorMessage = '';
    } catch (e) {
      _errorMessage = 'Failed to fetch products: $e';
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  // Fungsi untuk menambah produk
  void addProduct(Product product) {
    _products.add(product);
    notifyListeners();
  }

  // Fungsi untuk menghapus produk berdasarkan ID
  void removeProduct(int id) {
    _products.removeWhere((product) => product.id == id);
    notifyListeners();
  }

  // Fungsi untuk memperbarui produk berdasarkan ID
  void updateProduct(int id, Product updatedProduct) {
    final index = _products.indexWhere((product) => product.id == id);
    if (index != -1) {
      _products[index] = updatedProduct;
      notifyListeners();
    }
  }
}
