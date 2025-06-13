class AuthModel {
  final int? id;
  final String name;
  final String email;
  final String? createdAt;
  final String? updatedAt;
  final String? googleId;
  final String? token;

  AuthModel({
    this.id,
    required this.name,
    required this.email,
    this.createdAt,
    this.updatedAt,
    this.googleId,
    this.token,
  });

  factory AuthModel.fromJson(Map<String, dynamic> json, {String? token}) {
    return AuthModel(
      id: json['user_id'],
      name: json['name'],
      email: json['email'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
      googleId: json['google_id'],
      token: token, // Use passed token instead of json['token']
    );
  }
}
