import 'package:flutter/foundation.dart';

class UserModel {
  final int id;
  final String name;
  final String email;
  final String phoneNumber;

  UserModel({
    required this.id,
    required this.name,
    required this.email,
    required this.phoneNumber,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    if (kDebugMode) {
      print('json in user model $json');
    }
    return UserModel(
      id: json['id'] ?? 0,
      name: json['username'] ?? '',
      email: json['email'] ?? '',
      phoneNumber: json['phone_number'] ?? '',
    );
  }
}
