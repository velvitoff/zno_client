import 'package:flutter/material.dart';
import 'package:client/routes/history_route/widgets/history_route_header.dart';
import 'package:client/widgets/hexagon_dots/hexagon_dots_loading.dart';
import 'package:client/widgets/zno_error.dart';
import 'package:client/routes/history_route/widgets/history_list.dart';
import 'package:provider/provider.dart';
import 'package:client/routes/history_route/state/history_route_state_model.dart';

class HistoryPage extends StatelessWidget {
  const HistoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    final dataList = context.watch<HistoryRouteStateModel>().previousAttempts;

    return Column(
      children: [
        const HistoryRouteHeader(),
        Expanded(
          child: FutureBuilder(
            future: dataList,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                if (snapshot.data!.isEmpty) {
                  return const ZnoError(text: 'Немає історії попередніх спроб');
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
    );
  }
}
