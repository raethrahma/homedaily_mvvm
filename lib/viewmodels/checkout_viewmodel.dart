import 'package:flutter/material.dart';
import 'package:homedaily_mvvm/models/cart_item.dart';

class CheckoutViewModel extends ChangeNotifier {
  final List<CartItem> _orderItems = [
    CartItem(
      id: '1', // Tambahkan ID unik untuk setiap item
      image: 'https://images.unsplash.com/photo-1533090481720-856c6e3c1fdc',
      title: 'Meja Minimalis',
      price: '247.50',
      quantity: 1,
    ),
    CartItem(
      id: '2', // Tambahkan ID unik untuk setiap item
      image: 'https://images.unsplash.com/photo-1586023492125-27b2c045efd7',
      title: 'Lampu Kuning Cantik',
      price: '247.50',
      quantity: 1,
    ),
  ];

  String? _selectedAddress = 'Jl. Merdeka No.123, Jakarta';
  final List<String> _availableAddresses = [
    'Jl. Merdeka No.123, Jakarta',
    'Jl. Sudirman No.456, Bandung',
  ];

  String? _selectedPaymentMethod = 'Credit Card';
  final List<Map<String, String>> _paymentMethods = [
    {'name': 'Credit Card', 'icon': 'Icons.credit_card'},
    {'name': 'Bank Transfer', 'icon': 'Icons.account_balance'},
    {'name': 'Cash on Delivery', 'icon': 'Icons.money'},
  ];

  List<CartItem> get orderItems => _orderItems;
  String? get selectedAddress => _selectedAddress;
  List<String> get availableAddresses => _availableAddresses;
  String? get selectedPaymentMethod => _selectedPaymentMethod;
  List<Map<String, String>> get paymentMethods => _paymentMethods;

  void selectAddress(String address) {
    if (_availableAddresses.contains(address)) {
      _selectedAddress = address;
      notifyListeners();
    }
  }

  void selectPaymentMethod(String method) {
    final isValidMethod = _paymentMethods.any(
      (payment) => payment['name'] == method,
    );
    if (isValidMethod) {
      _selectedPaymentMethod = method;
      notifyListeners();
    }
  }

  String getTotal() {
    double total = _orderItems.fold(
      0,
      (sum, item) => sum + (double.parse(item.price) * item.quantity),
    );
    return 'Rp ${total.toStringAsFixed(2)}';
  }

  void placeOrder() {
    if (_selectedAddress == null || _selectedPaymentMethod == null) {
      print(
        'Please select an address and payment method before placing the order.',
      );
      return;
    }

    // Implement order placement logic
    print(
      'Order placed with address: $_selectedAddress, payment: $_selectedPaymentMethod',
    );

    // Clear the order items after placing the order
    _orderItems.clear();
    notifyListeners();
  }
}
