class Address {
  final String id;
  final String name;
  final String phone;
  final String address;
  final String label;
  final String status;
  final String type; // 'Rumah', 'Kantor', dll

  Address({
    required this.id,
    required this.name,
    required this.phone,
    required this.address,
    required this.label,
    required this.status,
    required this.type,
  });

  Address copyWith({
    String? id,
    String? name,
    String? phone,
    String? address,
    String? label,
    String? status,
    String? type,
  }) {
    return Address(
      id: id ?? this.id,
      name: name ?? this.name,
      phone: phone ?? this.phone,
      address: address ?? this.address,
      label: label ?? this.label,
      status: status ?? this.status,
      type: type ?? this.type,
    );
  }
}