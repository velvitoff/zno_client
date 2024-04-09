part of 'answer.dart';

class AnswerTextFields extends Answer {
  final List<String> data;
  const AnswerTextFields(this.data);

  @override
  dynamic get toDynamic => data;

  @override
  Map<String, dynamic> get toSaveFormat =>
      {"type": "textfields", "data": toDynamic};

  factory AnswerTextFields.fromListDynamic(List<dynamic> lst) {
    return AnswerTextFields(List<String>.from(lst.map((e) => e as String)));
  }
}
