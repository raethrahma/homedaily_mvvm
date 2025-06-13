import 'package:flutter/material.dart';
import 'package:homedaily_mvvm/viewmodels/explore_viewmodel.dart';
import 'package:homedaily_mvvm/views/screens/widgets/product_card.dart';
import 'package:provider/provider.dart';
import 'package:homedaily_mvvm/views/screens/widgets/custom_bottom_navbar.dart';
import 'package:homedaily_mvvm/views/screens/widgets/custom_card.dart';
import 'package:homedaily_mvvm/views/screens/detail_product_page.dart';

class ExplorePage extends StatelessWidget {
  const ExplorePage({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => ExploreViewModel(),
      child: Consumer<ExploreViewModel>(
        builder: (context, viewModel, child) {
          return Scaffold(
            appBar: AppBar(
              title: const Text(
                'Explore',
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
                : viewModel.errorMessage != null
                    ? Center(
                        child: Text(
                          viewModel.errorMessage!,
                          style: const TextStyle(
                            fontFamily: 'Poppins',
                            color: Colors.red,
                          ),
                        ),
                      )
                    : Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(16),
                            child: DropdownButton<String>(
                              isExpanded: true,
                              value: viewModel.selectedFilter,
                              items: viewModel.filters
                                  .map(
                                    (filter) => DropdownMenuItem(
                                      value: filter,
                                      child: Text(
                                        filter,
                                        style: const TextStyle(
                                          fontFamily: 'Poppins',
                                        ),
                                      ),
                                    ),
                                  )
                                  .toList(),
                              onChanged: (value) {
                                if (value != null) {
                                  viewModel.updateFilter(value);
                                }
                              },
                            ),
                          ),
                          if (viewModel.searchHistory.isNotEmpty)
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 16),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text(
                                    'Recent Searches',
                                    style: TextStyle(
                                      fontFamily: 'Poppins',
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Wrap(
                                    spacing: 8,
                                    children: viewModel.searchHistory
                                        .map(
                                          (query) => Chip(
                                            label: Text(
                                              query,
                                              style: const TextStyle(
                                                fontFamily: 'Poppins',
                                              ),
                                            ),
                                            onDeleted: () =>
                                                viewModel.removeSearchHistory(query),
                                          ),
                                        )
                                        .toList(),
                                  ),
                                ],
                              ),
                            ),
                          Expanded(
                            child: viewModel.filteredProducts.isEmpty
                                ? const Center(
                                    child: Text(
                                      'Tidak ada produk atau jasa ditemukan.',
                                      style: TextStyle(
                                        fontFamily: 'Poppins',
                                        color: Colors.grey,
                                      ),
                                    ),
                                  )
                                : GridView.builder(
                                    padding: const EdgeInsets.all(16),
                                    gridDelegate:
                                        const SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: 2,
                                      childAspectRatio: 0.75,
                                      crossAxisSpacing: 16,
                                      mainAxisSpacing: 16,
                                    ),
                                    itemCount: viewModel.filteredProducts.length,
                                    itemBuilder: (context, index) {
                                      final product = viewModel.filteredProducts[index];
                                      return CustomCard(
                                        padding: EdgeInsets.zero,
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Expanded(
                                              child: ProductCard(
                                                product: product,
                                                onTap: () {
                                                  Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                      builder: (_) =>
                                                          ProductDetailPage(product: product),
                                                    ),
                                                  );
                                                },
                                              ),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.symmetric(
                                                  horizontal: 8, vertical: 4),
                                              child: Row(
                                                children: [
                                                  Container(
                                                    padding: const EdgeInsets.symmetric(
                                                        horizontal: 8, vertical: 2),
                                                    decoration: BoxDecoration(
                                                      color: product.type.toLowerCase() == 'produk'
                                                          ? Colors.orange.withOpacity(0.15)
                                                          : Colors.blue.withOpacity(0.15),
                                                      borderRadius:
                                                          BorderRadius.circular(6),
                                                    ),
                                                    child: Text(
                                                      product.type,
                                                      style: TextStyle(
                                                        fontFamily: 'Poppins',
                                                        fontWeight: FontWeight.bold,
                                                        fontSize: 12,
                                                        color: product.type.toLowerCase() == 'produk'
                                                            ? Colors.orange
                                                            : Colors.blue,
                                                      ),
                                                    ),
                                                  ),
                                                  const SizedBox(width: 6),
                                                  Container(
                                                    padding: const EdgeInsets.symmetric(
                                                        horizontal: 8, vertical: 2),
                                                    decoration: BoxDecoration(
                                                      color: Colors.grey.withOpacity(0.15),
                                                      borderRadius:
                                                          BorderRadius.circular(6),
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
                                      );
                                    },
                                  ),
                          ),
                        ],
                      ),
            bottomNavigationBar: CustomBottomNavBar(currentIndex: 1),
          );
        },
      ),
    );
  }
}

class ProductSearchDelegate extends SearchDelegate {
  final ExploreViewModel viewModel;

  ProductSearchDelegate({required this.viewModel});

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: const Icon(Icons.clear),
        onPressed: () {
          query = '';
          viewModel.filterProducts(query);
        },
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.arrow_back),
      onPressed: () => close(context, null),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    viewModel.filterProducts(query);
    viewModel.addToSearchHistory(query);
    return viewModel.filteredProducts.isEmpty
        ? const Center(
            child: Text(
              'Tidak ada produk atau jasa ditemukan.',
              style: TextStyle(
                fontFamily: 'Poppins',
                color: Colors.grey,
              ),
            ),
          )
        : GridView.builder(
            padding: const EdgeInsets.all(16),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 0.75,
              crossAxisSpacing: 16,
              mainAxisSpacing: 16,
            ),
            itemCount: viewModel.filteredProducts.length,
            itemBuilder: (context, index) {
              final product = viewModel.filteredProducts[index];
              return CustomCard(
                padding: EdgeInsets.zero,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: ProductCard(
                        product: product,
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) =>
                                  ProductDetailPage(product: product),
                            ),
                          );
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 4),
                      child: Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 8, vertical: 2),
                            decoration: BoxDecoration(
                              color: product.type.toLowerCase() == 'produk'
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
                                color: product.type.toLowerCase() == 'produk'
                                    ? Colors.orange
                                    : Colors.blue,
                              ),
                            ),
                          ),
                          const SizedBox(width: 6),
                          Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 8, vertical: 2),
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
              );
            },
          );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    viewModel.filterProducts(query);
    return ListView(
      children: viewModel.searchHistory
          .where(
            (history) => history.toLowerCase().contains(query.toLowerCase()),
          )
          .map(
            (history) => ListTile(
              title: Text(
                history,
                style: const TextStyle(
                  fontFamily: 'Poppins',
                ),
              ),
              onTap: () {
                query = history;
                viewModel.filterProducts(query);
                showResults(context);
              },
            ),
          )
          .toList(),
    );
  }
}