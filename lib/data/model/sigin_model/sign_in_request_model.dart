import 'dart:convert';
/// password : "string"
/// username : "string"

SignInRequestModel signInRequestModelFromJson(String str) => SignInRequestModel.fromJson(json.decode(str));
String signInRequestModelToJson(SignInRequestModel data) => json.encode(data.toJson());
class SignInRequestModel {
  SignInRequestModel({
      String? password, 
      String? username,}){
    _password = password;
    _username = username;
}

  SignInRequestModel.fromJson(dynamic json) {
    _password = json['password'];
    _username = json['username'];
  }
  String? _password;
  String? _username;
SignInRequestModel copyWith({  String? password,
  String? username,
}) => SignInRequestModel(  password: password ?? _password,
  username: username ?? _username,
);
  String? get password => _password;
  String? get username => _username;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['password'] = _password;
    map['username'] = _username;
    return map;
  }

}