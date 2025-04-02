import 'dart:convert';

/// token : ""
/// timestamp : ""

AuthTokenModel authTokenModelFromJson(String str) =>
    AuthTokenModel.fromJson(json.decode(str));
String authTokenModelToJson(AuthTokenModel data) => json.encode(data.toJson());

class AuthTokenModel {
  AuthTokenModel({
    String? token,
    String? timestamp,
  }) {
    _token = token;
    _timestamp = timestamp;
  }

  AuthTokenModel.fromJson(dynamic json) {
    _token = json['token'];
    _timestamp = json['timestamp'];
  }
  String? _token;
  String? _timestamp;
  AuthTokenModel copyWith({
    String? token,
    String? timestamp,
  }) =>
      AuthTokenModel(
        token: token ?? _token,
        timestamp: timestamp ?? _timestamp,
      );
  String? get token => _token;
  String? get timestamp => _timestamp;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['token'] = _token;
    map['timestamp'] = _timestamp;
    return map;
  }
}
