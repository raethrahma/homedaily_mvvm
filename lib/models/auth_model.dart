class AuthModel {
  final int? id;
  final String name;
  final String email;
  final String? createdAt;
  final String? updatedAt;
  final String? googleId;

  AuthModel({
    this.id,
    required this.name,
    required this.email,
    this.createdAt,
    this.updatedAt,
    this.googleId,
  });

  factory AuthModel.fromJson(Map<String, dynamic> json) {
    return AuthModel(
      id: json['user_id'],
      name: json['name'],
      email: json['email'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
      googleId: json['google_id'],
    );
  }
}
