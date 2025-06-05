import 'package:flutter/material.dart';
import 'package:homedaily_mvvm/viewmodels/transaction_viewmodel.dart';
import 'package:homedaily_mvvm/views/screens/widgets/tab_button.dart';
import 'package:homedaily_mvvm/views/screens/widgets/transaction_item_card.dart';
import 'package:provider/provider.dart';
import 'package:homedaily_mvvm/views/screens/widgets/custom_bottom_navbar.dart';

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
            bottomNavigationBar: CustomBottomNavBar(currentIndex: 2),
          );
        },
      ),
    );
  }
}
