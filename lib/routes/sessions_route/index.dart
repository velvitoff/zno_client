import 'package:client/routes/sessions_route/sessions_route_data.dart';
import 'package:client/routes/sessions_route/sessions_list.dart';
import 'package:client/routes/sessions_route/sessions_scroll_wrapper.dart';
import 'package:client/services/storage_service.dart';
import 'package:client/state_models/auth_state_model.dart';
import 'package:client/widgets/hexagon_dots/hexagon_dots_loading.dart';
import 'package:client/widgets/zno_bottom_navigation_bar.dart';
import 'package:client/widgets/zno_error.dart';
import 'package:client/widgets/zno_top_header_text.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import '../../models/exam_file_adress_model.dart';
import '../../locator.dart';
import '../../routes.dart';

class SessionsRoute extends StatefulWidget {
  final SessionsRouteData dto;

  const SessionsRoute({Key? key, required this.dto}) : super(key: key);

  @override
  SessionsRouteState createState() => SessionsRouteState();
}

class SessionsRouteState extends State<SessionsRoute> {
  late final Future<List<MapEntry<String, List<ExamFileAddressModel>>>>
      futureList;

  Future<List<MapEntry<String, List<ExamFileAddressModel>>>>
      getFutureList() async {
    final isPremium = context.read<AuthStateModel>().isPremium;
    final list = await locator.get<StorageService>().listExamFiles(
        widget.dto.folderName, widget.dto.subjectName, isPremium);
    final listGrouped = list
        .groupListsBy((element) => element.fileNameNoExtension.split('_').last)
        .entries
        .sorted((a, b) => a.key.compareTo(b.key));
    return listGrouped;
  }

  @override
  void initState() {
    super.initState();
    futureList = getFutureList();
  }

  void _onPopInvoked(bool didPop) {
    context.go(Routes.subjectsRoute);
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvoked: _onPopInvoked,
      child: Scaffold(
        body: FutureBuilder(
          future: futureList,
          builder: (BuildContext context,
              AsyncSnapshot<List<MapEntry<String, List<ExamFileAddressModel>>>>
                  snapshot) {
            if (snapshot.hasData) {
              if (snapshot.data!.isEmpty) {
                return SessionsScrollWrapper(
                  subjectName: widget.dto.subjectName,
                  child: SliverToBoxAdapter(
                    child: ZnoError(
                        text: 'Немає доступних тестів', textFontSize: 25.sp),
                  ),
                );
              } else {
                return SessionsScrollWrapper(
                  subjectName: widget.dto.subjectName,
                  child: SessionsList(list: snapshot.data!),
                );
              }
            } else if (snapshot.hasError) {
              return Column(
                children: [
                  ZnoTopHeaderText(text: widget.dto.subjectName),
                  const ZnoError(text: 'Помилка завантаження даних')
                ],
              );
            } else {
              return SessionsScrollWrapper(
                  subjectName: widget.dto.subjectName,
                  child: SliverToBoxAdapter(
                    child: Column(
                      children: [
                        SizedBox(height: 100.h),
                        SizedBox(
                          height: 300.h,
                          child: HexagonDotsLoading.def(),
                        )
                      ],
                    ),
                  ));
            }
          },
        ),
        bottomNavigationBar: const ZnoBottomNavigationBar(
            activeRoute: ZnoBottomNavigationEnum.subjects),
      ),
    );
  }
}
