import 'package:client/routes.dart';
import 'package:client/routes/history_route/history_list.dart';
import 'package:client/providers/history_route_provider.dart';
import 'package:client/services/storage_service/main_storage_service.dart';
import 'package:client/widgets/hexagon_dots/hexagon_dots_loading.dart';
import 'package:client/widgets/zno_error.dart';
import 'package:client/widgets/zno_icon_button.dart';
import 'package:client/widgets/zno_top_header_small.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import '../../dto/previous_session_data.dart';
import '../../locator.dart';

class HistoryRoute extends StatefulWidget {
  const HistoryRoute({super.key});

  @override
  State<HistoryRoute> createState() => _HistoryRouteState();
}

class _HistoryRouteState extends State<HistoryRoute> {
  late final Future<List<PreviousSessionData>> dataList;

  @override
  void initState() {
    super.initState();
    dataList =
        locator.get<MainStorageService>().getPreviousSessionsListGlobal();
  }

  void _onPopInvoked(bool didPop) {
    context.go(Routes.settingsRoute);
  }

  @override
  Widget build(BuildContext context) {
    return HistoryRouteProvider(
      child: PopScope(
        canPop: false,
        onPopInvoked: _onPopInvoked,
        child: Scaffold(
            body: Column(
          children: [
            ZnoTopHeaderSmall(
              child: Stack(
                children: [
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Padding(
                      padding: EdgeInsets.only(left: 6.w),
                      child: ZnoIconButton(
                          icon: Icons.arrow_back,
                          onTap: () => context.go(Routes.settingsRoute)),
                    ),
                  ),
                  Align(
                      alignment: Alignment.center,
                      child: Text('Історія',
                          style: TextStyle(
                              color: const Color(0xFFEFEFEF), fontSize: 24.sp)))
                ],
              ),
            ),
            Expanded(
              child: FutureBuilder(
                future: dataList,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    if (snapshot.data!.isEmpty) {
                      return const ZnoError(
                          text: 'Немає історії попередніх спроб');
                    } else {
                      return HistoryList(prevSessionsList: snapshot.data!);
                    }
                  } else if (snapshot.hasError) {
                    return const ZnoError(text: 'Помилка зчитування даних');
                  } else {
                    return Center(
                      child: HexagonDotsLoading.def(),
                    );
                  }
                },
              ),
            ),
          ],
        )),
      ),
    );
  }
}
