import 'package:client/models/previous_attempt_model.dart';
import 'package:client/routes/history_route/widgets/history_list_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HistoryList extends StatelessWidget {
  final List<PreviousAttemptModel> prevSessionsList;

  const HistoryList({super.key, required this.prevSessionsList});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: EdgeInsets.only(top: 12.h),
      children: prevSessionsList
          .map((item) => HistoryListItem(data: item, detailed: true))
          .toList(),
    );
  }
}
