import 'package:flutter/material.dart';
import '../models/address.dart';

class AddressViewModel extends ChangeNotifier {
  final List<Address> _addresses = [
    Address(
      id: '1',
      name: 'John Doe',
      phone: '123456789',
      address: 'Jl. Merdeka No.123, Jakarta',
      label: 'Rumah',
      status: 'Utama',
    ),
    Address(
      id: '2',
      name: 'Jane Doe',
      phone: '987654321',
      address: 'Jl. Sudirman No.456, Bandung',
      label: 'Kantor',
      status: '',
    ),
  ];

  List<Address> get addresses => _addresses;

  void showEditDialog(BuildContext context, int index) {
    final address = _addresses[index];
    TextEditingController nameController = TextEditingController(
      text: address.name,
    );
    TextEditingController phoneController = TextEditingController(
      text: address.phone,
    );
    TextEditingController addressController = TextEditingController(
      text: address.address,
    );
    TextEditingController labelController = TextEditingController(
      text: address.label,
    );

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Edit Alamat'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: nameController,
                decoration: const InputDecoration(labelText: 'Nama'),
              ),
              TextField(
                controller: phoneController,
                decoration: const InputDecoration(labelText: 'Telepon'),
              ),
              TextField(
                controller: addressController,
                decoration: const InputDecoration(labelText: 'Alamat'),
              ),
              TextField(
                controller: labelController,
                decoration: const InputDecoration(labelText: 'Label'),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Batal'),
            ),
            TextButton(
              onPressed: () {
                _addresses[index] = Address(
                  id: address.id,
                  name: nameController.text,
                  phone: phoneController.text,
                  address: addressController.text,
                  label: labelController.text,
                  status: address.status,
                );
                notifyListeners();
                Navigator.pop(context);
              },
              child: const Text('Simpan'),
            ),
          ],
        );
      },
    );
  }

  void showAddDialog(BuildContext context) {
    TextEditingController nameController = TextEditingController();
    TextEditingController phoneController = TextEditingController();
    TextEditingController addressController = TextEditingController();
    TextEditingController labelController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Tambah Alamat'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: nameController,
                decoration: const InputDecoration(labelText: 'Nama'),
              ),
              TextField(
                controller: phoneController,
                decoration: const InputDecoration(labelText: 'Telepon'),
              ),
              TextField(
                controller: addressController,
                decoration: const InputDecoration(labelText: 'Alamat'),
              ),
              TextField(
                controller: labelController,
                decoration: const InputDecoration(labelText: 'Label'),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Batal'),
            ),
            TextButton(
              onPressed: () {
                _addresses.add(
                  Address(
                    id: DateTime.now().millisecondsSinceEpoch.toString(),
                    name: nameController.text,
                    phone: phoneController.text,
                    address: addressController.text,
                    label: labelController.text,
                    status: '',
                  ),
                );
                notifyListeners();
                Navigator.pop(context);
              },
              child: const Text('Tambah'),
            ),
          ],
        );
      },
    );
  }
}
