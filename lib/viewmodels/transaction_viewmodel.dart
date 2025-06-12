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
        id: 101,
        name: 'Meja Minimalis',
        description: 'Meja minimalis untuk ruang tamu.',
        price: '247500',
        stock: 10,
        categoryName: 'Produk',
        images: ['https://via.placeholder.com/150'],
      ),
      products: [
        Product(
          id: 101,
          name: 'Meja Minimalis',
          description: 'Meja minimalis untuk ruang tamu.',
          price: '247500',
          stock: 10,
          categoryName: 'Produk',
          images: ['https://via.placeholder.com/150'],
        ),
      ],
      price: '247500',
      totalPrice: '247500',
      date: '2023-10-01',
      status: TransactionStatus.completed,
      paymentMethod: 'Credit Card',
      paymentId: 'PAY123',
    ),
    Transaction(
      id: '2',
      category: 'Produk',
      product: Product(
        id: 102,
        name: 'Lampu Kuning Cantik',
        description: 'Lampu kuning untuk dekorasi rumah.',
        price: '150000',
        stock: 15,
        categoryName: 'Produk',
        images: ['https://via.placeholder.com/150'],
      ),
      products: [
        Product(
          id: 102,
          name: 'Lampu Kuning Cantik',
          description: 'Lampu kuning untuk dekorasi rumah.',
          price: '150000',
          stock: 15,
          categoryName: 'Produk',
          images: ['https://via.placeholder.com/150'],
        ),
      ],
      price: '150000',
      totalPrice: '150000',
      date: '2023-10-02',
      status: TransactionStatus.pending,
      paymentMethod: 'Bank Transfer',
      paymentId: 'PAY124',
    ),
    Transaction(
      id: '3',
      category: 'Jasa',
      product: Product(
        id: 103,
        name: 'Cleaning Service',
        description: 'Jasa cleaning service profesional.',
        price: '500000',
        stock: 0,
        categoryName: 'Jasa',
        images: ['https://via.placeholder.com/150'],
      ),
      products: [
        Product(
          id: 103,
          name: 'Cleaning Service',
          description: 'Jasa cleaning service profesional.',
          price: '500000',
          stock: 0,
          categoryName: 'Jasa',
          images: ['https://via.placeholder.com/150'],
        ),
      ],
      price: '500000',
      totalPrice: '500000',
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
    print('Buying again: ${transaction.product.name}');
  }
}
