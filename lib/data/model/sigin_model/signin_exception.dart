import 'dart:convert';
/// error : ""
/// errorFields : [""]

SigninException signinExceptionFromJson(String str) => SigninException.fromJson(json.decode(str));
String signinExceptionToJson(SigninException data) => json.encode(data.toJson());
class SigninException {
  SigninException({
      String? error, 
      List<String>? errorFields,}){
    _error = error;
    _errorFields = errorFields;
}

  SigninException.fromJson(dynamic json) {
    _error = json['error'];
    _errorFields = json['errorFields'] != null ? json['errorFields'].cast<String>() : [];
  }
  String? _error;
  List<String>? _errorFields;
SigninException copyWith({  String? error,
  List<String>? errorFields,
}) => SigninException(  error: error ?? _error,
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