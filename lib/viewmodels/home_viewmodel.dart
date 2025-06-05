import 'package:flutter/material.dart';
import 'package:homedaily_mvvm/models/product.dart';

class HomeViewModel extends ChangeNotifier {
  final List<Product> _products = [
    Product(
      id: '1',
      image: 'https://images.unsplash.com/photo-1533090481720-856c6e3c1fdc',
      title: 'Meja Minimalis',
      description: 'Meja kayu berkualitas tinggi',
      price: 'Rp 247.500',
      type: 'Produk',
      category: 'Produk',
    ),
    Product(
      id: '2',
      image: 'https://images.unsplash.com/photo-1586023492125-27b2c045efd7',
      title: 'Lampu Kuning Cantik',
      description: 'Lampu dekorasi estetik',
      price: 'Rp 150.000',
      type: 'Produk',
      category: 'Produk',
    ),
    Product(
      id: '3',
      image: 'https://images.unsplash.com/photo-1533090481720-856c6e3c1fdc',
      title: 'Meja Minimalis',
      description: 'Meja kayu berkualitas tinggi',
      price: 'Rp 247.500',
      type: 'Produk',
      category: 'Produk',
    ),
    Product(
      id: '4',
      image: 'https://images.unsplash.com/photo-1586023492125-27b2c045efd7',
      title: 'Lampu Kuning Cantik',
      description: 'Lampu dekorasi estetik',
      price: 'Rp 150.000',
      type: 'Produk',
      category: 'Produk',
    ),
    Product(
      id: '5',
      image: 'https://images.unsplash.com/photo-1533090481720-856c6e3c1fdc',
      title: 'Meja Minimalis',
      description: 'Meja kayu berkualitas tinggi',
      price: 'Rp 247.500',
      type: 'Produk',
      category: 'Produk',
    ),
    Product(
      id: '6',
      image: 'https://images.unsplash.com/photo-1586023492125-27b2c045efd7',
      title: 'Lampu Kuning Cantik',
      description: 'Lampu dekorasi estetik',
      price: 'Rp 150.000',
      type: 'Produk',
      category: 'Produk',
    ),
  ];

  final List<Product> _services = [
    Product(
      id: '7',
      image: 'https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d',
      title: 'Cleaning Service',
      description: 'Layanan kebersihan rumah profesional, rumah bersih dan sehat.',
      price: 'Rp 500.000',
      type: 'Jasa',
      category: 'Jasa',
    ),
    Product(
      id: '8',
      image: 'https://images.unsplash.com/photo-1515378791036-0648a3ef77b2',
      title: 'Service AC',
      description: 'Perawatan dan perbaikan AC, udara rumah selalu sejuk.',
      price: 'Rp 350.000',
      type: 'Jasa',
      category: 'Jasa',
    ),
    Product(
      id: '9',
      image: 'https://images.unsplash.com/photo-1465101178521-c1a9136a3b99',
      title: 'Jasa Pindahan',
      description: 'Membantu proses pindahan rumah dengan aman dan cepat.',
      price: 'Rp 1.200.000',
      type: 'Jasa',
      category: 'Jasa',
    ),
    Product(
      id: '10',
      image: 'https://images.unsplash.com/photo-1519125323398-675f0ddb6308',
      title: 'Laundry Kiloan',
      description: 'Layanan laundry kiloan, pakaian bersih dan wangi.',
      price: 'Rp 50.000',
      type: 'Jasa',
      category: 'Jasa',
    ),
    Product(
      id: '11',
      image: 'https://images.unsplash.com/photo-1519985176271-adb1088fa94c',
      title: 'Tukang Listrik',
      description: 'Perbaikan instalasi listrik rumah Anda, aman dan terpercaya.',
      price: 'Rp 200.000',
      type: 'Jasa',
      category: 'Jasa',
    ),
    Product(
      id: '12',
      image: 'https://images.unsplash.com/photo-1506744038136-46273834b3fb',
      title: 'Jasa Cat Rumah',
      description: 'Jasa pengecatan rumah, hasil rapi dan tahan lama.',
      price: 'Rp 800.000',
      type: 'Jasa',
      category: 'Jasa',
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