import 'package:flutter/material.dart';
import '../models/product.dart';
import '../services/api_service.dart';

class HomeViewModel extends ChangeNotifier {
  final ApiService _apiService = ApiService();

  List<Product> _allProducts = []; // Semua produk dan layanan dari API
  bool _isLoading = false;
  String _errorMessage = '';

  // Getter untuk memisahkan data berdasarkan kategori
  List<Product> get products =>
      _allProducts.where((product) => product.type == 'Produk').toList();
  List<Product> get services =>
      _allProducts.where((product) => product.type == 'Jasa').toList();
  bool get isLoading => _isLoading;
  String get errorMessage => _errorMessage;

  // Fungsi untuk mengambil data dari API
  Future<void> fetchProducts() async {
    _isLoading = true;
    notifyListeners();

    try {
      _allProducts = await _apiService.fetchProducts();
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
    _allProducts.add(product);
    notifyListeners();
  }

  // Fungsi untuk menghapus produk berdasarkan ID
  void removeProduct(String id) {
    _allProducts.removeWhere((product) => product.id == int.parse(id));
    notifyListeners();
  }
}
