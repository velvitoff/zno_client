import 'package:client/dto/question_data.dart';

class TestData {
  final String name;
  final String subject;
  final String imageFolderName;
  final List<Question> questions;

  TestData._({
    required this.name,
    required this.subject,
    required this.imageFolderName,
    required this.questions
  });

  factory TestData.fromJson(Map<String, dynamic> map) =>
      TestData._(
          name: map['name'] as String,
          subject: map['subject'] as String,
          imageFolderName: map['image_folder_name'] as String,
          questions: List<Question>.from(map['questions'].map((x) => Question.fromJson(x)))
      );

  Map<String, dynamic> toJson() => {
    "name": name,
    "subject": subject,
    "image_folder_name": imageFolderName,
    "questions": List<dynamic>.from(questions.map((x) => x.toJson())),
  };

}

class TestDataNoQuestions {
  final String name;
  final String subject;
  final String imageFolderName;

  TestDataNoQuestions._({
    required this.name,
    required this.subject,
    required this.imageFolderName
  });

  factory TestDataNoQuestions.fromJson(Map<String, dynamic> map) =>
      TestDataNoQuestions._(
          name: map['name'] as String,
          subject: map['subject'] as String,
          imageFolderName: map['image_folder_name'] as String
      );

}
