import 'package:flutter/material.dart';
import 'package:homedaily_mvvm/models/transaction.dart';
import 'package:homedaily_mvvm/models/product.dart';

class TransactionViewModel extends ChangeNotifier {
  String _selectedTab = 'Semua Status';
  final List<Transaction> _transactions = [
    Transaction(
      id: '1',
      category: 'Furniture',
      product: Product(
        id: '101',
        image: 'https://via.placeholder.com/150',
        title: 'Meja Minimalis',
        description: 'Meja minimalis untuk ruang tamu.',
        price: 'Rp 247.500',
      ),
      products: [
        Product(
          id: '101',
          image: 'https://via.placeholder.com/150',
          title: 'Meja Minimalis',
          description: 'Meja minimalis untuk ruang tamu.',
          price: 'Rp 247.500',
        ),
      ],
      price: 'Rp 247.500',
      totalPrice: 'Rp 247.500',
      date: '2023-10-01',
      status: TransactionStatus.completed,
      paymentMethod: 'Credit Card',
      paymentId: 'PAY123',
    ),
    Transaction(
      id: '2',
      category: 'Lighting',
      product: Product(
        id: '102',
        image: 'https://via.placeholder.com/150',
        title: 'Lampu Kuning Cantik',
        description: 'Lampu kuning untuk dekorasi rumah.',
        price: 'Rp 150.000',
      ),
      products: [
        Product(
          id: '102',
          image: 'https://via.placeholder.com/150',
          title: 'Lampu Kuning Cantik',
          description: 'Lampu kuning untuk dekorasi rumah.',
          price: 'Rp 150.000',
        ),
      ],
      price: 'Rp 150.000',
      totalPrice: 'Rp 150.000',
      date: '2023-10-02',
      status: TransactionStatus.pending,
      paymentMethod: 'Bank Transfer',
      paymentId: 'PAY124',
    ),
  ];

  String get selectedTab => _selectedTab;
  List<Transaction> get transactions => _transactions;

  void selectTab(String tab) {
    _selectedTab = tab;
    notifyListeners();
  }

  void buyAgain(Transaction transaction) {
    // Logika untuk membeli ulang produk
    print('Buying again: ${transaction.product.title}');
  }
}
