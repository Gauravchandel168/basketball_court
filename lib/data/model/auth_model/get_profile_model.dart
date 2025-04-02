import 'dart:convert';
/// message : "string"
/// user : {"age":0,"email":"string","id":"string","profileURL":"string","role":"string","username":"string"}

GetProfileModel getProfileModelFromJson(String str) => GetProfileModel.fromJson(json.decode(str));
String getProfileModelToJson(GetProfileModel data) => json.encode(data.toJson());
class GetProfileModel {
  GetProfileModel({
      String? message, 
      User? user,}){
    _message = message;
    _user = user;
}

  GetProfileModel.fromJson(dynamic json) {
    _message = json['message'];
    _user = json['user'] != null ? User.fromJson(json['user']) : null;
  }
  String? _message;
  User? _user;
GetProfileModel copyWith({  String? message,
  User? user,
}) => GetProfileModel(  message: message ?? _message,
  user: user ?? _user,
);
  String? get message => _message;
  User? get user => _user;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['message'] = _message;
    if (_user != null) {
      map['user'] = _user?.toJson();
    }
    return map;
  }

}

/// age : 0
/// email : "string"
/// id : "string"
/// profileURL : "string"
/// role : "string"
/// username : "string"

User userFromJson(String str) => User.fromJson(json.decode(str));
String userToJson(User data) => json.encode(data.toJson());
class User {
  User({
      num? age, 
      String? email, 
      String? id, 
      String? profileURL, 
      String? role, 
      String? username,}){
    _age = age;
    _email = email;
    _id = id;
    _profileURL = profileURL;
    _role = role;
    _username = username;
}

  User.fromJson(dynamic json) {
    _age = json['age'];
    _email = json['email'];
    _id = json['id'];
    _profileURL = json['profileURL'];
    _role = json['role'];
    _username = json['username'];
  }
  num? _age;
  String? _email;
  String? _id;
  String? _profileURL;
  String? _role;
  String? _username;
User copyWith({  num? age,
  String? email,
  String? id,
  String? profileURL,
  String? role,
  String? username,
}) => User(  age: age ?? _age,
  email: email ?? _email,
  id: id ?? _id,
  profileURL: profileURL ?? _profileURL,
  role: role ?? _role,
  username: username ?? _username,
);
  num? get age => _age;
  String? get email => _email;
  String? get id => _id;
  String? get profileURL => _profileURL;
  String? get role => _role;
  String? get username => _username;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['age'] = _age;
    map['email'] = _email;
    map['id'] = _id;
    map['profileURL'] = _profileURL;
    map['role'] = _role;
    map['username'] = _username;
    return map;
  }

}