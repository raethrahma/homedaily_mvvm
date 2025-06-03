import 'package:flutter/material.dart';
import 'package:homedaily_mvvm/viewmodels/transaction_viewmodel.dart';
import 'package:homedaily_mvvm/views/screens/widgets/tab_button.dart';
import 'package:homedaily_mvvm/views/screens/widgets/transaction_item_card.dart';
import 'package:provider/provider.dart';

class TransactionPage extends StatelessWidget {
  const TransactionPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => TransactionViewModel(),
      child: Consumer<TransactionViewModel>(
        builder: (context, viewModel, child) {
          return Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.deepOrange,
              title: const Text(
                'HomeDaily',
                style: TextStyle(
                  fontFamily: 'CustomFont', // Menggunakan font kustom
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              centerTitle: true,
            ),
            body: Column(
              children: [
                Container(
                  color: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      TabButton(
                        title: 'Semua Status',
                        isSelected: viewModel.selectedTab == 'Semua Status',
                        onTap: () => viewModel.selectTab('Semua Status'),
                      ),
                      TabButton(
                        title: 'Semua Produk',
                        isSelected: viewModel.selectedTab == 'Semua Produk',
                        onTap: () => viewModel.selectTab('Semua Produk'),
                      ),
                      TabButton(
                        title: 'Semua Tanggal',
                        isSelected: viewModel.selectedTab == 'Semua Tanggal',
                        onTap: () => viewModel.selectTab('Semua Tanggal'),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: ListView.builder(
                    itemCount: viewModel.transactions.length,
                    itemBuilder: (context, index) {
                      final transaction = viewModel.transactions[index];
                      return TransactionItem(
                        transaction: transaction,
                        onBuyAgain: () => viewModel.buyAgain(transaction),
                      );
                    },
                  ),
                ),
              ],
            ),
            bottomNavigationBar: BottomNavigationBar(
              type: BottomNavigationBarType.fixed,
              items: const [
                BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
                BottomNavigationBarItem(
                  icon: Icon(Icons.search),
                  label: 'Explore',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.receipt_long),
                  label: 'Transaksi',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.shopping_cart),
                  label: 'Cart',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.favorite_border),
                  label: 'Wishlist',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.person_outline),
                  label: 'Profile',
                ),
              ],
              currentIndex: 2,
              selectedItemColor: Colors.deepOrange,
              unselectedItemColor: Colors.grey,
              showUnselectedLabels: true,
              onTap: (index) {
                switch (index) {
                  case 0:
                    Navigator.pushNamed(context, '/home');
                    break;
                  case 1:
                    Navigator.pushNamed(context, '/explore');
                    break;
                  case 2:
                    // Stay on current page
                    break;
                  case 3:
                    Navigator.pushNamed(context, '/cart');
                    break;
                  case 4:
                    Navigator.pushNamed(context, '/wishlist');
                    break;
                  case 5:
                    Navigator.pushNamed(context, '/profile');
                    break;
                }
              },
            ),
          );
        },
      ),
    );
  }
}
