import 'package:flutter/material.dart';
import 'package:homedaily_mvvm/models/product.dart';

class ViewAllProdukViewModel extends ChangeNotifier {
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
    Product(
      id: '3', // Tambahkan ID unik untuk setiap produk
      image: 'https://images.unsplash.com/photo-1555041469-a586c61ea9bc',
      title: 'Sofa Nyaman',
      description: 'Sofa empuk untuk ruang keluarga',
      price: 'Rp.2.757.000',
    ),
  ];

  List<Product> get products => _products;

  void addProduct(Product product) {
    _products.add(product);
    notifyListeners();
  }

  void removeProduct(String id) {
    _products.removeWhere((product) => product.id == id);
    notifyListeners();
  }

  void updateProduct(String id, Product updatedProduct) {
    final index = _products.indexWhere((product) => product.id == id);
    if (index != -1) {
      _products[index] = updatedProduct;
      notifyListeners();
    }
  }
}
