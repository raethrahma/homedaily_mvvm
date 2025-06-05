import 'package:flutter/material.dart';
import 'package:homedaily_mvvm/viewmodels/home_viewmodel.dart';
import 'package:homedaily_mvvm/views/screens/widgets/product_card.dart';
import 'package:provider/provider.dart';
import 'package:homedaily_mvvm/views/screens/widgets/custom_bottom_navbar.dart';
import 'package:homedaily_mvvm/views/screens/widgets/custom_card.dart';

// Import halaman tujuan navigasi
import 'package:homedaily_mvvm/views/screens/chat_list_page.dart';
import 'package:homedaily_mvvm/views/screens/view_all_produk_page.dart';
import 'package:homedaily_mvvm/views/screens/detail_product_page.dart';
import 'package:homedaily_mvvm/models/product.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => HomeViewModel(),
      child: Consumer<HomeViewModel>(
        builder: (context, viewModel, child) {
          return Scaffold(
            appBar: AppBar(
              title: const Text(
                'HomeDaily',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  fontSize: 20,
                  fontFamily: 'Poppins',
                ),
              ),
              centerTitle: true,
              backgroundColor: Colors.orange,
              actions: [
                IconButton(
                  icon: const Icon(
                    Icons.chat_bubble_outline,
                    color: Colors.white,
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => const ChatListPage()),
                    );
                  },
                ),
                const SizedBox(width: 8),
              ],
            ),
            body: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildBannerSection(
                    context,
                    'ABSOLUTE FURNITURE',
                    '80% OFF',
                    'Apalagi yang kamu tunggu \n untuk ruang tengahmu',
                    'SHOP NOW',
                  ),
                  _buildPopularSection(
                    context,
                    viewModel.products,
                    'Produk populer',
                  ),
                  _buildPopularSection(
                    context,
                    viewModel.products.reversed.toList(),
                    'Produk populer lainnya',
                    reverse: true,
                  ),
                  _buildBannerSection(
                    context,
                    'ABSOLUTE HOMESERVICE',
                    '80% OFF',
                    'Apalagi yang kamu tunggu \n untuk perawatan rumah tersayang',
                    'ORDER NOW',
                    imageUrl:
                        'https://images.unsplash.com/photo-1513694203232-719a1ce7a95f',
                    overlayColor: Colors.orange.withOpacity(0.4),
                  ),
                  _buildPopularSection(
                    context,
                    viewModel.services,
                    'Jasa populer',
                  ),
                ],
              ),
            ),
            bottomNavigationBar: CustomBottomNavBar(currentIndex: 0),
          );
        },
      ),
    );
  }

  // Banner Section Widget
  Widget _buildBannerSection(
    BuildContext context,
    String title,
    String discount,
    String subtitle,
    String buttonText, {
    String? imageUrl,
    Color? overlayColor,
  }) {
    return Container(
      height: 250,
      width: double.infinity,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: NetworkImage(
            imageUrl ??
                'https://images.unsplash.com/photo-1540221652346-3ec6807e5e7e',
          ),
          fit: BoxFit.cover,
        ),
      ),
      child: Container(
        color: overlayColor ?? Colors.orange.withOpacity(0.4),
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              title,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.bold,
                fontFamily: 'Poppins',
              ),
            ),
            const SizedBox(height: 8),
            Text(
              discount,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 24,
                fontWeight: FontWeight.bold,
                fontFamily: 'Poppins',
              ),
            ),
            const SizedBox(height: 8),
            Text(
              subtitle,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.bold,
                fontFamily: 'Poppins',
              ),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.orange,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 12,
                ),
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const ViewAllProduk()),
                );
              },
              child: Text(
                buttonText,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  fontSize: 14,
                  fontFamily: 'Poppins',
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Product List Section Widget
  Widget _buildPopularSection(
    BuildContext context,
    List items,
    String title, {
    bool reverse = false,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Poppins',
                ),
              ),
              TextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => const ViewAllProduk()),
                  );
                },
                child: const Text(
                  'View all',
                  style: TextStyle(
                    color: Colors.grey,
                    fontFamily: 'Poppins',
                  ),
                ),
              ),
            ],
          ),
        ),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Row(
            children: items
                .map<Widget>(
                  (product) => SizedBox(
                    width: 160,
                    height: 220,
                    child: CustomCard(
                      padding: EdgeInsets.zero,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: ProductCard(
                              product: product,
                              onTap: () {
                                if (product is Product) {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (_) =>
                                          ProductDetailPage(product: product),
                                    ),
                                  );
                                }
                              },
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 8, vertical: 4),
                            child: Row(
                              children: [
                                if (product is Product)
                                  Container(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 8, vertical: 2),
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
                                if (product is Product) const SizedBox(width: 6),
                                if (product is Product)
                                  Container(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 8, vertical: 2),
                                    decoration: BoxDecoration(
                                      color: Colors.grey.withOpacity(0.15),
                                      borderRadius: BorderRadius.circular(6),
                                    ),
                                    child: Text(
                                      product.category,
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
                  ),
                )
                .toList(),
          ),
        ),
        const SizedBox(height: 20),
      ],
    );
  }
}