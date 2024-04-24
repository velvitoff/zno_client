import 'package:client/models/answers/answer.dart';
import 'package:client/models/questions/question.dart';
import 'package:test/test.dart';

const questionSingle = QuestionSingle(order: 1, render: [
  ["p", "a"]
], answers: [
  {
    "А": ["p", "50"],
    "Б": ["p", "60"],
    "В": ["p", "70"],
    "Г": ["p", "80"]
  }
], answerList: [
  "А",
  "Б",
  "В",
  "Г"
], correct: [
  "А"
]);

const questionSingleMulti = QuestionSingle(order: 1, render: [
  ["p", "a"]
], answers: [
  {
    "А": ["p", "50"],
    "Б": ["p", "60"],
    "В": ["p", "70"],
    "Г": ["p", "80"]
  }
], answerList: [
  "А",
  "Б",
  "В",
  "Г"
], correct: [
  "А",
  "Г"
]);

const questionComplex = QuestionComplex(order: 1, render: [
  ["p", "a"]
], titleList: [
  "<i>a</i>",
  "<i>b</i>"
], tableList: [
  {
    "1": ["p", "a"],
    "2": ["p", "a"],
    "3": ["p", "a"],
    "4": ["p", "a"]
  },
  {
    "А": ["p", "a"],
    "Б": ["p", "a"],
    "В": ["p", "a"],
    "Г": ["p", "a"],
    "Д": ["p", "a"]
  }
], answerMappingList: [
  ["1", "2", "3", "4"],
  ["А", "Б", "В", "Г", "Д"]
], correctMap: {
  "1": "Б",
  "2": "В",
  "3": "Д",
  "4": "А"
});

const questionTextFields = QuestionTextFields(order: 1, render: [
  ["p", "a"]
], answerTitles: [], answers: [], correctList: [
  ["50"],
  ["20"]
]);

const questionTextFieldsMulti = QuestionTextFields(order: 1, render: [
  ["p", "a"]
], answerTitles: [], answers: [], correctList: [
  ["50", "0.05"],
  ["0,2"]
]);

