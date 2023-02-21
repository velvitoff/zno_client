import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:client/widgets/zno_bottom_navigation_bar.dart';

class HistoryRoute extends StatelessWidget {
  const HistoryRoute({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
          children: [
            Container(
              width: 360.w,
              height: 70.h,
              decoration: const BoxDecoration(
                  gradient: LinearGradient(
                      begin: Alignment.bottomRight,
                      end: Alignment.topLeft,
                      colors: [
                        Color(0xFF38543B),
                        Color(0xFF418C4A)
                      ]
                  ),
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(10),
                    bottomRight: Radius.circular(10),
                  )
              ),
            ),
            Expanded(
              child: Container(),
            ),
            const ZnoBottomNavigationBar(activeIndex: 1)
          ],
        )
    );
  }
}
