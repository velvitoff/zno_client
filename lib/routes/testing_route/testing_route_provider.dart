import 'package:client/routes/testing_route/testing_pages.dart';
import 'package:client/routes/testing_route/zno_testing_header.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../dto/session_data.dart';
import '../../dto/test_data.dart';
import '../../models/testing_route_model.dart';

class TestingRouteProvider extends StatelessWidget {
  final TestData testData;
  final SessionData sessionData;

  const TestingRouteProvider({
    Key? key,
    required this.testData,
    required this.sessionData
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => TestingRouteModel(
          questions: testData.questions,
          sessionData: SessionData(
            subjectName: sessionData.subjectName,
            sessionName: sessionData.sessionName,
            folderName: sessionData.folderName,
            fileName: sessionData.fileName,
            fileNameNoExtension: sessionData.fileName.replaceFirst('.json', '')
          )
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          ZnoTestingHeader(text: sessionData.subjectName),
          Expanded(
              child: MediaQuery.removePadding(
                context: context,
                removeTop: true,
                child: TestingPages(questions: testData.questions),
              )
          )
        ],
      ),
    );
  }
}
