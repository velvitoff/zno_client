import 'package:client/dto/previous_session_data.dart';
import 'package:client/dto/question_data.dart';
import 'package:client/dto/session_data.dart';
import 'package:client/dto/test_data.dart';
import 'package:client/dto/testing_route_data.dart';
import 'package:client/routes/testing_route/question_single/question_single_answer_field.dart';
import 'package:client/routes/testing_route/testing_route_provider.dart';
import 'package:client/widgets/answer_cell.dart';
import 'package:client/widgets/ui_gen_handler.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';

void main() {
  const sessionData = SessionData(
      sessionName: '',
      subjectName: '',
      folderName: '',
      fileName: '',
      fileNameNoExtension: '');
  final prevSessionData = PreviousSessionData(
      sessionName: '',
      subjectName: '',
      sessionId: '',
      date: DateTime.now(),
      completed: false,
      lastPage: 0,
      answers: {},
      score: '');

  final testData =
      TestData(name: '', subject: '', imageFolderName: '', questions: [
    const Question(
        type: QuestionEnum.single,
        single: QuestionSingle(
            order: 0,
            render: [
              ['p', 'test']
            ],
            answers: {
              'A': ['p', 'А'],
              'Б': ['p', 'Б'],
              'В': ['p', 'В'],
              'Г': ['p', 'Г']
            },
            correct: 'A'))
  ]);

  final answerCellsApp = MaterialApp(
    home: Scaffold(
      body: ScreenUtilInit(
        designSize: const Size(360, 800),
        minTextAdapt: true,
        splitScreenMode: true,
        builder: (context, _) => TestingRouteProvider(
            testData: testData,
            data: TestingRouteData(
                sessionData: sessionData, prevSessionData: prevSessionData),
            child: QuestionSingleAnswerField(
              index: 0,
              question: testData.questions[0].single!,
            )),
      ),
    ),
  );

  testWidgets('Single Question answer field tap response',
      (WidgetTester tester) async {
    await tester.pumpWidget(answerCellsApp);

    //check amount of cells
    final cellsFinder = find.byType(AnswerCell);
    expect(cellsFinder, findsNWidgets(4));

    await tester.tap(cellsFinder.first);
    await tester.pump();

    //check if the cell is marked
    final firstCell = tester.widget<AnswerCell>(cellsFinder.first);
    expect(firstCell.answerColor, AnswerCellColor.green);

    await tester.tap(cellsFinder.at(1));
    await tester.pump();

    //check is 1st cell is unmarked and the 2nd cell is marked now
    expect(tester.widget<AnswerCell>(cellsFinder.first).answerColor,
        AnswerCellColor.none);
    expect(tester.widget<AnswerCell>(cellsFinder.at(1)).answerColor,
        AnswerCellColor.green);
  });

  testWidgets('Ui generator testing', (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(
        home: Scaffold(
            body: ScreenUtilInit(
      designSize: const Size(360, 800),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, _) =>
          const UiGenHandler(data: ['p', 'Тестова стрічка']),
    ))));

    expect(find.text('Тестова стрічка'), findsOneWidget);

    await tester.pumpWidget(MaterialApp(
        home: Scaffold(
            body: ScreenUtilInit(
      designSize: const Size(360, 800),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, _) => const SingleChildScrollView(
        child: UiGenHandler(data: ['p', '<em>Тестова стрічка</em>']),
      ),
    ))));

    expect(find.text('Тестова стрічка'), findsOneWidget);
    expect(find.byType(Text), findsOneWidget);
    expect(
        tester
            .widget<Text>(find.text('Тестова стрічка'))
            .textSpan!
            .toStringDeep()
            .contains('style: italic'),
        true);
  });
}
