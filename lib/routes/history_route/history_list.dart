import 'package:client/dto/previous_session_data.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../locator.dart';
import '../../services/interfaces/storage_service_interface.dart';
import '../session_route/prev_session_item.dart';

class HistoryList extends StatefulWidget {
  const HistoryList({super.key});

  @override
  State<HistoryList> createState() => _HistoryListState();
}

class _HistoryListState extends State<HistoryList> {
  late final Future<List<PreviousSessionData>> dataList;

  @override
  void initState() {
    super.initState();
    dataList =
        locator.get<StorageServiceInterface>().getPreviousSessionsListGlobal();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
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
            return Container(
              margin: EdgeInsets.fromLTRB(0, 5.h, 0, 0),
              child: ListView(
                children: snapshot.data!
                    .map((item) => PrevSessionItem(data: item, detailed: true))
                    .toList(),
              ),
            );
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
    );
  }
}
