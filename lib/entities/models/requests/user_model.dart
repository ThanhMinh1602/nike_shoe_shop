import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  final String? name;
  final String? email;
  final String? password;
  final String? avatar;
  final Timestamp? createdAt;

  UserModel({
    this.name,
    required this.email,
    required this.password,
    this.avatar,
    this.createdAt,
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
      'createdAt': Timestamp.now(),
    };
  }
}
