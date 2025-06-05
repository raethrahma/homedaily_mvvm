import 'package:flutter/material.dart';
import 'package:homedaily_mvvm/viewmodels/explore_viewmodel.dart';
import 'package:homedaily_mvvm/views/screens/widgets/product_card.dart';
import 'package:provider/provider.dart';
import 'package:homedaily_mvvm/views/screens/widgets/custom_bottom_navbar.dart';

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
                  fontFamily: 'CustomFont', // Menggunakan font kustom
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              backgroundColor: Colors.deepOrange,
              actions: [
                IconButton(
                  icon: const Icon(Icons.search, color: Colors.white),
                  onPressed: () {
                    showSearch(
                      context: context,
                      delegate: ProductSearchDelegate(viewModel: viewModel),
                    );
                  },
                ),
              ],
            ),
            body: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: DropdownButton<String>(
                    isExpanded: true,
                    value: viewModel.selectedFilter,
                    items:
                        viewModel.filters
                            .map(
                              (filter) => DropdownMenuItem(
                                value: filter,
                                child: Text(
                                  filter,
                                  style: const TextStyle(
                                    fontFamily:
                                        'CustomFont', // Menggunakan font kustom
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
                            fontFamily: 'CustomFont', // Menggunakan font kustom
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Wrap(
                          spacing: 8,
                          children:
                              viewModel.searchHistory
                                  .map(
                                    (query) => Chip(
                                      label: Text(
                                        query,
                                        style: const TextStyle(
                                          fontFamily:
                                              'CustomFont', // Menggunakan font kustom
                                        ),
                                      ),
                                      onDeleted:
                                          () => viewModel.removeSearchHistory(
                                            query,
                                          ),
                                    ),
                                  )
                                  .toList(),
                        ),
                      ],
                    ),
                  ),
                Expanded(
                  child: GridView.builder(
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
                      return ProductCard(product: product);
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
    return GridView.builder(
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
        return ProductCard(product: product);
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    viewModel.filterProducts(query);
    return ListView(
      children:
          viewModel.searchHistory
              .where(
                (history) =>
                    history.toLowerCase().contains(query.toLowerCase()),
              )
              .map(
                (history) => ListTile(
                  title: Text(
                    history,
                    style: const TextStyle(
                      fontFamily: 'CustomFont', // Menggunakan font kustom
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
