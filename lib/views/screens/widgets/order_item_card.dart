import 'package:flutter/material.dart';
import 'package:homedaily_mvvm/models/cart_item.dart';

class OrderItemCard extends StatelessWidget {
  final CartItem cartItem;

  const OrderItemCard({super.key, required this.cartItem});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.network(
                cartItem.image, // Menggunakan properti `image` dari CartItem
                width: 80,
                height: 80,
                fit: BoxFit.cover,
                errorBuilder:
                    (context, error, stackTrace) => const Icon(Icons.error),
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    cartItem
                        .title, // Menggunakan properti `title` dari CartItem
                    style: const TextStyle(
                      fontFamily: 'CustomFont', // Menggunakan font kustom
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  Text(
                    'Qty: ${cartItem.quantity}', // Menggunakan properti `quantity` dari CartItem
                    style: const TextStyle(
                      fontFamily: 'CustomFont', // Menggunakan font kustom
                      color: Colors.grey,
                    ),
                  ),
                  Text(
                    'Rp ${cartItem.price}', // Menggunakan properti `price` dari CartItem
                    style: const TextStyle(
                      fontFamily: 'CustomFont', // Menggunakan font kustom
                      color: Colors.deepOrange,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
