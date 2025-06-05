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
                  fontFamily: 'CustomFont', // Menggunakan font kustom
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              backgroundColor: Colors.deepOrange,
            ),
            body: ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: viewModel.wishlistItems.length,
              itemBuilder: (context, index) {
                final item = viewModel.wishlistItems[index];
                return WishlistItemCard(
                  product: item,
                  onRemove: () => viewModel.removeFromWishlist(item),
                );
              },
            ),
            bottomNavigationBar: CustomBottomNavBar(currentIndex: 4),
          );
        },
      ),
    );
  }
}
