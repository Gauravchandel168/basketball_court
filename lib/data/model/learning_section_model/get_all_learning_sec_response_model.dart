import 'dart:convert';

/// learnings : [{"content":"string","createdAt":"string","id":"string","isCompleted":true,"quizzes":[{"correctOptionId":"string","createdAt":"string","id":"string","isCompleted":true,"options":[{"id":"string","text":"string"}],"question":"string","quizNumber":0,"reward":{"items":[{"icon":"string","quantity":0,"type":"string"}]},"selectedAnswerId":"string","updatedAt":"string"}],"rewards":{"items":[{"icon":"string","quantity":0,"type":"string"}],"quizRequirements":0},"updatedAt":"string","videoURL":"string"}]
/// message : "string"

GetAllLearningSecResponseModel getAllLearningSecResponseModelFromJson(
        String str) =>
    GetAllLearningSecResponseModel.fromJson(json.decode(str));
String getAllLearningSecResponseModelToJson(
        GetAllLearningSecResponseModel data) =>
    json.encode(data.toJson());

class GetAllLearningSecResponseModel {
  GetAllLearningSecResponseModel({
    List<Learnings>? learnings,
    String? message,
  }) {
    _learnings = learnings;
    _message = message;
  }

  GetAllLearningSecResponseModel.fromJson(dynamic json) {
    if (json['learnings'] != null) {
      _learnings = [];
      json['learnings'].forEach((v) {
        _learnings?.add(Learnings.fromJson(v));
      });
    }
    _message = json['message'];
  }
  List<Learnings>? _learnings;
  String? _message;
  GetAllLearningSecResponseModel copyWith({
    List<Learnings>? learnings,
    String? message,
  }) =>
      GetAllLearningSecResponseModel(
        learnings: learnings ?? _learnings,
        message: message ?? _message,
      );
  List<Learnings>? get learnings => _learnings;
  String? get message => _message;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (_learnings != null) {
      map['learnings'] = _learnings?.map((v) => v.toJson()).toList();
    }
    map['message'] = _message;
    return map;
  }
}

/// content : "string"
/// createdAt : "string"
/// id : "string"
/// isCompleted : true
/// quizzes : [{"correctOptionId":"string","createdAt":"string","id":"string","isCompleted":true,"options":[{"id":"string","text":"string"}],"question":"string","quizNumber":0,"reward":{"items":[{"icon":"string","quantity":0,"type":"string"}]},"selectedAnswerId":"string","updatedAt":"string"}]
/// rewards : {"items":[{"icon":"string","quantity":0,"type":"string"}],"quizRequirements":0}
/// updatedAt : "string"
/// videoURL : "string"

Learnings learningsFromJson(String str) => Learnings.fromJson(json.decode(str));
String learningsToJson(Learnings data) => json.encode(data.toJson());

class Learnings {
  Learnings({
    String? content,
    String? createdAt,
    String? id,
    bool? isCompleted,
    List<Quizzes>? quizzes,
    Rewards? rewards,
    String? updatedAt,
    String? videoURL,
  }) {
    _content = content;
    _createdAt = createdAt;
    _id = id;
    _isCompleted = isCompleted;
    _quizzes = quizzes;
    _rewards = rewards;
    _updatedAt = updatedAt;
    _videoURL = videoURL;
  }

  Learnings.fromJson(dynamic json) {
    _content = json['content'];
    _createdAt = json['createdAt'];
    _id = json['id'];
    _isCompleted = json['isCompleted'];
    if (json['quizzes'] != null) {
      _quizzes = [];
      json['quizzes'].forEach((v) {
        _quizzes?.add(Quizzes.fromJson(v));
      });
    }
    _rewards =
        json['rewards'] != null ? Rewards.fromJson(json['rewards']) : null;
    _updatedAt = json['updatedAt'];
    _videoURL = json['videoURL'];
  }
  String? _content;
  String? _createdAt;
  String? _id;
  bool? _isCompleted;
  List<Quizzes>? _quizzes;
  Rewards? _rewards;
  String? _updatedAt;
  String? _videoURL;
  Learnings copyWith({
    String? content,
    String? createdAt,
    String? id,
    bool? isCompleted,
    List<Quizzes>? quizzes,
    Rewards? rewards,
    String? updatedAt,
    String? videoURL,
  }) =>
      Learnings(
        content: content ?? _content,
        createdAt: createdAt ?? _createdAt,
        id: id ?? _id,
        isCompleted: isCompleted ?? _isCompleted,
        quizzes: quizzes ?? _quizzes,
        rewards: rewards ?? _rewards,
        updatedAt: updatedAt ?? _updatedAt,
        videoURL: videoURL ?? _videoURL,
      );
  String? get content => _content;
  String? get createdAt => _createdAt;
  String? get id => _id;
  bool? get isCompleted => _isCompleted;
  List<Quizzes>? get quizzes => _quizzes;
  Rewards? get rewards => _rewards;
  String? get updatedAt => _updatedAt;
  String? get videoURL => _videoURL;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['content'] = _content;
    map['createdAt'] = _createdAt;
    map['id'] = _id;
    map['isCompleted'] = _isCompleted;
    if (_quizzes != null) {
      map['quizzes'] = _quizzes?.map((v) => v.toJson()).toList();
    }
    if (_rewards != null) {
      map['rewards'] = _rewards?.toJson();
    }
    map['updatedAt'] = _updatedAt;
    map['videoURL'] = _videoURL;
    return map;
  }
}

