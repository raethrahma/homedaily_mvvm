import 'package:flutter/material.dart';
import 'package:homedaily_mvvm/models/product.dart';

class HomeViewModel extends ChangeNotifier {
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

  final List<Product> _services = [
    Product(
      id: '3', // Tambahkan ID unik untuk setiap layanan
      image: 'https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d',
      title: 'Cleaning Service',
      description: 'Layanan kebersihan rumah',
      price: 'Rp.500.00',
    ),
  ];

  List<Product> get products => _products;
  List<Product> get services => _services;

  void addProduct(Product product) {
    _products.add(product);
    notifyListeners();
  }

  void removeProduct(String id) {
    _products.removeWhere((product) => product.id == id);
    notifyListeners();
  }

  void addService(Product service) {
    _services.add(service);
    notifyListeners();
  }

  void removeService(String id) {
    _services.removeWhere((service) => service.id == id);
    notifyListeners();
  }
}
