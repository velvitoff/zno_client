import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:client/routes.dart';

enum ZnoBottomNavigationEnum { subjects, settings }

extension RouteExtension on ZnoBottomNavigationEnum {
  String get routeString {
    switch (this) {
      case ZnoBottomNavigationEnum.subjects:
        return Routes.subjectsRoute;
      case ZnoBottomNavigationEnum.settings:
        return Routes.settingsRoute;
    }
  }
}

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

  Future<void> onDestinationSwitch(BuildContext context, int index) async {
    if (onSwitch != null) {
      onSwitch!();
    }

    final String route = ZnoBottomNavigationEnum.values[index].routeString;
    if (onSwitchAsync != null) {
      onSwitchAsync!().then((_) => context.go(route));
    } else {
      context.go(route);
    }
  }

  @override
  Widget build(BuildContext context) {
    return NavigationBarTheme(
        data: NavigationBarThemeData(
            height: 70.h,
            backgroundColor: const Color(0xFF3C7142),
            labelTextStyle: MaterialStateProperty.all(TextStyle(
                fontSize: 17.sp,
                color: const Color(0xFFF4F4F4),
                fontWeight: FontWeight.w400))),
        child: NavigationBar(
            selectedIndex: activeRoute.index,
            onDestinationSelected: (int index) async =>
                onDestinationSwitch(context, index),
            destinations: [
              NavigationDestination(
                icon: Icon(
                  Icons.school_outlined,
                  color: const Color(0xffF4F4F4),
                  size: 37.sp,
                ),
                label: 'Предмети',
                tooltip: '',
              ),
              NavigationDestination(
                icon: Icon(
                  Icons.settings,
                  color: const Color(0xffF4F4F4),
                  size: 37.sp,
                ),
                label: 'Налаштування',
                tooltip: '',
              )
            ]));
  }
}
