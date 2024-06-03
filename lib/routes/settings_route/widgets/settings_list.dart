import 'package:client/routes/settings_route/state/settings_route_state_model.dart';
import 'package:client/routes/settings_route/widgets/settings_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class SettingsList extends StatelessWidget {
  const SettingsList({super.key});

  void _onItemTap(BuildContext context, String route) {
    context.read<SettingsRouteStateModel>().onItemTap(context, route);
  }

  @override
  Widget build(BuildContext context) {
    final list = context.read<SettingsRouteStateModel>().getListValues;

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
