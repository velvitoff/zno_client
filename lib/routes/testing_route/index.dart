import 'dart:convert';

import 'package:client/dto/test_data.dart';
import 'package:client/routes/testing_route/testing_display.dart';
import 'package:client/routes/testing_route/zno_testing_header.dart';
import 'package:client/services/interfaces/storage_service.dart';
import 'package:client/widgets/zno_bottom_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
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
        body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            ZnoTestingHeader(text: widget.dto.subjectName),
            MediaQuery.removePadding(
              context: context,
              removeTop: true,
              child: Expanded(
                child: FutureBuilder(
                  future: futureTestData,
                  builder: (BuildContext context, AsyncSnapshot<TestData> snapshot) {
                    if (snapshot.hasData) {
                      return TestingDisplay(questions: snapshot.data!.questions);
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
            ),
            const ZnoBottomNavigationBar(activeIndex: 0)
          ],
        )
    );
  }
}

