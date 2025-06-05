import 'product.dart';

enum TransactionStatus { completed, pending, failed }

class Transaction {
  final String id; // Identifikasi unik transaksi
  final String category; // 'Produk' atau 'Jasa'
  final Product product; // Produk utama dalam transaksi
  final List<Product> products; // Daftar produk dalam transaksi
  final String price; // Harga transaksi (untuk satu produk atau total)
  final String totalPrice; // Total harga transaksi
  final String date; // Tanggal transaksi
  final TransactionStatus status; // Status transaksi
  final String? paymentMethod; // Metode pembayaran (opsional)
  final String? paymentId; // ID pembayaran (opsional)

  Transaction({
    required this.id,
    required this.category, // 'Produk' atau 'Jasa'
    required this.product,
    required this.products,
    required this.price,
    required this.totalPrice,
    required this.date,
    required this.status,
    this.paymentMethod,
    this.paymentId,
  });

  // Hapus fromJson dan toJson karena tidak menggunakan API/JSON
}