class UserModel {
  final String id;
  final String email;
  final String role;

  UserModel({required this.id, required this.email, required this.role});

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        id: json['id'] ?? '',
        email: json['email'] ?? '',
        role: json['role'] ?? 'employee',
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'email': email,
        'role': role,
      };
}
