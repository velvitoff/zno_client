import 'package:client/dto/sessions_route_data.dart';
import 'package:client/routes/sessions_route/sessions_list.dart';
import 'package:client/routes/sessions_route/sessions_scroll_wrapper.dart';
import 'package:client/widgets/zno_bottom_navigation_bar.dart';
import 'package:client/widgets/zno_error.dart';
import 'package:client/widgets/zno_list_item.dart';
import 'package:client/widgets/zno_top_header_text.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

import '../../dto/session_data.dart';
import '../../locator.dart';
import '../../routes.dart';
import '../../services/interfaces/storage_service_interface.dart';
import '../../services/interfaces/utils_service_interface.dart';
import '../../widgets/zno_loading.dart';
import '../../widgets/zno_year_line.dart';

class SessionsRoute extends StatefulWidget {
  final SessionsRouteData dto;

  const SessionsRoute({Key? key, required this.dto}) : super(key: key);

  @override
  SessionsRouteState createState() => SessionsRouteState();
}

class SessionsRouteState extends State<SessionsRoute> {
  late final Future<List<Widget>> futureList;

  @override
  void initState() {
    super.initState();
    futureList = locator
        .get<StorageServiceInterface>()
        .listSessions(widget.dto.folderName)
        .then((List<String> data) {
      final Map<String, List<String>> map = data.groupListsBy((element) =>
          element
              .replaceAll('.json', '')
              .replaceAll('.bin', '')
              .split('_')
              .last);

      //group items by years and sort years in descending order
      List<Widget> result = [];
      for (var key
          in map.keys.sorted((String s1, String s2) => s2.compareTo(s1))) {
        if (map[key] == null) {
          continue;
        }

        result.add(ZnoYearLine(text: key));

        for (var el in map[key]!) {
          String sessionName =
              locator.get<UtilsServiceInterface>().fileNameToSessionName(el);
          result.add(ZnoListItem(
              text: sessionName,
              onTap: () => context.go(Routes.sessionRoute,
                  extra: SessionData(
                      fileName: el,
                      fileNameNoExtension:
                          el.replaceAll('.json', '').replaceAll('.bin', ''),
                      sessionName: sessionName,
                      subjectName: widget.dto.subjectName,
                      folderName: widget.dto.folderName)),
              colorType: ZnoListColorType.normal));
        }
      }
      return result;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: FutureBuilder(
              future: futureList,
              builder:
                  (BuildContext context, AsyncSnapshot<List<Widget>> snapshot) {
                if (snapshot.hasData) {
                  if (snapshot.data!.isEmpty) {
                    return SessionsScrollWrapper(
                      subjectName: widget.dto.subjectName,
                      child: SliverToBoxAdapter(
                        child: ZnoError(
                            text: 'Немає доступних тестів',
                            textFontSize: 25.sp),
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
                              height: 200.h,
                              child: const ZnoLoading(),
                            )
                          ],
                        ),
                      ));
                }
              },
            ),
          ),
          const ZnoBottomNavigationBar(
              activeRoute: ZnoBottomNavigationEnum.subjects)
        ],
      ),
    );
  }
}
