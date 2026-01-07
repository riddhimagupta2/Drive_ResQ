class UserModel {
  final String id;
  final String email;
  final String name;
  final String phone;
  final String role;

  UserModel({
    required this.id,
    required this.email,
    required this.name,
    required this.phone,
    required this.role,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['auth_id'] ?? '',
      email: json['email'] ?? '',
      name: json['name'] ?? '',
      phone: json['phone'] ?? '',
      role: json['role'] ?? 'driver',
    );
  }

  Map<String, dynamic> toJson() => {
    'auth_id': id,
    'email': email,
    'name': name,
    'phone': phone,
    'role': role,
  };
}
