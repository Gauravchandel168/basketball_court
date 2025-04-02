import 'package:hive/hive.dart';

part 'user_model.g.dart'; // Required for Hive code generation

@HiveType(typeId: 3) // Unique identifier for this model
class UserModel extends HiveObject {
  @HiveField(0)
  final String username;

  @HiveField(1)
  final String email;

  @HiveField(2)
  final String password;

  @HiveField(3)
  final int age;

  UserModel({
    required this.username,
    required this.email,
    required this.password,
    required this.age,
  });

  // Convert from JSON
  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      username: json['username'],
      email: json['email'],
      password: json['password'],
      age: json['age'],
    );
  }

  // Convert to JSON
  Map<String, dynamic> toJson() {
    return {
      'username': username,
      'email': email,
      'password': password,
      'age': age,
    };
  }
}
