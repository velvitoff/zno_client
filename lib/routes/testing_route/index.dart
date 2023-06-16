import 'dart:convert';
import 'package:client/dto/test_data.dart';
import 'package:client/routes/testing_route/testing_pages.dart';
import 'package:client/routes/testing_route/testing_route_provider.dart';
import 'package:client/routes/testing_route/zno_testing_header.dart';
import 'package:client/services/interfaces/storage_service_interface.dart';
import 'package:flutter/material.dart';
import '../../dto/testing_route_data.dart';
import '../../locator.dart';

class TestingRoute extends StatefulWidget {
  final TestingRouteData dto;

  const TestingRoute({Key? key, required this.dto}) : super(key: key);

  @override
  _TestingRouteState createState() => _TestingRouteState();
}

class _TestingRouteState extends State<TestingRoute> {
  late final Future<TestData> futureTestData;

  @override
  void initState() {
    super.initState();
    futureTestData = locator
        .get<StorageServiceInterface>()
        .getSession(
            widget.dto.sessionData.folderName, widget.dto.sessionData.fileName)
        .then((String value) {
      return TestData.fromJson(jsonDecode(value));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: FutureBuilder(
      future: futureTestData,
      builder: (BuildContext context, AsyncSnapshot<TestData> snapshot) {
        if (snapshot.hasData) {
          return TestingRouteProvider(
            data: widget.dto,
            testData: snapshot.data!,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                ZnoTestingHeader(text: widget.dto.sessionData.subjectName),
                Expanded(
                    child: MediaQuery.removePadding(
                  context: context,
                  removeTop: true,
                  child: TestingPages(questions: snapshot.data!.questions),
                ))
              ],
            ),
          );
        } else if (snapshot.hasError) {
          return Text(
              'Помилка завантаження сесії ${snapshot.error!.toString()}');
        } else {
          return const Text('Завантаження...');
        }
      },
    ));
  }
}
