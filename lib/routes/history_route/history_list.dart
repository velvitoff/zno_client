import 'package:client/dto/previous_session_data.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../widgets/prev_session_item.dart';

class HistoryList extends StatelessWidget {
  final List<PreviousSessionData> prevSessionsList;

  const HistoryList({super.key, required this.prevSessionsList});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: EdgeInsets.only(top: 12.h),
      children: prevSessionsList
          .map((item) => PrevSessionItem(data: item, detailed: true))
          .toList(),
    );
  }
}
