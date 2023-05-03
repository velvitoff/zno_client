import 'package:client/dto/testing_route_data.dart';
import 'package:client/routes/testing_route/testing_pages.dart';
import 'package:client/routes/testing_route/zno_testing_header.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../dto/test_data.dart';
import '../../models/testing_route_model.dart';

class TestingRouteProvider extends StatelessWidget {
  final TestData testData;
  final TestingRouteData data;

  const TestingRouteProvider({
    Key? key,
    required this.testData,
    required this.data
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => TestingRouteModel(
          questions: testData.questions,
          sessionData: data.sessionData,
          prevSessionData: data.prevSessionData
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          ZnoTestingHeader(text: data.sessionData.subjectName),
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
