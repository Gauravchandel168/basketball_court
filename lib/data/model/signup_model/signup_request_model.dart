import 'dart:convert';

/// age : 0
/// email : "string"
/// password : "string"
/// username : "string"

SignupRequestModel signupRequestModelFromJson(String str) =>
    SignupRequestModel.fromJson(json.decode(str));
String signupRequestModelToJson(SignupRequestModel data) =>
    json.encode(data.toJson());

class SignupRequestModel {
  SignupRequestModel({
    num? age,
    String? email,
    String? password,
    String? username,
  }) {
    _age = age;
    _email = email;
    _password = password;
    _username = username;
  }

  SignupRequestModel.fromJson(dynamic json) {
    _age = json['age'];
    _email = json['email'];
    _password = json['password'];
    _username = json['username'];
  }
  num? _age;
  String? _email;
  String? _password;
  String? _username;
  SignupRequestModel copyWith({
    num? age,
    String? email,
    String? password,
    String? username,
  }) =>
      SignupRequestModel(
        age: age ?? _age,
        email: email ?? _email,
        password: password ?? _password,
        username: username ?? _username,
      );
  num? get age => _age;
  String? get email => _email;
  String? get password => _password;
  String? get username => _username;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['age'] = _age;
    map['email'] = _email;
    map['password'] = _password;
    map['username'] = _username;
    return map;
  }
}
