import 'package:client/routes/history_route/history_list.dart';
import 'package:client/routes/history_route/history_route_provider.dart';
import 'package:client/widgets/zno_top_header_small.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:client/widgets/zno_bottom_navigation_bar.dart';

import '../../dto/previous_session_data.dart';
import '../../locator.dart';
import '../../services/interfaces/storage_service_interface.dart';

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
        locator.get<StorageServiceInterface>().getPreviousSessionsListGlobal();
  }

  @override
  Widget build(BuildContext context) {
    return HistoryRouteProvider(
      child: Scaffold(
          body: Column(
        children: [
          const ZnoTopHeaderSmall(),
          Expanded(
            child: FutureBuilder(
              future: dataList,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  if (snapshot.data!.isEmpty) {
                    return Text('Немає історії попередніх спроб',
                        style: TextStyle(
                            color: const Color(0xFF5F5F5F),
                            fontSize: 20.sp,
                            fontWeight: FontWeight.w400));
                  } else {
                    return HistoryList(prevSessionsList: snapshot.data!);
                  }
                } else if (snapshot.hasError) {
                  return Text('Помилка завантаження даних',
                      style: TextStyle(
                          color: const Color(0xFF5F5F5F),
                          fontSize: 20.sp,
                          fontWeight: FontWeight.w400));
                } else {
                  return Text('Завантаження...',
                      style: TextStyle(
                          color: const Color(0xFF5F5F5F),
                          fontSize: 20.sp,
                          fontWeight: FontWeight.w400));
                }
              },
            ),
          ),
          const ZnoBottomNavigationBar(activeIndex: 1)
        ],
      )),
    );
  }
}
