import 'package:flutter/material.dart';
import 'package:homedaily_mvvm/viewmodels/wishlist_viewmodel.dart';
import 'package:homedaily_mvvm/views/screens/widgets/wishlist_item_card.dart';
import 'package:provider/provider.dart';
import 'package:homedaily_mvvm/views/screens/widgets/custom_bottom_navbar.dart';

class WishlistPage extends StatelessWidget {
  const WishlistPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => WishlistViewModel(),
      child: Consumer<WishlistViewModel>(
        builder: (context, viewModel, child) {
          return Scaffold(
            appBar: AppBar(
              title: const Text(
                'Wishlist',
                style: TextStyle(
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              backgroundColor: Colors.orange,
              centerTitle: true,
            ),
            body: viewModel.wishlistItems.isEmpty
                ? const Center(
                    child: Text(
                      'Wishlist kosong.',
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 16,
                        color: Colors.grey,
                      ),
                    ),
                  )
                : ListView.builder(
                    padding: const EdgeInsets.all(16),
                    itemCount: viewModel.wishlistItems.length,
                    itemBuilder: (context, index) {
                      final wishlist = viewModel.wishlistItems[index];
                      final product = wishlist.product;
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          WishlistItemCard(
                            product: product,
                            onRemove: () => viewModel.removeFromWishlist(product),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 16, bottom: 8),
                            child: Row(
                              children: [
                                Container(
                                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                                  decoration: BoxDecoration(
                                    color: product.type == 'Produk'
                                        ? Colors.orange.withOpacity(0.15)
                                        : Colors.blue.withOpacity(0.15),
                                    borderRadius: BorderRadius.circular(6),
                                  ),
                                  child: Text(
                                    product.type,
                                    style: TextStyle(
                                      fontFamily: 'Poppins',
                                      fontWeight: FontWeight.bold,
                                      fontSize: 12,
                                      color: product.type == 'Produk'
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
                      );
                    },
                  ),
            bottomNavigationBar: const CustomBottomNavBar(currentIndex: 4),
          );
        },
      ),
    );
  }
}