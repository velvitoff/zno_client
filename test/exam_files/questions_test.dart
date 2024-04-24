import 'dart:convert';
import 'package:client/models/questions/question.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_test/flutter_test.dart';

const questionSingle = """
{
      "Single": {
        "order": 1,
        "render": [
          [
            "p",
            "a"
          ]
        ],
        "answers": [
          {
            "А": [
              "p",
              "307"
            ],
            "Б": [
              "p",
              "290"
            ],
            "В": [
              "p",
              "287"
            ],
            "Г": [
              "p",
              "273"
            ],
            "Д": [
              "p",
              "162"
            ]
          }
        ],
        "answer_list": [
          "А",
          "Б",
          "В",
          "Г",
          "Д"
        ],
        "correct": "А"
      }
    }
""";

const questionSingleMulti = """
{
      "Single": {
        "order": 1,
        "render": [
          [
            "p",
            "a"
          ]
        ],
        "answers": [
          {
            "А": [
              "p",
              "307"
            ],
            "Б": [
              "p",
              "290"
            ],
            "В": [
              "p",
              "287"
            ],
            "Г": [
              "p",
              "273"
            ],
            "Д": [
              "p",
              "162"
            ]
          }
        ],
        "answer_list": [
          "А",
          "Б",
          "В",
          "Г",
          "Д"
        ],
        "correct": ["А", "Г"]
      }
    }
""";

const questionComplex = """
{
      "Complex": {
        "order": 16,
        "render": [
          [
            "p",
            "До кожного початку речення (1–3) доберіть його закінчення (А – Д) так, щоб утворилося правильне твердження."
          ]
        ],
        "title_list": [
          "<i>Початок речення</i>",
          "<i>Закінчення речення</i>"
        ],
        "table_list": [
          {
            "1": [
              "p",
              "Ф"
            ],
            "2": [
              "p",
              "Функція <math>y=2</math>"
            ],
            "3": [
              "p",
              "Функція <math>y=x^3</math>"
            ]
          },
          {
            "А": [
              "p",
              "спад"
            ],
            "Б": [
              "p",
              "не визначена в точці <math>x=1.</math>"
            ],
            "В": [
              "p",
              "набуває від’ємного значення в точці <math>x=8.</math>"
            ],
            "Г": [
              "p",
              "набуває додатного значення в точці <math>x=-3.</math>"
            ],
            "Д": [
              "p",
              "є непарною."
            ]
          }
        ],
        "answer_mapping_list": [
          [
            "1",
            "2",
            "3"
          ],
          [
            "А",
            "Б",
            "В",
            "Г",
            "Д"
          ]
        ],
        "correct_map": {
          "1": "Б",
          "2": "Г",
          "3": "Д"
        }
      }
    }
""";

const questionTextFields = """
{
      "TextFields": {
        "order": 19,
        "render": [
          [
            "p",
            "На рисунку"
          ],
          [
            "img",
            "19_0.png"
          ]
        ],
        "answer_titles": [],
        "answers": [],
        "correct_list": [
          "91"
        ]
      }
    }
""";

const questionTextFieldsMulti = """
{
      "TextFields": {
        "order": 19,
        "render": [
          [
            "p",
            "На рисунку"
          ],
          [
            "img",
            "19_0.png"
          ]
        ],
        "answer_titles": [],
        "answers": [],
        "correct_list": [
          "94",
          ["92", "93"]
        ]
      }
    }
""";

void main() {
  group('Question loading test', () {
    test('Load questionSingle', () {
      Question q = Question.fromJson(jsonDecode(questionSingle));
      expect(q, isA<QuestionSingle>());
      q = q as QuestionSingle;
      expect(listEquals(q.correct, ["А"]), true);
    });

    test('Load questionSingleMulti', () {
      Question q = Question.fromJson(jsonDecode(questionSingleMulti));
      expect(q, isA<QuestionSingle>());
      q = q as QuestionSingle;
      expect(listEquals(q.correct, ["А", "Г"]), true);
    });

    test('Load questionComplex', () {
      Question q = Question.fromJson(jsonDecode(questionComplex));
      expect(q, isA<QuestionComplex>());
      q = q as QuestionComplex;
      expect(mapEquals(q.correctMap, {"1": "Б", "2": "Г", "3": "Д"}), true);
    });

    test('Load questionTextField', () {
      Question q = Question.fromJson(jsonDecode(questionTextFields));
      expect(q, isA<QuestionTextFields>());
      q = q as QuestionTextFields;
      expect(q.correctList.length, 1);
      expect(listEquals(q.correctList[0], ["91"]), true);
    });

    test('Load questionTextFieldMulti', () {
      Question q = Question.fromJson(jsonDecode(questionTextFieldsMulti));
      expect(q, isA<QuestionTextFields>());
      q = q as QuestionTextFields;
      expect(q.correctList.length, 2);
      expect(listEquals(q.correctList[0], ["94"]), true);
      expect(listEquals(q.correctList[1], ["92", "93"]), true);
    });

    test('Check parameter parsing', () {
      final QuestionSingle q =
          Question.fromJson(jsonDecode(questionSingle)) as QuestionSingle;
      final List<List<String>> renderResult = [
        ["p", "a"]
      ];
      final List<Map<String, List<String>>> answersResult = [
        {
          "А": ["p", "307"],
          "Б": ["p", "290"],
          "В": ["p", "287"],
          "Г": ["p", "273"],
          "Д": ["p", "162"]
        }
      ];
      expect(q.render, renderResult);
      expect(q.order, 1);
      expect(listEquals(q.answerList, ["А", "Б", "В", "Г", "Д"]), true);
      expect(q.answers, answersResult);
    });
  });
}
