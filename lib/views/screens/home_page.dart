import 'package:flutter/material.dart';
import 'package:homedaily_mvvm/models/product.dart';
import 'package:homedaily_mvvm/viewmodels/home_viewmodel.dart';
import 'package:homedaily_mvvm/views/screens/widgets/product_card.dart';
import 'package:provider/provider.dart';
import 'package:homedaily_mvvm/views/screens/widgets/custom_bottom_navbar.dart';


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
                  fontFamily: 'CustomFont', // Menggunakan font kustom
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              centerTitle: true,
              backgroundColor: Colors.deepOrange,
              actions: [
                IconButton(
                  icon: const Icon(
                    Icons.chat_bubble_outline,
                    color: Colors.white,
                  ),
                  onPressed: () {
                    Navigator.pushNamed(context, '/chat_list');
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
                    'SHOP NOW', // Menambahkan nilai untuk buttonText
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
                    'ORDER NOW', // Menambahkan nilai untuk buttonText
                    imageUrl:
                        'https://images.unsplash.com/photo-1513694203232-719a1ce7a95f',
                    overlayColor: Colors.blue.withOpacity(0.4),
                  ),
                  _buildPopularSection(
                    context,
                    viewModel.services,
                    'Jasa populer',
                  ),
                ],
              ),
            ),
            bottomNavigationBar: CustomBottomNavBar(currentIndex: 0),          );
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
    String buttonText, { // Parameter buttonText ditambahkan
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
        color: overlayColor ?? Colors.deepOrange.withOpacity(0.4),
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              title,
              style: const TextStyle(
                fontFamily: 'CustomFont', // Menggunakan font kustom
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              discount,
              style: const TextStyle(
                fontFamily: 'CustomFont', // Menggunakan font kustom
                color: Colors.white,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              subtitle,
              style: const TextStyle(
                fontFamily: 'CustomFont', // Menggunakan font kustom
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 12,
                ),
              ),
              onPressed: () {
                Navigator.pushNamed(context, '/view_all_products');
              },
              child: Text(
                buttonText, // Menggunakan parameter buttonText
                style: const TextStyle(
                  fontFamily: 'CustomFont', // Menggunakan font kustom
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                  fontSize: 14,
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
    List<Product> items,
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
                  fontFamily: 'CustomFont', // Menggunakan font kustom
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              TextButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/view_all_products');
                },
                child: const Text(
                  'View all',
                  style: TextStyle(
                    fontFamily: 'CustomFont', // Menggunakan font kustom
                    color: Colors.grey,
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
            children:
                items
                    .map(
                      (product) => Container(
                        width: 160,
                        margin: const EdgeInsets.only(right: 16),
                        child: ProductCard(product: product),
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
