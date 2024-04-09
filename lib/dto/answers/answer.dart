part 'answer_single.dart';
part 'answer_text_fields.dart';
part 'answer_complex.dart';

sealed class Answer {
  const Answer();

  dynamic get toDynamic;

  Map<String, dynamic> get toSaveFormat;

  static Answer? fromDynamic(dynamic data) {
    //old format
    if (data is String) {
      return AnswerSingle([data]);
    }
    if (data is List) {
      return AnswerTextFields.fromListDynamic(data);
    }
    if (data is Map) {
      dynamic innerData = data['data'];
      String? innerType = data['type'] as String?;
      if (innerData == null || innerType == null) {
        //old format
        return AnswerComplex(Map<String, String>.from(data));
      }

      if (innerType == "single") {
        return AnswerSingle(
            List<String>.from(innerData.map((e) => e as String)));
      }
      if (innerType == "complex") {
        return AnswerComplex(Map<String, String>.from(innerData));
      }
      if (innerType == "textfields") {
        return AnswerTextFields(
            List<String>.from(innerData.map((e) => e as String)));
      }
    }
    return null;
  }

  static Map<String, Answer?> mapFromJson(Map<String, dynamic> map) {
    return Map<String, Answer?>.fromEntries(map.entries.map((e) {
      return MapEntry<String, Answer?>(e.key, Answer.fromDynamic(e.value));
    }));
  }

  static Map<String, dynamic> toJsonMap(Map<String, Answer?> map) {
    return Map<String, dynamic>.fromEntries(map.entries.map((e) {
      return MapEntry<String, dynamic>(e.key, e.value?.toSaveFormat);
    }));
  }
}
