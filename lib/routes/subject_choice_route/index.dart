import 'package:client/routes.dart';
import 'package:client/widgets/zno_bottom_navigation_bar.dart';
import 'package:client/widgets/zno_top_header_small.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

class SubjectChoiceRoute extends StatelessWidget {
  const SubjectChoiceRoute({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          ZnoTopHeaderSmall(
            backgroundColor: const Color(0xFFF5F5F5),
            child: Container(
              margin: EdgeInsets.fromLTRB(7.w, 0, 0, 0),
              child: Align(
                alignment: Alignment.centerLeft,
                child: GestureDetector(
                  onTap: () => context.go(Routes.subjectsRoute),
                  child: Icon(
                    Icons.arrow_back,
                    size: 45.sp,
                    color: const Color(0xFFF5F5F5),
                  ),
                ),
              ),
            ),
          ),
          Expanded(child: Container()),
          const ZnoBottomNavigationBar(activeIndex: 0)
        ],
      ),
    );
  }
}
