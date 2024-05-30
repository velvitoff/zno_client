import 'package:client/routes/settings_route/widgets/settings_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

class SettingsList extends StatelessWidget {
  final List<(String, String, CustomPainter)> list;
  const SettingsList({super.key, required this.list});

  void _onItemTap(BuildContext context, String route) {
    context.go(route);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(right: 20.w, left: 20.w, top: 5.h),
      child: ListView.builder(
          padding: EdgeInsets.zero,
          itemCount: list.length,
          itemBuilder: (context, index) => Padding(
                padding: EdgeInsets.only(bottom: 5.h, top: 5.h),
                child: SettingsItem(
                  text: list[index].$1,
                  goldenBorder: list[index].$1 == 'Преміум',
                  onTap: () => _onItemTap(context, list[index].$2),
                  icon: CustomPaint(
                    painter: list[index].$3,
                    child: SizedBox(
                      width: 40.r,
                      height: 40.r,
                    ),
                  ),
                ),
              )),
    );
  }
}
