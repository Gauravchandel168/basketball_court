import 'dart:convert';
/// learningCompleted : {"attemptedAt":"string","createdAt":"string","id":"string","isCompleted":true,"learningId":"string","updatedAt":"string","userId":"string"}
/// message : "string"

MarkLearningCompletedResponseModel markLearningCompletedResponseModelFromJson(String str) => MarkLearningCompletedResponseModel.fromJson(json.decode(str));
String markLearningCompletedResponseModelToJson(MarkLearningCompletedResponseModel data) => json.encode(data.toJson());
class MarkLearningCompletedResponseModel {
  MarkLearningCompletedResponseModel({
      LearningCompleted? learningCompleted, 
      String? message,}){
    _learningCompleted = learningCompleted;
    _message = message;
}

  MarkLearningCompletedResponseModel.fromJson(dynamic json) {
    _learningCompleted = json['learningCompleted'] != null ? LearningCompleted.fromJson(json['learningCompleted']) : null;
    _message = json['message'];
  }
  LearningCompleted? _learningCompleted;
  String? _message;
MarkLearningCompletedResponseModel copyWith({  LearningCompleted? learningCompleted,
  String? message,
}) => MarkLearningCompletedResponseModel(  learningCompleted: learningCompleted ?? _learningCompleted,
  message: message ?? _message,
);
  LearningCompleted? get learningCompleted => _learningCompleted;
  String? get message => _message;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (_learningCompleted != null) {
      map['learningCompleted'] = _learningCompleted?.toJson();
    }
    map['message'] = _message;
    return map;
  }

}

/// attemptedAt : "string"
/// createdAt : "string"
/// id : "string"
/// isCompleted : true
/// learningId : "string"
/// updatedAt : "string"
/// userId : "string"

LearningCompleted learningCompletedFromJson(String str) => LearningCompleted.fromJson(json.decode(str));
String learningCompletedToJson(LearningCompleted data) => json.encode(data.toJson());
class LearningCompleted {
  LearningCompleted({
      String? attemptedAt, 
      String? createdAt, 
      String? id, 
      bool? isCompleted, 
      String? learningId, 
      String? updatedAt, 
      String? userId,}){
    _attemptedAt = attemptedAt;
    _createdAt = createdAt;
    _id = id;
    _isCompleted = isCompleted;
    _learningId = learningId;
    _updatedAt = updatedAt;
    _userId = userId;
}

  LearningCompleted.fromJson(dynamic json) {
    _attemptedAt = json['attemptedAt'];
    _createdAt = json['createdAt'];
    _id = json['id'];
    _isCompleted = json['isCompleted'];
    _learningId = json['learningId'];
    _updatedAt = json['updatedAt'];
    _userId = json['userId'];
  }
  String? _attemptedAt;
  String? _createdAt;
  String? _id;
  bool? _isCompleted;
  String? _learningId;
  String? _updatedAt;
  String? _userId;
LearningCompleted copyWith({  String? attemptedAt,
  String? createdAt,
  String? id,
  bool? isCompleted,
  String? learningId,
  String? updatedAt,
  String? userId,
}) => LearningCompleted(  attemptedAt: attemptedAt ?? _attemptedAt,
  createdAt: createdAt ?? _createdAt,
  id: id ?? _id,
  isCompleted: isCompleted ?? _isCompleted,
  learningId: learningId ?? _learningId,
  updatedAt: updatedAt ?? _updatedAt,
  userId: userId ?? _userId,
);
  String? get attemptedAt => _attemptedAt;
  String? get createdAt => _createdAt;
  String? get id => _id;
  bool? get isCompleted => _isCompleted;
  String? get learningId => _learningId;
  String? get updatedAt => _updatedAt;
  String? get userId => _userId;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['attemptedAt'] = _attemptedAt;
    map['createdAt'] = _createdAt;
    map['id'] = _id;
    map['isCompleted'] = _isCompleted;
    map['learningId'] = _learningId;
    map['updatedAt'] = _updatedAt;
    map['userId'] = _userId;
    return map;
  }

}