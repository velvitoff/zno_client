import 'package:client/models/exam_file_adress_model.dart';
import 'package:client/routes/sessions_route/widgets/sessions_route_input_data.dart';
import 'package:client/routes.dart';
import 'package:client/routes/session_route/widgets/session_display.dart';
import 'package:client/routes/session_route/state/session_route_provider.dart';
import 'package:client/widgets/zno_icon_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

import '../../widgets/zno_bottom_navigation_bar.dart';
import '../../widgets/zno_top_header_text.dart';

class SessionRoute extends StatelessWidget {
  final ExamFileAddressModel dto;

  const SessionRoute({Key? key, required this.dto}) : super(key: key);

  void _handlePop() {}

  void _goBack(BuildContext context, bool shouldPop) {
    if (!shouldPop) return;
    context.pop();
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvoked: (bool val) => _handlePop(),
      child: Scaffold(
        body: SessionRouteProvider(
          sessionData: dto,
          child: Column(
            children: [
              ZnoTopHeaderText(
                  text: dto.subjectName,
                  fontSize: dto.subjectName.length > 24 ? 21.5.sp : 25.sp,
                  topLeftWidget: Padding(
                    padding: EdgeInsets.only(top: 10.h),
                    child: ZnoIconButton(
                      icon: Icons.arrow_back,
                      onTap: () => _goBack(context, true),
                    ),
                  )),
              const Expanded(
                child: Center(
                  child: SessionDisplay(),
                ),
              ),
            ],
          ),
        ),
        bottomNavigationBar: const ZnoBottomNavigationBar(
            activeRoute: ZnoBottomNavigationEnum.subjects),
      ),
    );
  }
}
