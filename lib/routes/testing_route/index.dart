import 'dart:convert';
import 'package:client/dto/test_data.dart';
import 'package:client/models/testing_route_model.dart';
import 'package:client/routes/testing_route/testing_pages.dart';
import 'package:client/routes/testing_route/testing_route_provider.dart';
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
        body: FutureBuilder(
          future: futureTestData,
          builder: (BuildContext context, AsyncSnapshot<TestData> snapshot) {
            if (snapshot.hasData) {
              return TestingRouteProvider(
                sessionData: widget.dto,
                testData: snapshot.data!,
              );
            }
            else if (snapshot.hasError) {
              return const Text('Помилка завантаження сесії');
            }
            else {
              return const Text('Завантаження...');
            }
          },
        )
    );
  }
}

