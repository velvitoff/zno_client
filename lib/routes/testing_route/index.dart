import 'dart:convert';
import 'package:client/dto/test_data.dart';
import 'package:client/models/testing_route_model.dart';
import 'package:client/routes/testing_route/testing_pages.dart';
import 'package:client/routes/testing_route/zno_testing_header.dart';
import 'package:client/services/interfaces/storage_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../dto/session_data.dart';
import '../../locator.dart';

class TestingRoute extends StatefulWidget {
  final SessionData dto;

  const TestingRoute({
    Key? key,
    required this.dto
  }) : super(key: key);

  @override
  _TestingRouteState createState() => _TestingRouteState();
}

class _TestingRouteState extends State<TestingRoute> {
  late final Future<TestData> futureTestData;

  @override
  void initState(){
    super.initState();
    futureTestData = locator.get<StorageService>()
      .getSession(widget.dto.folderName, widget.dto.fileName)
      .then((String value) {
        return TestData.fromJson(jsonDecode(value));
      });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: ChangeNotifierProvider(
          create: (context) => TestingRouteModel(
              pageAmount: 1,//will properly initialize later
              sessionData: SessionData(
                  subjectName: widget.dto.subjectName,
                  sessionName: widget.dto.sessionName,
                  folderName: widget.dto.folderName,
                  fileName: widget.dto.fileName.replaceFirst('.json', '')
              )
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              ZnoTestingHeader(text: widget.dto.subjectName),
              Expanded(
                child: MediaQuery.removePadding(
                  context: context,
                  removeTop: true,
                  child: FutureBuilder(
                    future: futureTestData,
                    builder: (BuildContext context, AsyncSnapshot<TestData> snapshot) {
                      if (snapshot.hasData) {
                        context.read<TestingRouteModel>().setPageAmount(snapshot.data!.questions.length);
                        return TestingPages(questions: snapshot.data!.questions);
                      }
                      else if (snapshot.hasError) {
                        return Text("error: ${snapshot.error!}");
                      }
                      else {
                        return const Text('Loading');
                      }
                    },
                  ),
                ),
              )
            ],
          ),
        )
    );
  }
}

