import 'dart:convert';
import 'dart:typed_data';
import 'package:client/dto/test_data.dart';
import 'package:client/routes.dart';
import 'package:client/routes/testing_route/testing_pages.dart';
import 'package:client/providers/testing_route_provider.dart';
import 'package:client/routes/testing_route/zno_testing_header.dart';
import 'package:client/services/interfaces/storage_service_interface.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../dto/testing_route_data.dart';
import '../../locator.dart';
import '../../widgets/zno_error.dart';
import '../../widgets/zno_loading.dart';

class TestingRoute extends StatefulWidget {
  final TestingRouteData dto;

  const TestingRoute({Key? key, required this.dto}) : super(key: key);

  @override
  TestingRouteState createState() => TestingRouteState();
}

class TestingRouteState extends State<TestingRoute> {
  late final Future<TestData> futureTestData;

  @override
  void initState() {
    super.initState();
    futureTestData = locator
        .get<StorageServiceInterface>()
        .getSession(
            widget.dto.sessionData.folderName, widget.dto.sessionData.fileName)
        .then((Uint8List data) {
      //TODO: Only read bin if premium
      /*if (widget.dto.sessionData.fileName.endsWith('.bin')) {
        final res = locator.get<UtilsServiceInterface>().decryptBin(data);
        return TestData.fromJson(jsonDecode(res));
      }*/
      final String res = const Utf8Decoder().convert(data);
      return TestData.fromJson(jsonDecode(res));
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
                ZnoTestingHeader(text: widget.dto.sessionData.sessionName),
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
          return ZnoError(
            text: 'Помилка завантаження даних',
            buttonText: 'Повернутися',
            onTap: () => context.go(Routes.subjectsRoute),
          );
        } else {
          return const Center(
            child: FractionallySizedBox(
              widthFactor: 0.6,
              heightFactor: 0.6,
              child: ZnoLoading(),
            ),
          );
        }
      },
    ));
  }
}
