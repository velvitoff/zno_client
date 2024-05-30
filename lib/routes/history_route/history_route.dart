import 'package:client/routes.dart';
import 'package:client/routes/history_route/widgets/history_list.dart';
import 'package:client/routes/history_route/state/history_route_provider.dart';
import 'package:client/routes/history_route/widgets/history_route_header.dart';
import 'package:client/services/storage_service.dart';
import 'package:client/widgets/hexagon_dots/hexagon_dots_loading.dart';
import 'package:client/widgets/zno_error.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../models/previous_attempt_model.dart';
import '../../locator.dart';

class HistoryRoute extends StatefulWidget {
  const HistoryRoute({super.key});

  @override
  State<HistoryRoute> createState() => _HistoryRouteState();
}

class _HistoryRouteState extends State<HistoryRoute> {
  late final Future<List<PreviousAttemptModel>> dataList;

  @override
  void initState() {
    super.initState();
    dataList = locator.get<StorageService>().getPreviousSessionsListGlobal();
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
            const HistoryRouteHeader(),
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
