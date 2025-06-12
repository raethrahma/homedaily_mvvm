import 'package:flutter/material.dart';
import 'package:homedaily_mvvm/viewmodels/view_all_produk_viewmodel.dart';
import 'package:homedaily_mvvm/views/screens/widgets/custom_card.dart';
import 'package:provider/provider.dart';
import 'package:homedaily_mvvm/views/screens/detail_product_page.dart';
import 'package:homedaily_mvvm/views/screens/widgets/custom_bottom_navbar.dart';

class ViewAllProduk extends StatelessWidget {
  const ViewAllProduk({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => ViewAllProdukViewModel()..fetchProducts(),
      child: Consumer<ViewAllProdukViewModel>(
        builder: (context, viewModel, child) {
          return Scaffold(
            appBar: AppBar(
              title: const Text(
                'All Products',
                style: TextStyle(
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              backgroundColor: Colors.orange,
            ),
            body: viewModel.isLoading
                ? const Center(child: CircularProgressIndicator())
                : viewModel.errorMessage.isNotEmpty
                    ? Center(child: Text(viewModel.errorMessage))
                    : _buildGrid(context, viewModel.allProducts, 'Tidak ada produk.'),
            bottomNavigationBar: const CustomBottomNavBar(currentIndex: 1),
          );
        },
      ),
    );
  }

  Widget _buildGrid(BuildContext context, List products, String emptyText) {
    if (products.isEmpty) {
      return Center(child: Text(emptyText));
    }
    return GridView.builder(
      padding: const EdgeInsets.all(16),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 0.68,
        crossAxisSpacing: 16,
        mainAxisSpacing: 16,
      ),
      itemCount: products.length,
      itemBuilder: (context, index) {
        final product = products[index];
        return CustomCard(
          padding: EdgeInsets.zero,
          child: InkWell(
            borderRadius: BorderRadius.circular(12),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => ProductDetailPage(product: product),
                ),
              );
            },
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Gambar produk (jika ada)
                if (product.images.isNotEmpty)
                  ClipRRect(
                    borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
                    child: Image.network(
                      product.images.first,
                      width: double.infinity,
                      height: 100,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) => const Icon(Icons.image_not_supported),
                    ),
                  )
                else
                  Container(
                    width: double.infinity,
                    height: 100,
                    color: Colors.grey[200],
                    child: const Icon(Icons.image, size: 40, color: Colors.grey),
                  ),
                const SizedBox(height: 8),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: Text(
                    product.name,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                  child: Text(
                    'Rp${product.price}',
                    style: const TextStyle(
                      color: Colors.orange,
                      fontWeight: FontWeight.bold,
                      fontSize: 13,
                    ),
                  ),
                ),
                const Spacer(),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  child: Row(
                    children: [
                      Container(
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
                            color: product.type == 'produk'
                                ? Colors.orange
                                : Colors.blue,
                          ),
                        ),
                      ),
                      const SizedBox(width: 6),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                        decoration: BoxDecoration(
                          color: Colors.grey.withOpacity(0.15),
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: Text(
                          product.categoryName,
                          style: const TextStyle(
                            fontFamily: 'Poppins',
                            fontSize: 12,
                            color: Colors.grey,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}