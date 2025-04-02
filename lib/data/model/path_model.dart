import 'dart:convert';
/// path : ""

PathModel pathModelFromJson(String str) => PathModel.fromJson(json.decode(str));
String pathModelToJson(PathModel data) => json.encode(data.toJson());
class PathModel {
  PathModel({
      String? path,int? duration}){
    _path = path;
    _duration=duration;
}

  PathModel.fromJson(dynamic json) {
    _path = json['path'];
    _duration=json['duration'];
  }
  String? _path;
  int? _duration;
PathModel copyWith({  String? path,
  int? duration
}) => PathModel(  path: path ?? _path,
  duration:duration??_duration
);
  String? get path => _path;
  int? get duration=>_duration;
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['path'] = _path;
    map['duration']=_duration;
    return map;
  }

}