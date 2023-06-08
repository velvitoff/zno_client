import 'package:client/dto/previous_session_data.dart';
import 'package:client/dto/session_data.dart';
import 'package:client/dto/test_data.dart';
import 'package:client/models/testing_route_model.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  final testData =
      TestData(name: '', subject: '', imageFolderName: '', questions: []);
  const sessionData = SessionData(
      sessionName: '',
      subjectName: '',
      folderName: '',
      fileName: '',
      fileNameNoExtension: '');
  final prevSessionData = PreviousSessionData(
      sessionName: '',
      sessionId: '',
      date: DateTime.now(),
      completed: false,
      lastPage: 0,
      answers: {},
      score: '');

  final model = TestingRouteModel(
      questions: testData.questions,
      sessionData: sessionData,
      prevSessionData: prevSessionData);

  test('Testing route model getters testing', () async {
    expect(model.pageAmount, testData.questions.length);
    expect(model.isViewMode, prevSessionData.completed);
  });

  test('Testing route model answers management testing', () async {
    const q1Answer = 'A';
    const q2Answers = {'1': 'A', '2': 'B'};
    model.addAnswer('1', q1Answer);
    model.addAnswer('2', q2Answers);

    expect(model.getAnswer('1'), q1Answer);
    expect(model.getAnswer('2'), q2Answers);
  });
}
