class UserModel {
  final String? name;
  final String? email;
  final String? password;
  final String? avatar;
  final DateTime? createdAt; // Thêm trường createdAt

  UserModel({
    this.name,
    required this.email,
    required this.password,
    this.avatar,
    this.createdAt, // Thêm trường createdAt vào constructor
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      name: json['name'],
      email: json['email'],
      password: json['password'],
      avatar: json['avatar'],
      createdAt: json['createdAt']!.toDate(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'email': email,
      'password': password,
      'avatar': avatar,
      'createdAt': createdAt,
    };
  }
}
