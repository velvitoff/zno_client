import 'package:client/locator.dart';
import 'package:client/routes/subject_choice_route/state/subject_choice_route_state_model.dart';
import 'package:client/services/dialog_service.dart';
import 'package:client/widgets/zno_icon_button.dart';
import 'package:client/widgets/zno_top_header_small.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class SubjectChoiceHeader extends StatefulWidget {
  const SubjectChoiceHeader({super.key});

  @override
  State<SubjectChoiceHeader> createState() => _SubjectChoiceHeaderState();
}

class _SubjectChoiceHeaderState extends State<SubjectChoiceHeader> {
  void _showInfo(BuildContext context) {
    locator.get<DialogService>().showInfoDialog(
        context,
        'Ця сторінка дозволяє обрати предмети, які відображатимуться на головній сторінці',
        230.h);
  }

  Future<void> _onBack(BuildContext context) async {
    context.read<SubjectChoiceRouteStateModel>().onBack(context);
  }

  @override
  Widget build(BuildContext context) {
    return ZnoTopHeaderSmall(
      backgroundColor: const Color(0xFFF5F5F5),
      child: Container(
        margin: EdgeInsets.only(right: 12.w, left: 6.w),
        child: Stack(
          children: [
            Align(
              alignment: Alignment.centerLeft,
              child: ZnoIconButton(
                icon: Icons.arrow_back,
                onTap: () => _onBack(context),
              ),
            ),
            Align(
              alignment: Alignment.center,
              child: Text('Вибір предметів',
                  style: TextStyle(
                    color: const Color(0xFFEFEFEF),
                    fontSize: 24.sp,
                  )),
            ),
            Align(
              alignment: Alignment.centerRight,
              child: ZnoIconButton(
                icon: Icons.help_outline,
                onTap: () => _showInfo(context),
              ),
            )
          ],
        ),
      ),
    );
  }
}