/// items : [{"icon":"string","quantity":0,"type":"string"}]
/// quizRequirements : 0

Rewards rewardsFromJson(String str) => Rewards.fromJson(json.decode(str));
String rewardsToJson(Rewards data) => json.encode(data.toJson());

class Rewards {
  Rewards({
    List<Items>? items,
    num? quizRequirements,
  }) {
    _items = items;
    _quizRequirements = quizRequirements;
  }

  Rewards.fromJson(dynamic json) {
    if (json['items'] != null) {
      _items = [];
      json['items'].forEach((v) {
        _items?.add(Items.fromJson(v));
      });
    }
    _quizRequirements = json['quizRequirements'];
  }
  List<Items>? _items;
  num? _quizRequirements;
  Rewards copyWith({
    List<Items>? items,
    num? quizRequirements,
  }) =>
      Rewards(
        items: items ?? _items,
        quizRequirements: quizRequirements ?? _quizRequirements,
      );
  List<Items>? get items => _items;
  num? get quizRequirements => _quizRequirements;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (_items != null) {
      map['items'] = _items?.map((v) => v.toJson()).toList();
    }
    map['quizRequirements'] = _quizRequirements;
    return map;
  }
}

/// icon : "string"
/// quantity : 0
/// type : "string"

Items itemsFromJson(String str) => Items.fromJson(json.decode(str));
String itemsToJson(Items data) => json.encode(data.toJson());

class Items {
  Items({
    String? icon,
    num? quantity,
    String? type,
  }) {
    _icon = icon;
    _quantity = quantity;
    _type = type;
  }

  Items.fromJson(dynamic json) {
    _icon = json['icon'];
    _quantity = json['quantity'];
    _type = json['type'];
  }
  String? _icon;
  num? _quantity;
  String? _type;
  Items copyWith({
    String? icon,
    num? quantity,
    String? type,
  }) =>
      Items(
        icon: icon ?? _icon,
        quantity: quantity ?? _quantity,
        type: type ?? _type,
      );
  String? get icon => _icon;
  num? get quantity => _quantity;
  String? get type => _type;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['icon'] = _icon;
    map['quantity'] = _quantity;
    map['type'] = _type;
    return map;
  }
}

/// correctOptionId : "string"
/// createdAt : "string"
/// id : "string"
/// isCompleted : true
/// options : [{"id":"string","text":"string"}]
/// question : "string"
/// quizNumber : 0
/// reward : {"items":[{"icon":"string","quantity":0,"type":"string"}]}
/// selectedAnswerId : "string"
/// updatedAt : "string"

Quizzes quizzesFromJson(String str) => Quizzes.fromJson(json.decode(str));
String quizzesToJson(Quizzes data) => json.encode(data.toJson());

class Quizzes {
  Quizzes({
    String? correctOptionId,
    String? createdAt,
    String? id,
    bool? isCompleted,
    List<Options>? options,
    String? question,
    num? quizNumber,
    Reward? reward,
    String? selectedAnswerId,
    String? updatedAt,
  }) {
    _correctOptionId = correctOptionId;
    _createdAt = createdAt;
    _id = id;
    _isCompleted = isCompleted;
    _options = options;
    _question = question;
    _quizNumber = quizNumber;
    _reward = reward;
    _selectedAnswerId = selectedAnswerId;
    _updatedAt = updatedAt;
  }

