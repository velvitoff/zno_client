import 'package:client/models/questions/question.dart';

class ExamFileModel {
  final String name;
  final String subject;
  final String imageFolderName;
  final List<Question> questions;

  ExamFileModel(
      {required this.name,
      required this.subject,
      required this.imageFolderName,
      required this.questions});

  factory ExamFileModel.fromJson(Map<String, dynamic> map) => ExamFileModel(
      name: map['name'] as String,
      subject: map['subject'] as String,
      imageFolderName: map['image_folder_name'] as String,
      questions: List<Question>.from(
          map['questions'].map((x) => Question.fromJson(x))));
}

class ExamFileModelNoQuestions {
  final String name;
  final String subject;
  final String imageFolderName;

  ExamFileModelNoQuestions(
      {required this.name,
      required this.subject,
      required this.imageFolderName});

  factory ExamFileModelNoQuestions.fromJson(Map<String, dynamic> map) =>
      ExamFileModelNoQuestions(
          name: map['name'] as String,
          subject: map['subject'] as String,
          imageFolderName: map['image_folder_name'] as String);
}
