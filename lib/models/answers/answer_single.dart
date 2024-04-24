part of 'answer.dart';

class AnswerSingle extends Answer {
  final List<String> data;
  const AnswerSingle(this.data);

  @override
  dynamic get toDynamic => data;

  @override
  Map<String, dynamic> get toSaveFormat => {"type": "single", "data": data};
}