  Quizzes.fromJson(dynamic json) {
    _correctOptionId = json['correctOptionId'];
    _createdAt = json['createdAt'];
    _id = json['id'];
    _isCompleted = json['isCompleted'];
    if (json['options'] != null) {
      _options = [];
      json['options'].forEach((v) {
        _options?.add(Options.fromJson(v));
      });
    }
    _question = json['question'];
    _quizNumber = json['quizNumber'];
    _reward = json['reward'] != null ? Reward.fromJson(json['reward']) : null;
    _selectedAnswerId = json['selectedAnswerId'];
    _updatedAt = json['updatedAt'];
  }
  String? _correctOptionId;
  String? _createdAt;
  String? _id;
  bool? _isCompleted;
  List<Options>? _options;
  String? _question;
  num? _quizNumber;
  Reward? _reward;
  String? _selectedAnswerId;
  String? _updatedAt;
  Quizzes copyWith({
    String? correctOptionId,
    String? createdAt,
    String? id,
    bool? isCompleted,
    List<Options>? options,
    String? question,
    num? quizNumber,
    Reward? reward,
    String? selectedAnswerId,
    String? updatedAt,
  }) =>
      Quizzes(
        correctOptionId: correctOptionId ?? _correctOptionId,
        createdAt: createdAt ?? _createdAt,
        id: id ?? _id,
        isCompleted: isCompleted ?? _isCompleted,
        options: options ?? _options,
        question: question ?? _question,
        quizNumber: quizNumber ?? _quizNumber,
        reward: reward ?? _reward,
        selectedAnswerId: selectedAnswerId ?? _selectedAnswerId,
        updatedAt: updatedAt ?? _updatedAt,
      );
  String? get correctOptionId => _correctOptionId;
  String? get createdAt => _createdAt;
  String? get id => _id;
  bool? get isCompleted => _isCompleted;
  List<Options>? get options => _options;
  String? get question => _question;
  num? get quizNumber => _quizNumber;
  Reward? get reward => _reward;
  String? get selectedAnswerId => _selectedAnswerId;
  String? get updatedAt => _updatedAt;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['correctOptionId'] = _correctOptionId;
    map['createdAt'] = _createdAt;
    map['id'] = _id;
    map['isCompleted'] = _isCompleted;
    if (_options != null) {
      map['options'] = _options?.map((v) => v.toJson()).toList();
    }
    map['question'] = _question;
    map['quizNumber'] = _quizNumber;
    if (_reward != null) {
      map['reward'] = _reward?.toJson();
    }
    map['selectedAnswerId'] = _selectedAnswerId;
    map['updatedAt'] = _updatedAt;
    return map;
  }
}

/// items : [{"icon":"string","quantity":0,"type":"string"}]

Reward rewardFromJson(String str) => Reward.fromJson(json.decode(str));
String rewardToJson(Reward data) => json.encode(data.toJson());

class Reward {
  Reward({
    List<Items>? items,
  }) {
    _items = items;
  }

  Reward.fromJson(dynamic json) {
    if (json['items'] != null) {
      _items = [];
      json['items'].forEach((v) {
        _items?.add(Items.fromJson(v));
      });
    }
  }
  List<Items>? _items;
  Reward copyWith({
    List<Items>? items,
  }) =>
      Reward(
        items: items ?? _items,
      );
  List<Items>? get items => _items;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (_items != null) {
      map['items'] = _items?.map((v) => v.toJson()).toList();
    }
    return map;
  }
}

/// icon : "string"
/// quantity : 0
/// type : "string"
//
// Items itemsFromJson(String str) => Items.fromJson(json.decode(str));
// String itemsToJson(Items data) => json.encode(data.toJson());
//
// class Items {
//   Items({
//     String? icon,
//     num? quantity,
//     String? type,
//   }) {
//     _icon = icon;
//     _quantity = quantity;
//     _type = type;
//   }
//
//   Items.fromJson(dynamic json) {
//     _icon = json['icon'];
//     _quantity = json['quantity'];
//     _type = json['type'];
//   }
//   String? _icon;
//   num? _quantity;
//   String? _type;
//   Items copyWith({
//     String? icon,
//     num? quantity,
//     String? type,
//   }) =>
//       Items(
//         icon: icon ?? _icon,
//         quantity: quantity ?? _quantity,
//         type: type ?? _type,
//       );
//   String? get icon => _icon;
//   num? get quantity => _quantity;
//   String? get type => _type;
//
//   Map<String, dynamic> toJson() {
//     final map = <String, dynamic>{};
//     map['icon'] = _icon;
//     map['quantity'] = _quantity;
//     map['type'] = _type;
//     return map;
//   }
// }

/// id : "string"
/// text : "string"

Options optionsFromJson(String str) => Options.fromJson(json.decode(str));
String optionsToJson(Options data) => json.encode(data.toJson());

class Options {
  Options({
    String? id,
    String? text,
  }) {
    _id = id;
    _text = text;
  }

  Options.fromJson(dynamic json) {
    _id = json['id'];
    _text = json['text'];
  }
  String? _id;
  String? _text;
  Options copyWith({
    String? id,
    String? text,
  }) =>
      Options(
        id: id ?? _id,
        text: text ?? _text,
      );
  String? get id => _id;
  String? get text => _text;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['text'] = _text;
    return map;
  }
}
