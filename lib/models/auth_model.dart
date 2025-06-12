class AuthModel {
  final String name;
  final String email;
  final String? phone;
  final String password;
  final String? token;

  AuthModel({
    required this.name,
    required this.email,
    this.phone,
    required this.password,
    this.token,
  });

  factory AuthModel.fromJson(Map<String, dynamic> json) {
    return AuthModel(
      name: json['name'] ?? '',
      email: json['email'] ?? '',
      phone: json['phone'],
      password: json['password'] ?? '',
      token: json['token'],
    );
  }

  Map<String, dynamic> toJson() {
    return {'name': name, 'email': email, 'phone': phone, 'password': password};
  }
}
