import 'dart:convert';

/// error : "Internal server error"
/// errorFields : ["cause of error, not your concern"]

ErrorModel errorModelFromJson(String str) =>
    ErrorModel.fromJson(json.decode(str));
String errorModelToJson(ErrorModel data) => json.encode(data.toJson());

class ErrorModel {
  ErrorModel({
    String? error,
    List<String>? errorFields,
  }) {
    _error = error;
    _errorFields = errorFields;
  }

  ErrorModel.fromJson(dynamic json) {
    _error = json['error'];
    _errorFields =
        json['errorFields'] != null ? json['errorFields'].cast<String>() : [];
  }
  String? _error;
  List<String>? _errorFields;
  ErrorModel copyWith({
    String? error,
    List<String>? errorFields,
  }) =>
      ErrorModel(
        error: error ?? _error,
        errorFields: errorFields ?? _errorFields,
      );
  String? get error => _error;
  List<String>? get errorFields => _errorFields;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['error'] = _error;
    map['errorFields'] = _errorFields;
    return map;
  }
}
