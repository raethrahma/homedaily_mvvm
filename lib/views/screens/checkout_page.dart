import 'package:flutter/material.dart';
import 'package:homedaily_mvvm/viewmodels/checkout_viewmodel.dart';
import 'package:homedaily_mvvm/views/screens/widgets/order_item_card.dart';
import 'package:provider/provider.dart';

class CheckoutPage extends StatelessWidget {
  const CheckoutPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => CheckoutViewModel(),
      child: Consumer<CheckoutViewModel>(
        builder: (context, viewModel, child) {
          return Scaffold(
            appBar: AppBar(
              title: const Text(
                'Checkout',
                style: TextStyle(
                  fontFamily: 'CustomFont', // Menggunakan font kustom
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              backgroundColor: Colors.deepOrange,
            ),
            body: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(16),
                    child: const Text(
                      'Order Summary',
                      style: TextStyle(
                        fontFamily: 'CustomFont', // Menggunakan font kustom
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                  ),
                  ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: viewModel.orderItems.length,
                    itemBuilder: (context, index) {
                      final item = viewModel.orderItems[index];
                      return OrderItemCard(cartItem: item);
                    },
                  ),
                  const Divider(),
                  Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Shipping Address',
                          style: TextStyle(
                            fontFamily: 'CustomFont', // Menggunakan font kustom
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ),
                        ),
                        const SizedBox(height: 8),
                        DropdownButton<String>(
                          isExpanded: true,
                          value: viewModel.selectedAddress,
                          hint: const Text(
                            'Select Address',
                            style: TextStyle(
                              fontFamily:
                                  'CustomFont', // Menggunakan font kustom
                            ),
                          ),
                          items:
                              viewModel.availableAddresses
                                  .map(
                                    (address) => DropdownMenuItem(
                                      value: address,
                                      child: Text(
                                        address,
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
                              viewModel.selectAddress(value);
                            }
                          },
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.pushNamed(context, '/address_management');
                          },
                          child: const Text(
                            'Add New Address',
                            style: TextStyle(
                              fontFamily:
                                  'CustomFont', // Menggunakan font kustom
                              color: Colors.blue,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const Divider(),
                  Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Payment Method',
                          style: TextStyle(
                            fontFamily: 'CustomFont', // Menggunakan font kustom
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ),
                        ),
                        const SizedBox(height: 8),
                        DropdownButton<String>(
                          isExpanded: true,
                          value: viewModel.selectedPaymentMethod,
                          hint: const Text(
                            'Select Payment Method',
                            style: TextStyle(
                              fontFamily:
                                  'CustomFont', // Menggunakan font kustom
                            ),
                          ),
                          items:
                              viewModel.paymentMethods
                                  .map(
                                    (method) => DropdownMenuItem(
                                      value: method['name'] as String,
                                      child: Text(
                                        method['name'] as String,
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
                              viewModel.selectPaymentMethod(value);
                            }
                          },
                        ),
                      ],
                    ),
                  ),
                  const Divider(),
                  Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              'Total',
                              style: TextStyle(
                                fontFamily:
                                    'CustomFont', // Menggunakan font kustom
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                              ),
                            ),
                            Text(
                              viewModel.getTotal(),
                              style: const TextStyle(
                                fontFamily:
                                    'CustomFont', // Menggunakan font kustom
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                                color: Colors.deepOrange,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 16),
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.deepOrange,
                              padding: const EdgeInsets.symmetric(vertical: 16),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                            onPressed: viewModel.placeOrder,
                            child: const Text(
                              'Place Order',
                              style: TextStyle(
                                fontFamily:
                                    'CustomFont', // Menggunakan font kustom
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
