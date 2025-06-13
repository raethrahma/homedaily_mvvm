import 'package:flutter/material.dart';
import 'package:homedaily_mvvm/viewmodels/view_all_produk_viewmodel.dart';
import 'package:homedaily_mvvm/views/screens/widgets/custom_card.dart';
import 'package:provider/provider.dart';
import 'package:homedaily_mvvm/views/screens/detail_product_page.dart';
import 'package:homedaily_mvvm/views/screens/widgets/custom_bottom_navbar.dart';
import 'package:homedaily_mvvm/views/screens/widgets/listview.dart'; // Import widget ListView

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
                    : _buildList(context, viewModel.allProducts, 'Tidak ada produk.'),
            bottomNavigationBar: const CustomBottomNavBar(currentIndex: 1),
          );
        },
      ),
    );
  }

  Widget _buildList(BuildContext context, List products, String emptyText) {
    if (products.isEmpty) {
      return Center(child: Text(emptyText));
    }
    return ListView.separated(
      padding: const EdgeInsets.all(16),
      itemCount: products.length,
      separatorBuilder: (_, __) => const SizedBox(height: 12),
      itemBuilder: (context, index) {
        final product = products[index];
        return CustomCard(
          padding: EdgeInsets.zero,
          child: ProductListTile(
            product: product,
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => ProductDetailPage(product: product),
                ),
              );
            },
          ),
        );
      },
    );
  }
}