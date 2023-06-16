import 'package:client/routes/history_route/history_list.dart';
import 'package:client/widgets/zno_top_header_small.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:client/widgets/zno_bottom_navigation_bar.dart';

class HistoryRoute extends StatelessWidget {
  const HistoryRoute({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      children: const [
        ZnoTopHeaderSmall(),
        Expanded(
          child: HistoryList(),
        ),
        ZnoBottomNavigationBar(activeIndex: 1)
      ],
    ));
  }
}
