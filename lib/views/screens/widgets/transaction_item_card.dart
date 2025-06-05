import 'package:flutter/material.dart';
import 'package:homedaily_mvvm/models/transaction.dart';

class TransactionItem extends StatelessWidget {
  final Transaction transaction;
  final VoidCallback onBuyAgain;

  const TransactionItem({
    super.key,
    required this.transaction,
    required this.onBuyAgain,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              transaction.product.title,
              style: const TextStyle(
                fontFamily: 'Poppins',
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Status: ${transaction.status.name}',
              style: const TextStyle(
                fontFamily: 'Poppins',
                color: Colors.grey,
              ),
            ),
            Text(
              transaction.price,
              style: const TextStyle(
                fontFamily: 'Poppins',
                color: Colors.deepOrange,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Align(
              alignment: Alignment.centerRight,
              child: TextButton(
                onPressed: onBuyAgain,
                child: const Text(
                  'Buy Again',
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    color: Colors.blue,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}