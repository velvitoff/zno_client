import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

import '../../routes.dart';
import '../../widgets/zno_icon_button.dart';
import '../../widgets/zno_top_header_text.dart';

class SessionsScrollWrapper extends StatelessWidget {
  final String subjectName;
  final Widget child;
  const SessionsScrollWrapper(
      {super.key, required this.subjectName, required this.child});

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverAppBar(
          flexibleSpace: Container(
            margin: EdgeInsets.only(bottom: 5.h),
            child: ZnoTopHeaderText(
              text: subjectName,
              topLeftWidget: ZnoIconButton(
                  icon: Icons.arrow_back,
                  onTap: () => context.go(Routes.subjectsRoute)),
            ),
          ),
          backgroundColor: const Color(0xFFF5F5F5),
          expandedHeight: 250.h,
          collapsedHeight: 70.h,
          pinned: true,
          shadowColor: const Color(0x00000000), //no shadow
        ),
        child
      ],
    );
  }
}
