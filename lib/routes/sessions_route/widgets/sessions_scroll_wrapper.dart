import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

import '../../../routes.dart';
import '../../../widgets/zno_icon_button.dart';
import '../../../widgets/zno_top_header_text.dart';

class SessionsScrollWrapper extends StatelessWidget {
  final String subjectName;
  final Widget child;
  const SessionsScrollWrapper(
      {super.key, required this.subjectName, required this.child});

  @override
  Widget build(BuildContext context) {
    final double topPadding = MediaQuery.of(context).padding.top;
    return CustomScrollView(
      slivers: [
        SliverAppBar(
          flexibleSpace: ZnoTopHeaderText(
            text: subjectName,
            fontSize: subjectName.length > 24 ? 21.5.sp : 25.sp,
            topLeftWidget: Padding(
              padding: EdgeInsets.only(top: 10.h),
              child: ZnoIconButton(
                  icon: Icons.arrow_back,
                  onTap: () => context.go(Routes.subjectsRoute)),
            ),
          ),
          backgroundColor: const Color(0xFFF5F5F5),
          expandedHeight: 150.h - topPadding,
          collapsedHeight: 70.h,
          pinned: true,
          shadowColor: const Color(0x00000000), //no shadow
        ),
        child
      ],
    );
  }
}
