part of 'answer.dart';

class AnswerComplex extends Answer {
  final Map<String, String> data;
  const AnswerComplex(this.data);

  @override
  dynamic get toDynamic => data;

  @override
  Map<String, dynamic> get toSaveFormat =>
      {"type": "complex", "data": toDynamic};
}
