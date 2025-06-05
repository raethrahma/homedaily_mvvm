import 'package:flutter/material.dart';
import 'package:homedaily_mvvm/models/transaction.dart';
import 'package:homedaily_mvvm/models/product.dart';

class TransactionViewModel extends ChangeNotifier {
  String _selectedTab = 'Semua Status';
  final List<Transaction> _transactions = [
    Transaction(
      id: '1',
      category: 'Produk',
      product: Product(
        id: '101',
        image: 'https://via.placeholder.com/150',
        title: 'Meja Minimalis',
        description: 'Meja minimalis untuk ruang tamu.',
        price: 'Rp 247.500',
        type: 'Produk',
        category: 'Produk',
      ),
      products: [
        Product(
          id: '101',
          image: 'https://via.placeholder.com/150',
          title: 'Meja Minimalis',
          description: 'Meja minimalis untuk ruang tamu.',
          price: 'Rp 247.500',
          type: 'Produk',
          category: 'Produk',
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
      category: 'Produk',
      product: Product(
        id: '102',
        image: 'https://via.placeholder.com/150',
        title: 'Lampu Kuning Cantik',
        description: 'Lampu kuning untuk dekorasi rumah.',
        price: 'Rp 150.000',
        type: 'Produk',
        category: 'Produk',
      ),
      products: [
        Product(
          id: '102',
          image: 'https://via.placeholder.com/150',
          title: 'Lampu Kuning Cantik',
          description: 'Lampu kuning untuk dekorasi rumah.',
          price: 'Rp 150.000',
          type: 'Produk',
          category: 'Produk',
        ),
      ],
      price: 'Rp 150.000',
      totalPrice: 'Rp 150.000',
      date: '2023-10-02',
      status: TransactionStatus.pending,
      paymentMethod: 'Bank Transfer',
      paymentId: 'PAY124',
    ),
    Transaction(
      id: '3',
      category: 'Jasa',
      product: Product(
        id: '103',
        image: 'https://via.placeholder.com/150',
        title: 'Cleaning Service',
        description: 'Jasa cleaning service profesional.',
        price: 'Rp 500.000',
        type: 'Jasa',
        category: 'Jasa',
      ),
      products: [
        Product(
          id: '103',
          image: 'https://via.placeholder.com/150',
          title: 'Cleaning Service',
          description: 'Jasa cleaning service profesional.',
          price: 'Rp 500.000',
          type: 'Jasa',
          category: 'Jasa',
        ),
      ],
      price: 'Rp 500.000',
      totalPrice: 'Rp 500.000',
      date: '2023-10-03',
      status: TransactionStatus.completed,
      paymentMethod: 'Cash',
      paymentId: 'PAY125',
    ),
  ];

  String get selectedTab => _selectedTab;
  List<Transaction> get transactions => _transactions;

  // Getter untuk transaksi yang sudah difilter sesuai tab
  List<Transaction> get filteredTransactions {
    if (_selectedTab == 'Semua Status') {
      return _transactions;
    }
    return _transactions.where((t) => t.category == _selectedTab).toList();
  }

  void selectTab(String tab) {
    _selectedTab = tab;
    notifyListeners();
  }

  void buyAgain(Transaction transaction) {
    // Logika untuk membeli ulang produk/jasa
    print('Buying again: ${transaction.product.title}');
  }
}