import 'dart:convert';
/// appId : "string"
/// channelId : "string"
/// message : "string"
/// status : true
/// token : "string"

GetAgoraTokenAndChannelModel getAgoraTokenAndChannelModelFromJson(String str) => GetAgoraTokenAndChannelModel.fromJson(json.decode(str));
String getAgoraTokenAndChannelModelToJson(GetAgoraTokenAndChannelModel data) => json.encode(data.toJson());
class GetAgoraTokenAndChannelModel {
  GetAgoraTokenAndChannelModel({
      String? appId, 
      String? channelId, 
      String? message, 
      bool? status, 
      String? token,}){
    _appId = appId;
    _channelId = channelId;
    _message = message;
    _status = status;
    _token = token;
}

  GetAgoraTokenAndChannelModel.fromJson(dynamic json) {
    _appId = json['appId'];
    _channelId = json['channelId'];
    _message = json['message'];
    _status = json['status'];
    _token = json['token'];
  }
  String? _appId;
  String? _channelId;
  String? _message;
  bool? _status;
  String? _token;
GetAgoraTokenAndChannelModel copyWith({  String? appId,
  String? channelId,
  String? message,
  bool? status,
  String? token,
}) => GetAgoraTokenAndChannelModel(  appId: appId ?? _appId,
  channelId: channelId ?? _channelId,
  message: message ?? _message,
  status: status ?? _status,
  token: token ?? _token,
);
  String? get appId => _appId;
  String? get channelId => _channelId;
  String? get message => _message;
  bool? get status => _status;
  String? get token => _token;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['appId'] = _appId;
    map['channelId'] = _channelId;
    map['message'] = _message;
    map['status'] = _status;
    map['token'] = _token;
    return map;
  }

}