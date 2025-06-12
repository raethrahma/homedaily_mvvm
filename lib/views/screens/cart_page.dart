import 'package:flutter/material.dart';
import 'package:homedaily_mvvm/viewmodels/cart_viewmodel.dart';
import 'package:homedaily_mvvm/views/screens/checkout_page.dart';
import 'package:homedaily_mvvm/views/screens/widgets/cart_item_card.dart';
import 'package:provider/provider.dart';
import 'package:homedaily_mvvm/views/screens/widgets/custom_bottom_navbar.dart';
import 'package:cached_network_image/cached_network_image.dart';

class CartPage extends StatelessWidget {
  const CartPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => CartViewModel(),
      child: Consumer<CartViewModel>(
        builder: (context, viewModel, child) {
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
                _buildFilterSection(viewModel),
                Expanded(
                  child: ListView.builder(
                    itemCount: viewModel.filteredCartItems.length,
                    itemBuilder: (context, index) {
                      final item = viewModel.filteredCartItems[index];
                      return CartItemCard(
                        key: ValueKey(item.id),
                        cartItem: item,
                        onRemove: () => viewModel.removeFromCart(item),
                        onQuantityChanged:
                            (qty) => viewModel.updateQuantity(item, qty),
                      );
                    },
                  ),
                ),
                _buildTotalSection(viewModel),
              ],
            ),
            bottomNavigationBar: const CustomBottomNavBar(currentIndex: 3),
          );
        },
      ),
    );
  }

  Widget _buildFilterSection(CartViewModel viewModel) {
    return Container(
      padding: const EdgeInsets.all(16),
      color: Colors.white,
      child: Row(
        children:
            viewModel.filters
                .map(
                  (filter) => _FilterChip(
                    label: filter,
                    isSelected: viewModel.selectedFilter == filter,
                    onSelected: () => viewModel.updateFilter(filter),
                  ),
                )
                .toList(),
      ),
    );
  }

  Widget _buildTotalSection(CartViewModel viewModel) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: const [BoxShadow(color: Colors.black12, blurRadius: 4)],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Text(
            'Total:',
            style: TextStyle(
              fontFamily: 'Poppins',
              fontSize: 18,
              fontWeight: FontWeight.w600,
            ),
          ),
          Text(
            viewModel.getTotal(),
            style: const TextStyle(
              fontFamily: 'Poppins',
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.orange,
            ),
          ),
        ],
      ),
    );
  }
}

class _FilterChip extends StatelessWidget {
  final String label;
  final bool isSelected;
  final VoidCallback onSelected;

  const _FilterChip({
    required this.label,
    required this.isSelected,
    required this.onSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 8),
      child: FilterChip(
        label: Text(label),
        selected: isSelected,
        onSelected: (_) => onSelected(),
      ),
    );
  }
}
