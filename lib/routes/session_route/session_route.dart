import 'package:client/models/exam_file_adress_model.dart';
import 'package:client/routes/session_route/widgets/session_display.dart';
import 'package:client/routes/session_route/state/session_route_provider.dart';
import 'package:client/widgets/zno_bottom_navigation_bar.dart';
import 'package:client/widgets/zno_icon_button.dart';
import 'package:client/widgets/zno_top_header_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

class SessionRoute extends StatelessWidget {
  final ExamFileAddressModel dto;

  const SessionRoute({Key? key, required this.dto}) : super(key: key);

  void _goBack(BuildContext context) {
    if (!context.canPop()) return;
    context.pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                  onTap: () => _goBack(context),
                ),
              ),
            ),
            const Expanded(
              child: Center(
                child: SessionDisplay(),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: const ZnoBottomNavigationBar(
        activeRoute: ZnoBottomNavigationEnum.subjects,
      ),
    );
  }
}
