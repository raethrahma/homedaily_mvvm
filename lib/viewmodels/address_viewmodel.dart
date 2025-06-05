import 'package:flutter/material.dart';
import 'package:homedaily_mvvm/models/address.dart';


class AddressViewModel extends ChangeNotifier {
  final List<Address> _addresses = [
    Address(
      id: '1',
      name: 'John Doe',
      phone: '123456789',
      address: 'Jl. Merdeka No.123, Jakarta',
      label: 'Rumah',
      status: 'Utama',
      type: 'Rumah', // Tambahkan type, misal: 'Rumah' atau 'Kantor'
    ),
    Address(
      id: '2',
      name: 'Jane Doe',
      phone: '987654321',
      address: 'Jl. Sudirman No.456, Bandung',
      label: 'Kantor',
      status: '',
      type: 'Kantor',
    ),
  ];

  List<Address> get addresses => _addresses;

  void editAddress(int index, Address newAddress) {
    _addresses[index] = newAddress;
    notifyListeners();
  }

  void addAddress(Address address) {
    _addresses.add(address);
    notifyListeners();
  }

  void removeAddress(int index) {
    _addresses.removeAt(index);
    notifyListeners();
  }

  void setPrimary(int index) {
    for (var i = 0; i < _addresses.length; i++) {
      _addresses[i] = _addresses[i].copyWith(status: i == index ? 'Utama' : '');
    }
    notifyListeners();
  }

  // Dialog helpers (opsional, bisa dipanggil dari UI)
  void showEditDialog(BuildContext context, int index) {
    final address = _addresses[index];
    final nameController = TextEditingController(text: address.name);
    final phoneController = TextEditingController(text: address.phone);
    final addressController = TextEditingController(text: address.address);
    final labelController = TextEditingController(text: address.label);
    final typeController = TextEditingController(text: address.type);

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Edit Alamat'),
          content: SingleChildScrollView(
            child: Column(
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
                TextField(
                  controller: typeController,
                  decoration: const InputDecoration(labelText: 'Tipe (Rumah/Kantor)'),
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Batal'),
            ),
            TextButton(
              onPressed: () {
                editAddress(
                  index,
                  address.copyWith(
                    name: nameController.text,
                    phone: phoneController.text,
                    address: addressController.text,
                    label: labelController.text,
                    type: typeController.text,
                  ),
                );
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
    final nameController = TextEditingController();
    final phoneController = TextEditingController();
    final addressController = TextEditingController();
    final labelController = TextEditingController();
    final typeController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Tambah Alamat'),
          content: SingleChildScrollView(
            child: Column(
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
                TextField(
                  controller: typeController,
                  decoration: const InputDecoration(labelText: 'Tipe (Rumah/Kantor)'),
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Batal'),
            ),
            TextButton(
              onPressed: () {
                addAddress(
                  Address(
                    id: DateTime.now().millisecondsSinceEpoch.toString(),
                    name: nameController.text,
                    phone: phoneController.text,
                    address: addressController.text,
                    label: labelController.text,
                    status: '',
                    type: typeController.text,
                  ),
                );
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