import 'product.dart';

enum TransactionStatus { completed, pending, failed }

class Transaction {
  final String id; // Identifikasi unik transaksi
  final String category; // Kategori transaksi
  final Product product; // Produk utama dalam transaksi
  final List<Product> products; // Daftar produk dalam transaksi
  final String price; // Harga transaksi (untuk satu produk atau total)
  final String
  totalPrice; // Total harga transaksi (opsional, jika lebih dari satu produk)
  final String date; // Tanggal transaksi
  final TransactionStatus status; // Status transaksi
  final String? paymentMethod; // Metode pembayaran (opsional)
  final String? paymentId; // ID pembayaran (opsional)

  Transaction({
    required this.id,
    required this.category,
    required this.product, // Produk utama
    required this.products, // Daftar produk
    required this.price, // Harga transaksi
    required this.totalPrice, // Total harga transaksi
    required this.date,
    required this.status,
    this.paymentMethod,
    this.paymentId,
  });

  factory Transaction.fromJson(Map<String, dynamic> json) {
    return Transaction(
      id: json['id'] as String,
      category: json['category'] as String,
      product: Product.fromJson(
        json['product'] as Map<String, dynamic>,
      ), // Produk utama
      products:
          (json['products'] as List<dynamic>)
              .map(
                (product) => Product.fromJson(product as Map<String, dynamic>),
              )
              .toList(),
      price: json['price'] as String, // Harga transaksi
      totalPrice: json['totalPrice'] as String, // Total harga transaksi
      date: json['date'] as String,
      status: TransactionStatus.values.firstWhere(
        (e) => e.toString() == 'TransactionStatus.${json['status']}',
      ),
      paymentMethod: json['paymentMethod'] as String?,
      paymentId: json['paymentId'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'category': category,
      'product': product.toJson(), // Produk utama
      'products': products.map((product) => product.toJson()).toList(),
      'price': price, // Harga transaksi
      'totalPrice': totalPrice, // Total harga transaksi
      'date': date,
      'status': status.toString().split('.').last,
      'paymentMethod': paymentMethod,
      'paymentId': paymentId,
    };
  }
}
