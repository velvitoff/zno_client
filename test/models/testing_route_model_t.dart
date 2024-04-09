import 'package:client/dto/answers/answer.dart';
import 'package:client/dto/previous_session_data.dart';
import 'package:client/dto/questions/question.dart';
import 'package:client/dto/session_data.dart';
import 'package:client/models/testing_route_model.dart';
import 'package:client/models/testing_time_model.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_test/flutter_test.dart';

final model = TestingRouteModel(
    sessionData: const SessionData(
        subjectName: 'test',
        sessionName: 'test session',
        folderName: 'empty',
        fileName: 'empty.json',
        fileNameNoExtension: 'empty'),
    questions: const [
      QuestionSingle(
          order: 1,
          render: [],
          answers: [],
          answerList: ["А", "Б", "В", "Г"],
          correct: ["А"]),
      QuestionSingle(
          order: 2,
          render: [],
          answers: [],
          answerList: ["А", "Б", "В", "Г"],
          correct: ["А", "Г"]),
      QuestionComplex(
          order: 3,
          render: [],
          titleList: [],
          tableList: [],
          answerMappingList: [
            ["1", "2", "3"],
            ["А", "Б", "В", "Г", "Д"]
          ],
          correctMap: {
            "1": "Б",
            "2": "В",
            "3": "Г"
          }),
      QuestionTextFields(
          order: 4,
          render: [],
          answerTitles: [],
          answers: [],
          correctList: [
            ["91"]
          ]),
      QuestionTextFields(
          order: 5,
          render: [],
          answerTitles: [],
          answers: [],
          correctList: [
            ["91", "92"],
            ["30"]
          ]),
      QuestionNoAnswer(order: 6, render: []),
    ],
    prevSessionData: null);

void main() {
  group('TestingRouteModel test', () {
    test('isViewMode test', () {
      expect(model.isViewMode, false);
    });

    test('pageAmount test', () {
      expect(model.pageAmount, 6);
    });

    test('answers empty test', () {
      expect(model.getAnswer(1), null);
      expect(model.getAnswer(2), null);
      expect(model.getAnswer(3), null);
      expect(model.getAnswer(4), null);
      expect(model.getAnswer(5), null);
      expect(model.getAnswer(6), null);
    });

    test('editing answers for question single', () {
      model.addAnswerSingle(1, "Б");
      var a1 = model.getAnswer(1) as AnswerSingle;
      expect(listEquals(a1.data, ["Б"]), true);

      model.addAnswerSingle(1, "В");
      a1 = model.getAnswer(1) as AnswerSingle;
      expect(listEquals(a1.data, ["В"]), true);

      model.addAnswerSingle(1, "В");
      a1 = model.getAnswer(1) as AnswerSingle;
      expect(listEquals(a1.data, []), true);
    });

    test('editing answers for question single multi', () {
      model.addAnswerSingle(2, "Г");
      var a2 = model.getAnswer(2) as AnswerSingle;
      expect(listEquals(a2.data, ["Г"]), true);

      model.addAnswerSingle(2, "В");
      a2 = model.getAnswer(2) as AnswerSingle;
      expect(listEquals(a2.data, ["Г", "В"]), true);

      model.addAnswerSingle(2, "А");
      a2 = model.getAnswer(2) as AnswerSingle;
      expect(listEquals(a2.data, ["Г", "В"]), true);

      model.addAnswerSingle(2, "В");
      a2 = model.getAnswer(2) as AnswerSingle;
      expect(listEquals(a2.data, ["Г"]), true);

      model.addAnswerSingle(2, "А");
      a2 = model.getAnswer(2) as AnswerSingle;
      expect(listEquals(a2.data, ["Г", "А"]), true);
    });

    test('editing answers for question complex', () {
      model.addAnswerComplex(3, "1", "Б");
      var a3 = model.getAnswer(3) as AnswerComplex;
      expect(mapEquals(a3.data, {"1": "Б"}), true);

      model.addAnswerComplex(3, "2", "В");
      a3 = model.getAnswer(3) as AnswerComplex;
      expect(mapEquals(a3.data, {"1": "Б", "2": "В"}), true);

      model.addAnswerComplex(3, "3", "Г");
      a3 = model.getAnswer(3) as AnswerComplex;
      expect(mapEquals(a3.data, {"1": "Б", "2": "В", "3": "Г"}), true);

      model.addAnswerComplex(3, "3", "А");
      a3 = model.getAnswer(3) as AnswerComplex;
      expect(mapEquals(a3.data, {"1": "Б", "2": "В", "3": "А"}), true);
    });

    test('editing answers for question text field', () {
      model.addAnswerTextFields(4, 0, "92");
      var a4 = model.getAnswer(4) as AnswerTextFields;
      expect(listEquals(a4.data, ["92"]), true);

      model.addAnswerTextFields(4, 0, "91");
      a4 = model.getAnswer(4) as AnswerTextFields;
      expect(listEquals(a4.data, ["91"]), true);
    });

    test('editing answers for question text field multi', () {
      model.addAnswerTextFields(5, 0, "91");
      var a5 = model.getAnswer(5) as AnswerTextFields;
      expect(listEquals(a5.data, ["91", ""]), true);

      model.addAnswerTextFields(5, 1, "20");
      a5 = model.getAnswer(5) as AnswerTextFields;
      expect(listEquals(a5.data, ["91", "20"]), true);
    });

    test('getScore in testing route model', () {
      var prev = PreviousSessionData.fromTestingRouteModel(
          model,
          TestingTimeModel(
              isTimerActivated: false,
              secondsInTotal: 0,
              secondsSinceStart: 0,
              isViewMode: false),
          false);

      expect(prev.score, "5/8");
    });
  });
}
