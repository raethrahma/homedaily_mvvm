class Address {
  final String id; // Tambahkan ID untuk identifikasi unik
  final String name;
  final String phone;
  final String address;
  final String label;
  final String status;

  Address({
    required this.id,
    required this.name,
    required this.phone,
    required this.address,
    required this.label,
    required this.status,
  });

  factory Address.fromJson(Map<String, dynamic> json) {
    return Address(
      id: json['id'] as String,
      name: json['name'] as String,
      phone: json['phone'] as String,
      address: json['address'] as String,
      label: json['label'] as String,
      status: json['status'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'phone': phone,
      'address': address,
      'label': label,
      'status': status,
    };
  }
}
