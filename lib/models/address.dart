class AddressModel {
  final int addressId;
  final int userId;
  final String recipientName;
  final String phoneNumber;
  final String fullAddress;
  final String postalCode;
  final String city;
  final String province;

  AddressModel({
    required this.addressId,
    required this.userId,
    required this.recipientName,
    required this.phoneNumber,
    required this.fullAddress,
    required this.postalCode,
    required this.city,
    required this.province,
  });

  factory AddressModel.fromJson(Map<String, dynamic> json) {
    return AddressModel(
      addressId: json['address_id'] ?? 0,
      userId: json['user_id'] ?? 0,
      recipientName: json['recipient_name'] ?? '',
      phoneNumber: json['phone_number'] ?? '',
      fullAddress: json['full_address'] ?? '',
      postalCode: json['postal_code'] ?? '',
      city: json['city'] ?? '',
      province: json['province'] ?? '',
    );
  }
}