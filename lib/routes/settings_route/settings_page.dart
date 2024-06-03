import 'package:flutter/material.dart';
import 'package:client/routes/settings_route/widgets/settings_list.dart';
import 'package:client/widgets/zno_top_header_small.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        ZnoTopHeaderSmall(
          child: Center(
              child: Text(
            'Налаштування',
            style: TextStyle(color: const Color(0xFFEFEFEF), fontSize: 24.sp),
          )),
        ),
        const Expanded(
          child: SettingsList(),
        )
      ],
    );
  }
}