void main() {
  group('Scoring answers for Question Single', () {
    const answerCorrect = AnswerSingle(["А"]);
    const answerWrong1 = AnswerSingle(["Б"]);
    const answerWrong2 = AnswerSingle(["А", "Б"]);
    const answerWrong3 = AnswerSingle([]);
    test('questionSingle score correct', () {
      final scoreCorrect = questionSingle.getScore(answerCorrect);
      expect(scoreCorrect.scoringEnum, ScoringEnum.correct);
      expect(scoreCorrect.score, 1);
      expect(scoreCorrect.total, 1);
    });

    test('questionSingle score wrong 1', () {
      final scoreWrong1 = questionSingle.getScore(answerWrong1);
      expect(scoreWrong1.scoringEnum, ScoringEnum.wrong);
      expect(scoreWrong1.score, 0);
      expect(scoreWrong1.total, 1);
    });

    test('questionSingle score wrong 2', () {
      final scoreWrong2 = questionSingle.getScore(answerWrong2);
      expect(scoreWrong2.scoringEnum, ScoringEnum.wrong);
      expect(scoreWrong2.score, 0);
      expect(scoreWrong2.total, 1);
    });

    test('questionSingle score wrong 3', () {
      final scoreWrong3 = questionSingle.getScore(answerWrong3);
      expect(scoreWrong3.scoringEnum, ScoringEnum.wrong);
      expect(scoreWrong3.score, 0);
      expect(scoreWrong3.total, 1);
    });
  });

  group('Scoring answers for Question Single Multi', () {
    const answerCorrect1 = AnswerSingle(["А", "Г"]);
    const answerCorrect2 = AnswerSingle(["Г", "А"]);
    const answerWrong1 = AnswerSingle(["Б"]);
    const answerWrong2 = AnswerSingle(["А", "Б", "В"]);
    const answerWrong3 = AnswerSingle([]);

    test('questionSingleMulti score correct 1', () {
      final scoreCorrect1 = questionSingleMulti.getScore(answerCorrect1);
      expect(scoreCorrect1.scoringEnum, ScoringEnum.correct);
      expect(scoreCorrect1.score, 1);
      expect(scoreCorrect1.total, 1);
    });

    test('questionSingleMulti score correct 1', () {
      final scoreCorrect2 = questionSingleMulti.getScore(answerCorrect2);
      expect(scoreCorrect2.scoringEnum, ScoringEnum.correct);
      expect(scoreCorrect2.score, 1);
      expect(scoreCorrect2.total, 1);
    });

    test('questionSingleMulti score wrong 1', () {
      final scoreWrong1 = questionSingleMulti.getScore(answerWrong1);
      expect(scoreWrong1.scoringEnum, ScoringEnum.wrong);
      expect(scoreWrong1.score, 0);
      expect(scoreWrong1.total, 1);
    });

    test('questionSingleMulti score wrong 2', () {
      final scoreWrong2 = questionSingleMulti.getScore(answerWrong2);
      expect(scoreWrong2.scoringEnum, ScoringEnum.wrong);
      expect(scoreWrong2.score, 0);
      expect(scoreWrong2.total, 1);
    });

    test('questionSingleMulti score wrong 3', () {
      final scoreWrong3 = questionSingleMulti.getScore(answerWrong3);
      expect(scoreWrong3.scoringEnum, ScoringEnum.wrong);
      expect(scoreWrong3.score, 0);
      expect(scoreWrong3.total, 1);
    });
  });

  group('Scoring answers for Question Complex', () {
    const answerCorrect1 =
        AnswerComplex({"1": "Б", "2": "В", "3": "Д", "4": "А"});
    const answerCorrect2 =
        AnswerComplex({"4": "А", "2": "В", "3": "Д", "1": "Б"});
    const answerPartial1 = AnswerComplex({"4": "А", "2": "А"});
    const answerPartial2 = AnswerComplex({"3": "Д", "1": "Б", "4": "Б"});
    const answerPartial3 = AnswerComplex({"2": "В", "3": "Д", "1": "Б"});
    const answerWrong1 = AnswerComplex({});
    const answerWrong2 =
        AnswerComplex({"1": "А", "2": "Д", "3": "Б", "4": "В"});

    test('questionComplex score correct 1', () {
      final score = questionComplex.getScore(answerCorrect1);
      expect(score.scoringEnum, ScoringEnum.correct);
      expect(score.score, 4);
      expect(score.total, 4);
    });

    test('questionComplex score correct 2', () {
      final score = questionComplex.getScore(answerCorrect2);
      expect(score.scoringEnum, ScoringEnum.correct);
      expect(score.score, 4);
      expect(score.total, 4);
    });

    test('questionComplex score partial 1', () {
      final score = questionComplex.getScore(answerPartial1);
      expect(score.scoringEnum, ScoringEnum.partial);
      expect(score.score, 1);
      expect(score.total, 4);
    });

    test('questionComplex score partial 2', () {
      final score = questionComplex.getScore(answerPartial2);
      expect(score.scoringEnum, ScoringEnum.partial);
      expect(score.score, 2);
      expect(score.total, 4);
    });

    test('questionComplex score partial 3', () {
      final score = questionComplex.getScore(answerPartial3);
      expect(score.scoringEnum, ScoringEnum.partial);
      expect(score.score, 3);
      expect(score.total, 4);
    });

    test('questionComplex score wrong 1', () {
      final score = questionComplex.getScore(answerWrong1);
      expect(score.scoringEnum, ScoringEnum.wrong);
      expect(score.score, 0);
      expect(score.total, 4);
    });

    test('questionComplex score wrong 2', () {
      final score = questionComplex.getScore(answerWrong2);
      expect(score.scoringEnum, ScoringEnum.wrong);
      expect(score.score, 0);
      expect(score.total, 4);
    });
  });

  group('Scoring answers for Question TextFields', () {
    const answerCorrect1 = AnswerTextFields(["50", "20"]);
    const answerPartial1 = AnswerTextFields(["50", "10"]);
    const answerPartial2 = AnswerTextFields(["", "20"]);
    const answerWrong1 = AnswerTextFields(["", ""]);
    const answerWrong2 = AnswerTextFields([""]);
    const answerWrong3 = AnswerTextFields([]);
    const answerWrong4 = AnswerTextFields(["56", "abc"]);

    test('questionTextFields score correct 1', () {
      final score = questionTextFields.getScore(answerCorrect1);
      expect(score.scoringEnum, ScoringEnum.correct);
      expect(score.score, 2);
      expect(score.total, 2);
    });

    test('questionTextFields score partial 1', () {
      final score = questionTextFields.getScore(answerPartial1);
      expect(score.scoringEnum, ScoringEnum.partial);
      expect(score.score, 1);
      expect(score.total, 2);
    });

    test('questionTextFields score partial 2', () {
      final score = questionTextFields.getScore(answerPartial2);
      expect(score.scoringEnum, ScoringEnum.partial);
      expect(score.score, 1);
      expect(score.total, 2);
    });

    test('questionTextFields score wrong 1', () {
      final score = questionTextFields.getScore(answerWrong1);
      expect(score.scoringEnum, ScoringEnum.wrong);
      expect(score.score, 0);
      expect(score.total, 2);
    });

    test('questionTextFields score wrong 2', () {
      final score = questionTextFields.getScore(answerWrong2);
      expect(score.scoringEnum, ScoringEnum.wrong);
      expect(score.score, 0);
      expect(score.total, 2);
    });

    test('questionTextFields score wrong 3', () {
      final score = questionTextFields.getScore(answerWrong3);
      expect(score.scoringEnum, ScoringEnum.wrong);
      expect(score.score, 0);
      expect(score.total, 2);
    });

    test('questionTextFields score wrong 4', () {
      final score = questionTextFields.getScore(answerWrong4);
      expect(score.scoringEnum, ScoringEnum.wrong);
      expect(score.score, 0);
      expect(score.total, 2);
    });
  });

  group('Scoring answers for Question TextFields Multi', () {
    const answerCorrect1 = AnswerTextFields(["50", "0,2"]);
    const answerCorrect2 = AnswerTextFields(["0.05", "0,2"]);
    const answerCorrect3 = AnswerTextFields(["0,05", "0,2"]);
    const answerPartial1 = AnswerTextFields(["50", "10"]);
    const answerPartial2 = AnswerTextFields(["", "0,2"]);
    const answerWrong1 = AnswerTextFields(["", ""]);
    const answerWrong2 = AnswerTextFields([""]);
    const answerWrong3 = AnswerTextFields([]);
    const answerWrong4 = AnswerTextFields(["56", "abc"]);

    test('questionTextFields score correct 1', () {
      final score = questionTextFieldsMulti.getScore(answerCorrect1);
      expect(score.scoringEnum, ScoringEnum.correct);
      expect(score.score, 2);
      expect(score.total, 2);
    });

    test('questionTextFields score correct 2', () {
      final score = questionTextFieldsMulti.getScore(answerCorrect2);
      expect(score.scoringEnum, ScoringEnum.correct);
      expect(score.score, 2);
      expect(score.total, 2);
    });

    test('questionTextFields score correct 3', () {
      final score = questionTextFieldsMulti.getScore(answerCorrect3);
      expect(score.scoringEnum, ScoringEnum.correct);
      expect(score.score, 2);
      expect(score.total, 2);
    });

    test('questionTextFields score partial 1', () {
      final score = questionTextFieldsMulti.getScore(answerPartial1);
      expect(score.scoringEnum, ScoringEnum.partial);
      expect(score.score, 1);
      expect(score.total, 2);
    });

    test('questionTextFields score partial 2', () {
      final score = questionTextFieldsMulti.getScore(answerPartial2);
      expect(score.scoringEnum, ScoringEnum.partial);
      expect(score.score, 1);
      expect(score.total, 2);
    });

    test('questionTextFields score wrong 1', () {
      final score = questionTextFieldsMulti.getScore(answerWrong1);
      expect(score.scoringEnum, ScoringEnum.wrong);
      expect(score.score, 0);
      expect(score.total, 2);
    });

    test('questionTextFields score wrong 2', () {
      final score = questionTextFieldsMulti.getScore(answerWrong2);
      expect(score.scoringEnum, ScoringEnum.wrong);
      expect(score.score, 0);
      expect(score.total, 2);
    });

    test('questionTextFields score wrong 3', () {
      final score = questionTextFieldsMulti.getScore(answerWrong3);
      expect(score.scoringEnum, ScoringEnum.wrong);
      expect(score.score, 0);
      expect(score.total, 2);
    });

    test('questionTextFields score wrong 4', () {
      final score = questionTextFieldsMulti.getScore(answerWrong4);
      expect(score.scoringEnum, ScoringEnum.wrong);
      expect(score.score, 0);
      expect(score.total, 2);
    });
  });
}
