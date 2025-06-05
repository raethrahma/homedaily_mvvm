import 'package:flutter/material.dart';
import 'package:homedaily_mvvm/viewmodels/cart_viewmodel.dart';
import 'package:homedaily_mvvm/views/screens/widgets/cart_item_card.dart';
import 'package:provider/provider.dart';
import 'package:homedaily_mvvm/views/screens/widgets/custom_bottom_navbar.dart';

class CartPage extends StatelessWidget {
  const CartPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => CartViewModel(),
      child: Consumer<CartViewModel>(
        builder: (context, viewModel, child) {
          final List<String> filters = ['Produk', 'Jasa'];
          return Scaffold(
            appBar: AppBar(
              title: const Text(
                'Cart',
                style: TextStyle(
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              centerTitle: true,
              backgroundColor: Colors.orange,
            ),
            body: Column(
              children: [
                Container(
                  padding: const EdgeInsets.all(16),
                  color: Colors.white,
                  child: Row(
                    children: [
                      Expanded(
                        child: Container(
                          height: 48,
                          padding: const EdgeInsets.symmetric(horizontal: 12),
                          decoration: BoxDecoration(
                            color: Colors.orange,
                            borderRadius: BorderRadius.circular(12),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.orange.withOpacity(0.2),
                                blurRadius: 4,
                                offset: const Offset(0, 2),
                              ),
                            ],
                          ),
                          child: DropdownButtonHideUnderline(
                            child: DropdownButton<String>(
                              value: viewModel.selectedFilter,
                              isExpanded: true,
                              icon: Container(
                                padding: const EdgeInsets.all(4),
                                decoration: BoxDecoration(
                                  color: Colors.orange.shade600,
                                  borderRadius: BorderRadius.circular(6),
                                ),
                                child: const Icon(
                                  Icons.keyboard_arrow_down_rounded,
                                  color: Colors.white,
                                  size: 20,
                                ),
                              ),
                              style: const TextStyle(
                                color: Colors.white,
                                fontFamily: 'Poppins',
                                fontWeight: FontWeight.w600,
                                fontSize: 14,
                              ),
                              dropdownColor: Colors.orange.shade400,
                              borderRadius: BorderRadius.circular(12),
                              items: filters.map((filter) {
                                return DropdownMenuItem(
                                  value: filter,
                                  child: Text(
                                    filter,
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontFamily: 'Poppins',
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                );
                              }).toList(),
                              onChanged: (value) {
                                if (value != null) {
                                  viewModel.updateFilter(value);
                                }
                              },
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: viewModel.filteredCartItems.isEmpty
                      ? const Center(
                          child: Text(
                            'Keranjang kosong.',
                            style: TextStyle(
                              fontFamily: 'Poppins',
                              fontSize: 16,
                              color: Colors.grey,
                            ),
                          ),
                        )
                      : ListView.builder(
                          padding: const EdgeInsets.all(16),
                          itemCount: viewModel.filteredCartItems.length,
                          itemBuilder: (context, index) {
                            final cartItem = viewModel.filteredCartItems[index];
                            // Pastikan cartItem.product.type dan cartItem.product.category hanya 'Produk' atau 'Jasa'
                            return CartItemCard(
                              cartItem: cartItem,
                              onRemove: () => viewModel.removeFromCart(cartItem),
                              onQuantityChanged: (qty) => viewModel.updateQuantity(cartItem, qty),
                              // Tampilkan badge type/category jika ingin:
                              // badge: cartItem.product.type,
                            );
                          },
                        ),
                ),
              ],
            ),
            bottomNavigationBar: const CustomBottomNavBar(currentIndex: 3),
          );
        },
      ),
    );
  }
}