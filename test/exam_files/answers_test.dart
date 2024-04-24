import 'dart:convert';
import 'package:client/models/answers/answer.dart';
import 'package:test/test.dart';

const Map<String, Answer?> answerSingle = {
  "1": AnswerSingle(["50"])
};
const Map<String, Answer?> answerSingleMulti = {
  "1": AnswerSingle(["50", "0.02"])
};
const Map<String, Answer?> answerComplex = {
  "1": AnswerComplex({"А": "20", "Б": "30", "В": "40", "Г": "50"})
};
const Map<String, Answer?> answerTextFields = {
  "1": AnswerTextFields(["500", "2.3"])
};

const Map<String, dynamic> answerSingleOld = {"1": "50"};

const Map<String, dynamic> answerComplexOld = {
  "1": {"А": "20", "Б": "30", "В": "40", "Г": "50"}
};

const Map<String, dynamic> answerTextFieldsOld = {
  "1": ["500", "2.3"]
};

void main() {
  group('Saving and loading answers, new format', () {
    test('questionSingle save and load, new format', () {
      final json = jsonEncode(Answer.toJsonMap(answerSingle));
      final jsonDecoded = Answer.mapFromJson(jsonDecode(json));
      expect(jsonDecoded["1"]!.toDynamic, answerSingle["1"]!.toDynamic);
      expect(jsonDecoded["1"], isA<AnswerSingle>());
    });

    test('questionSingleMulti save and load, new format', () {
      final json = jsonEncode(Answer.toJsonMap(answerSingleMulti));
      final jsonDecoded = Answer.mapFromJson(jsonDecode(json));
      expect(jsonDecoded["1"]!.toDynamic, answerSingleMulti["1"]!.toDynamic);
      expect(jsonDecoded["1"], isA<AnswerSingle>());
    });

    test('questionComplex save and load, new format', () {
      final json = jsonEncode(Answer.toJsonMap(answerComplex));
      final jsonDecoded = Answer.mapFromJson(jsonDecode(json));
      expect(jsonDecoded["1"]!.toDynamic, answerComplex["1"]!.toDynamic);
      expect(jsonDecoded["1"], isA<AnswerComplex>());
    });

    test('questionTextFields save and load, new format', () {
      final json = jsonEncode(Answer.toJsonMap(answerTextFields));
      final jsonDecoded = Answer.mapFromJson(jsonDecode(json));
      expect(jsonDecoded["1"]!.toDynamic, answerTextFields["1"]!.toDynamic);
      expect(jsonDecoded["1"], isA<AnswerTextFields>());
    });
  });

  group('Loading answers, old format', () {
    test('questionSingle load, old format', () {
      final json = jsonEncode(answerSingleOld);
      final jsonDecoded = Answer.mapFromJson(jsonDecode(json));
      expect((jsonDecoded["1"]!.toDynamic as List)[0], answerSingleOld["1"]!);
      expect(jsonDecoded["1"], isA<AnswerSingle>());
    });

    test('questionComplex load, old format', () {
      final json = jsonEncode(answerComplexOld);
      final jsonDecoded = Answer.mapFromJson(jsonDecode(json));
      expect(jsonDecoded["1"]!.toDynamic, answerComplexOld["1"]!);
      expect(jsonDecoded["1"], isA<AnswerComplex>());
    });

    test('questionTextFields load, old format', () {
      final json = jsonEncode(answerTextFieldsOld);
      final jsonDecoded = Answer.mapFromJson(jsonDecode(json));
      expect(jsonDecoded["1"]!.toDynamic, answerTextFieldsOld["1"]!);
      expect(jsonDecoded["1"], isA<AnswerTextFields>());
    });
  });
}
