class AuthModel {
  final int? id;
  final String name;
  final String email;
  final String? phone;
  final String? token;
  final String? role;

  AuthModel({
    this.id,
    required this.name,
    required this.email,
    this.phone,
    this.token,
    this.role,
  });

  factory AuthModel.fromJson(Map<String, dynamic> json) {
    return AuthModel(
      id: json['id'],
      name: json['name'] ?? '',
      email: json['email'] ?? '',
      phone: json['phone'],
      token: json['token'],
      role: json['role'],
    );
  }

  Map<String, dynamic> toJson() {
    return {'name': name, 'email': email, 'phone': phone};
  }
}
