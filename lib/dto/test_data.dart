import 'package:client/dto/questions/question_data.dart';

class TestData {
  final String name;
  final String subject;
  final String imageFolderName;
  final List<Question> questions;

  TestData(
      {required this.name,
      required this.subject,
      required this.imageFolderName,
      required this.questions});

  factory TestData.fromJson(Map<String, dynamic> map) => TestData(
      name: map['name'] as String,
      subject: map['subject'] as String,
      imageFolderName: map['image_folder_name'] as String,
      questions: List<Question>.from(
          map['questions'].map((x) => Question.fromJson(x))));
}

class TestDataNoQuestions {
  final String name;
  final String subject;
  final String imageFolderName;

  TestDataNoQuestions(
      {required this.name,
      required this.subject,
      required this.imageFolderName});

  factory TestDataNoQuestions.fromJson(Map<String, dynamic> map) =>
      TestDataNoQuestions(
          name: map['name'] as String,
          subject: map['subject'] as String,
          imageFolderName: map['image_folder_name'] as String);
}
