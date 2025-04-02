import 'dart:convert';
/// message : "string"
/// userProfile : {"createdAt":"string","id":"string","level":0,"tickets":0,"updatedAt":"string","userId":"string"}

BuyPrizesResponseModel buyPrizesResponseModelFromJson(String str) => BuyPrizesResponseModel.fromJson(json.decode(str));
String buyPrizesResponseModelToJson(BuyPrizesResponseModel data) => json.encode(data.toJson());
class BuyPrizesResponseModel {
  BuyPrizesResponseModel({
      String? message, 
      UserProfile? userProfile,}){
    _message = message;
    _userProfile = userProfile;
}

  BuyPrizesResponseModel.fromJson(dynamic json) {
    _message = json['message'];
    _userProfile = json['userProfile'] != null ? UserProfile.fromJson(json['userProfile']) : null;
  }
  String? _message;
  UserProfile? _userProfile;
BuyPrizesResponseModel copyWith({  String? message,
  UserProfile? userProfile,
}) => BuyPrizesResponseModel(  message: message ?? _message,
  userProfile: userProfile ?? _userProfile,
);
  String? get message => _message;
  UserProfile? get userProfile => _userProfile;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['message'] = _message;
    if (_userProfile != null) {
      map['userProfile'] = _userProfile?.toJson();
    }
    return map;
  }

}

/// createdAt : "string"
/// id : "string"
/// level : 0
/// tickets : 0
/// updatedAt : "string"
/// userId : "string"

UserProfile userProfileFromJson(String str) => UserProfile.fromJson(json.decode(str));
String userProfileToJson(UserProfile data) => json.encode(data.toJson());
class UserProfile {
  UserProfile({
      String? createdAt, 
      String? id, 
      num? level, 
      num? tickets, 
      String? updatedAt, 
      String? userId,}){
    _createdAt = createdAt;
    _id = id;
    _level = level;
    _tickets = tickets;
    _updatedAt = updatedAt;
    _userId = userId;
}

  UserProfile.fromJson(dynamic json) {
    _createdAt = json['createdAt'];
    _id = json['id'];
    _level = json['level'];
    _tickets = json['tickets'];
    _updatedAt = json['updatedAt'];
    _userId = json['userId'];
  }
  String? _createdAt;
  String? _id;
  num? _level;
  num? _tickets;
  String? _updatedAt;
  String? _userId;
UserProfile copyWith({  String? createdAt,
  String? id,
  num? level,
  num? tickets,
  String? updatedAt,
  String? userId,
}) => UserProfile(  createdAt: createdAt ?? _createdAt,
  id: id ?? _id,
  level: level ?? _level,
  tickets: tickets ?? _tickets,
  updatedAt: updatedAt ?? _updatedAt,
  userId: userId ?? _userId,
);
  String? get createdAt => _createdAt;
  String? get id => _id;
  num? get level => _level;
  num? get tickets => _tickets;
  String? get updatedAt => _updatedAt;
  String? get userId => _userId;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['createdAt'] = _createdAt;
    map['id'] = _id;
    map['level'] = _level;
    map['tickets'] = _tickets;
    map['updatedAt'] = _updatedAt;
    map['userId'] = _userId;
    return map;
  }

}