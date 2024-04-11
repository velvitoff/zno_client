import 'package:client/dto/answers/answer.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_test/flutter_test.dart';

const single = AnswerSingle(["А"]);
const singleMulti = AnswerSingle(["А", "Б"]);
const complex = AnswerComplex({"1": "Б"});
const textField = AnswerTextFields(["50", "20"]);

void main() {
  group('Anwers loading new format', () {
    test('Answers loading single new format', () {
      final singleJson = single.toSaveFormat;
      var a = Answer.fromDynamic(singleJson);
      expect(a, isA<AnswerSingle>());
      a = a as AnswerSingle;
      expect(listEquals(a.data, ["А"]), true);
    });

    test('Answers loading singleMulti new format', () {
      final singleMultiJson = singleMulti.toSaveFormat;
      var aMulti = Answer.fromDynamic(singleMultiJson);
      expect(aMulti, isA<AnswerSingle>());
      aMulti = aMulti as AnswerSingle;
      expect(listEquals(aMulti.data, ["А", "Б"]), true);
    });

    test('Answers loading complex new format', () {
      final json = complex.toSaveFormat;
      var a = Answer.fromDynamic(json);
      expect(a, isA<AnswerComplex>());
      a = a as AnswerComplex;
      expect(mapEquals(a.data, {"1": "Б"}), true);
    });

    test('Answers loading text fields new format', () {
      final json = textField.toSaveFormat;
      var a = Answer.fromDynamic(json);
      expect(a, isA<AnswerTextFields>());
      a = a as AnswerTextFields;
      expect(listEquals(a.data, ["50", "20"]), true);
    });
  });

  group('Answers loading, old format', () {
    test('Answers loading single, old format', () {
      var a = Answer.fromDynamic("А");
      expect(a, isA<AnswerSingle>());
      a = a as AnswerSingle;
      expect(listEquals(a.data, ["А"]), true);
    });

    test('Answers loading complex, old format', () {
      var a = Answer.fromDynamic({"1": "Б"});
      expect(a, isA<AnswerComplex>());
      a = a as AnswerComplex;
      expect(mapEquals(a.data, {"1": "Б"}), true);
    });

    test('Answers loading text fields, old format', () {
      var a = Answer.fromDynamic(["50", "20"]);
      expect(a, isA<AnswerTextFields>());
      a = a as AnswerTextFields;
      expect(listEquals(a.data, ["50", "20"]), true);
    });
  });
}
