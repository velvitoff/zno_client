import 'dart:convert';
import 'dart:typed_data';
import 'package:client/models/exam_file_model.dart';
import 'package:client/state_models/auth_state_model.dart';
import 'package:client/routes.dart';
import 'package:client/routes/testing_route/testing_pages.dart';
import 'package:client/providers/testing_route_provider.dart';
import 'package:client/routes/testing_route/testing_route_backuper.dart';
import 'package:client/routes/testing_route/zno_testing_header.dart';
import 'package:client/services/storage_service/main_storage_service.dart';
import 'package:client/services/decryption_service.dart';
import 'package:client/widgets/hexagon_dots/hexagon_dots_loading.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'testing_route_data.dart';
import '../../locator.dart';
import '../../widgets/zno_error.dart';

class TestingRoute extends StatefulWidget {
  final TestingRouteData dto;

  const TestingRoute({Key? key, required this.dto}) : super(key: key);

  @override
  TestingRouteState createState() => TestingRouteState();
}

class TestingRouteState extends State<TestingRoute> {
  late final Future<ExamFileModel> futureTestData;

  @override
  void initState() {
    super.initState();
    futureTestData = locator
        .get<MainStorageService>()
        .getSession(
            widget.dto.sessionData.folderName, widget.dto.sessionData.fileName)
        .then((Uint8List data) {
      if (widget.dto.sessionData.fileName.endsWith('.bin') &&
          context.read<AuthStateModel>().isPremium) {
        final res = locator.get<DecryptionService>().decryptBin(data);
        return ExamFileModel.fromJson(jsonDecode(res));
      }
      final String res = const Utf8Decoder().convert(data);
      return ExamFileModel.fromJson(jsonDecode(res));
    });
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      child: Scaffold(
          body: FutureBuilder(
        future: futureTestData,
        builder: (BuildContext context, AsyncSnapshot<ExamFileModel> snapshot) {
          if (snapshot.hasData) {
            return TestingRouteProvider(
              data: widget.dto,
              testData: snapshot.data!,
              child: TestingRouteBackuper(
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
              )),
            );
          } else if (snapshot.hasError) {
            return ZnoError(
              text: 'Помилка завантаження даних',
              buttonText: 'Повернутися',
              onTap: () => context.go(Routes.subjectsRoute),
            );
          } else {
            return Center(
              child: HexagonDotsLoading.def(),
            );
          }
        },
      )),
    );
  }
}
