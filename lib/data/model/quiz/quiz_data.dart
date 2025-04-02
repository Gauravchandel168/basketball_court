import 'dart:convert';

/// right_answer_id : ""
/// selected_answer_id : ""

QuizData quizDataFromJson(String str) => QuizData.fromJson(json.decode(str));
String quizDataToJson(QuizData data) => json.encode(data.toJson());

class QuizData {
  QuizData(
      {String? rightAnswerId,
      String? selectedAnswerId,
      required bool isAnswerTrue}) {
    _rightAnswerId = rightAnswerId;
    _selectedAnswerId = selectedAnswerId;
    _isAnswerTrue = isAnswerTrue;
  }

  QuizData.fromJson(dynamic json) {
    _rightAnswerId = json['right_answer_id'];
    _selectedAnswerId = json['selected_answer_id'];
    _isAnswerTrue = json['is_answer_true'];
  }
  String? _rightAnswerId;
  String? _selectedAnswerId;
  bool _isAnswerTrue = false;
  QuizData copyWith(
          {String? rightAnswerId,
          String? selectedAnswerId,
          required bool isAnswerTrue}) =>
      QuizData(
        isAnswerTrue: isAnswerTrue,
        rightAnswerId: rightAnswerId ?? _rightAnswerId,
        selectedAnswerId: selectedAnswerId ?? _selectedAnswerId,
      );
  bool get isAnswerTrue => _isAnswerTrue;
  String? get rightAnswerId => _rightAnswerId;
  String? get selectedAnswerId => _selectedAnswerId;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['is_answer_true'] = _isAnswerTrue;
    map['right_answer_id'] = _rightAnswerId;
    map['selected_answer_id'] = _selectedAnswerId;
    return map;
  }
}
