import 'package:flutter/material.dart';
import 'package:homedaily_mvvm/models/product.dart';


class ProductListTile extends StatelessWidget {
  final dynamic product;
  final VoidCallback onTap;

  const ProductListTile({super.key, required this.product, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: product.images.isNotEmpty
          ? ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.network(
                product.images.first,
                width: 60,
                height: 60,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) => const Icon(Icons.image_not_supported),
              ),
            )
          : Container(
              width: 60,
              height: 60,
              color: Colors.grey[200],
              child: const Icon(Icons.image, color: Colors.grey),
            ),
      title: Text(
        product.name,
        style: const TextStyle(fontWeight: FontWeight.bold),
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
      ),
      subtitle: Text('Rp${product.price}'),
      trailing: Container(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
        decoration: BoxDecoration(
          color: product.type == 'produk'
              ? Colors.orange.withOpacity(0.15)
              : Colors.blue.withOpacity(0.15),
          borderRadius: BorderRadius.circular(6),
        ),
        child: Text(
          product.type == 'jasa' ? 'Jasa' : 'Produk',
          style: TextStyle(
            fontFamily: 'Poppins',
            fontWeight: FontWeight.bold,
            fontSize: 12,
            color: product.type == 'produk' ? Colors.orange : Colors.blue,
          ),
        ),
      ),
      onTap: onTap,
    );
  }
}