import 'dart:convert';

/// accessToken : "string"
/// refreshToken : "string"
/// role : "string"
/// user : {"age":0,"email":"string","id":"string","role":"string","username":"string"}

SignInResponse signInResponseFromJson(String str) =>
    SignInResponse.fromJson(json.decode(str));
String signInResponseToJson(SignInResponse data) => json.encode(data.toJson());

class SignInResponse {
  SignInResponse({
    String? accessToken,
    String? refreshToken,
    String? role,
    User? user,
  }) {
    _accessToken = accessToken;
    _refreshToken = refreshToken;
    _role = role;
    _user = user;
  }

  SignInResponse.fromJson(dynamic json) {
    _accessToken = json['accessToken'];
    _refreshToken = json['refreshToken'];
    _role = json['role'];
    _user = json['user'] != null ? User.fromJson(json['user']) : null;
  }
  String? _accessToken;
  String? _refreshToken;
  String? _role;
  User? _user;
  SignInResponse copyWith({
    String? accessToken,
    String? refreshToken,
    String? role,
    User? user,
  }) =>
      SignInResponse(
        accessToken: accessToken ?? _accessToken,
        refreshToken: refreshToken ?? _refreshToken,
        role: role ?? _role,
        user: user ?? _user,
      );
  String? get accessToken => _accessToken;
  String? get refreshToken => _refreshToken;
  String? get role => _role;
  User? get user => _user;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['accessToken'] = _accessToken;
    map['refreshToken'] = _refreshToken;
    map['role'] = _role;
    if (_user != null) {
      map['user'] = _user?.toJson();
    }
    return map;
  }
}

/// age : 0
/// email : "string"
/// id : "string"
/// role : "string"
/// username : "string"

User userFromJson(String str) => User.fromJson(json.decode(str));
String userToJson(User data) => json.encode(data.toJson());

class User {
  User({
    num? age,
    String? email,
    String? id,
    String? role,
    String? username,
  }) {
    _age = age;
    _email = email;
    _id = id;
    _role = role;
    _username = username;
  }

  User.fromJson(dynamic json) {
    _age = json['age'];
    _email = json['email'];
    _id = json['id'];
    _role = json['role'];
    _username = json['username'];
  }
  num? _age;
  String? _email;
  String? _id;
  String? _role;
  String? _username;
  User copyWith({
    num? age,
    String? email,
    String? id,
    String? role,
    String? username,
  }) =>
      User(
        age: age ?? _age,
        email: email ?? _email,
        id: id ?? _id,
        role: role ?? _role,
        username: username ?? _username,
      );
  num? get age => _age;
  String? get email => _email;
  String? get id => _id;
  String? get role => _role;
  String? get username => _username;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['age'] = _age;
    map['email'] = _email;
    map['id'] = _id;
    map['role'] = _role;
    map['username'] = _username;
    return map;
  }
}
