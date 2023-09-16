import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

import 'package:client/routes.dart';
import 'package:client/widgets/icons/zno_icon_wrap.dart';
import 'package:client/widgets/icons/zno_book_icon.dart';
import 'icons/zno_settings_icon.dart';

enum ZnoBottomNavigationEnum { subjects, settings }

class ZnoBottomNavigationBar extends StatelessWidget {
  final ZnoBottomNavigationEnum activeRoute;
  final void Function()? onSwitch;
  final Future<void> Function()? onSwitchAsync;

  const ZnoBottomNavigationBar(
      {Key? key,
      this.activeRoute = ZnoBottomNavigationEnum.subjects,
      this.onSwitch,
      this.onSwitchAsync})
      : super(key: key);

  Future<void> handleSwitch(BuildContext context, String route) async {
    if (onSwitch != null) {
      onSwitch!();
    }
    if (onSwitchAsync != null) {
      onSwitchAsync!().then((_) => context.go(route));
    } else {
      context.go(route);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 70.h,
      decoration: const BoxDecoration(
        color: Color(0xFF3C7142),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          GestureDetector(
            onTap: () async => handleSwitch(context, Routes.subjectsRoute),
            child: ZnoIconWrap(
                text: 'Предмети',
                isActive: activeRoute == ZnoBottomNavigationEnum.subjects,
                childIcon: SizedBox(
                  width: 35.r,
                  height: 35.r,
                  child: FittedBox(
                    fit: BoxFit.contain,
                    child: CustomPaint(
                      isComplex: true,
                      painter: const ZnoBookIcon(),
                      child: SizedBox(
                        width: 40.r,
                        height: 40.r,
                      ),
                    ),
                  ),
                )),
          ),
          GestureDetector(
            onTap: () async => handleSwitch(context, Routes.settingsRoute),
            child: ZnoIconWrap(
              text: 'Налаштування',
              isActive: activeRoute == ZnoBottomNavigationEnum.settings,
              childIcon: SizedBox(
                  width: 35.r,
                  height: 35.r,
                  child: FittedBox(
                    fit: BoxFit.contain,
                    child: CustomPaint(
                      isComplex: true,
                      painter: const ZnoSettingsIcon(),
                      child: SizedBox(
                        width: 40.r,
                        height: 40.r,
                      ),
                    ),
                  )),
            ),
          ),
        ],
      ),
    );
  }
}
