import 'dart:convert';
/// message : "string"
/// prizes : [{"cost":0,"createdAt":"string","description":"string","id":"string","images":["string"],"name":"string","stock":0,"unlockRequirements":{"level":0},"updatedAt":"string"}]

GetAllPrizeModel getAllPrizeModelFromJson(String str) => GetAllPrizeModel.fromJson(json.decode(str));
String getAllPrizeModelToJson(GetAllPrizeModel data) => json.encode(data.toJson());
class GetAllPrizeModel {
  GetAllPrizeModel({
      String? message, 
      List<Prizes>? prizes,}){
    _message = message;
    _prizes = prizes;
}

  GetAllPrizeModel.fromJson(dynamic json) {
    _message = json['message'];
    if (json['prizes'] != null) {
      _prizes = [];
      json['prizes'].forEach((v) {
        _prizes?.add(Prizes.fromJson(v));
      });
    }
  }
  String? _message;
  List<Prizes>? _prizes;
GetAllPrizeModel copyWith({  String? message,
  List<Prizes>? prizes,
}) => GetAllPrizeModel(  message: message ?? _message,
  prizes: prizes ?? _prizes,
);
  String? get message => _message;
  List<Prizes>? get prizes => _prizes;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['message'] = _message;
    if (_prizes != null) {
      map['prizes'] = _prizes?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

/// cost : 0
/// createdAt : "string"
/// description : "string"
/// id : "string"
/// images : ["string"]
/// name : "string"
/// stock : 0
/// unlockRequirements : {"level":0}
/// updatedAt : "string"

Prizes prizesFromJson(String str) => Prizes.fromJson(json.decode(str));
String prizesToJson(Prizes data) => json.encode(data.toJson());
class Prizes {
  Prizes({
      num? cost, 
      String? createdAt, 
      String? description, 
      String? id, 
      List<String>? images, 
      String? name, 
      num? stock, 
      UnlockRequirements? unlockRequirements, 
      String? updatedAt,}){
    _cost = cost;
    _createdAt = createdAt;
    _description = description;
    _id = id;
    _images = images;
    _name = name;
    _stock = stock;
    _unlockRequirements = unlockRequirements;
    _updatedAt = updatedAt;
}

  Prizes.fromJson(dynamic json) {
    _cost = json['cost'];
    _createdAt = json['createdAt'];
    _description = json['description'];
    _id = json['id'];
    _images = json['images'] != null ? json['images'].cast<String>() : [];
    _name = json['name'];
    _stock = json['stock'];
    _unlockRequirements = json['unlockRequirements'] != null ? UnlockRequirements.fromJson(json['unlockRequirements']) : null;
    _updatedAt = json['updatedAt'];
  }
  num? _cost;
  String? _createdAt;
  String? _description;
  String? _id;
  List<String>? _images;
  String? _name;
  num? _stock;
  UnlockRequirements? _unlockRequirements;
  String? _updatedAt;
Prizes copyWith({  num? cost,
  String? createdAt,
  String? description,
  String? id,
  List<String>? images,
  String? name,
  num? stock,
  UnlockRequirements? unlockRequirements,
  String? updatedAt,
}) => Prizes(  cost: cost ?? _cost,
  createdAt: createdAt ?? _createdAt,
  description: description ?? _description,
  id: id ?? _id,
  images: images ?? _images,
  name: name ?? _name,
  stock: stock ?? _stock,
  unlockRequirements: unlockRequirements ?? _unlockRequirements,
  updatedAt: updatedAt ?? _updatedAt,
);
  num? get cost => _cost;
  String? get createdAt => _createdAt;
  String? get description => _description;
  String? get id => _id;
  List<String>? get images => _images;
  String? get name => _name;
  num? get stock => _stock;
  UnlockRequirements? get unlockRequirements => _unlockRequirements;
  String? get updatedAt => _updatedAt;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['cost'] = _cost;
    map['createdAt'] = _createdAt;
    map['description'] = _description;
    map['id'] = _id;
    map['images'] = _images;
    map['name'] = _name;
    map['stock'] = _stock;
    if (_unlockRequirements != null) {
      map['unlockRequirements'] = _unlockRequirements?.toJson();
    }
    map['updatedAt'] = _updatedAt;
    return map;
  }

}

/// level : 0

UnlockRequirements unlockRequirementsFromJson(String str) => UnlockRequirements.fromJson(json.decode(str));
String unlockRequirementsToJson(UnlockRequirements data) => json.encode(data.toJson());
class UnlockRequirements {
  UnlockRequirements({
      num? level,}){
    _level = level;
}

  UnlockRequirements.fromJson(dynamic json) {
    _level = json['level'];
  }
  num? _level;
UnlockRequirements copyWith({  num? level,
}) => UnlockRequirements(  level: level ?? _level,
);
  num? get level => _level;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['level'] = _level;
    return map;
  }

}