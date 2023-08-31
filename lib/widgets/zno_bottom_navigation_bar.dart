import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

import 'package:client/routes.dart';
import 'package:client/widgets/icons/zno_icon_wrap.dart';
import 'package:client/widgets/icons/zno_book_icon.dart';
import 'package:client/widgets/icons/zno_map_icon.dart';
import 'package:client/widgets/icons/zno_storage_icon.dart';

import 'icons/zno_list_icon.dart';

class ZnoBottomNavigationBar extends StatelessWidget {
  final int? activeIndex;
  final void Function()? onSwitch;
  final Future<void> Function()? onSwitchAsync;

  const ZnoBottomNavigationBar(
      {Key? key, this.activeIndex, this.onSwitch, this.onSwitchAsync})
      : super(key: key);

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
            onTap: () async {
              if (onSwitch != null) {
                onSwitch!();
              }
              if (onSwitchAsync != null) {
                onSwitchAsync!().then((_) => context.go(Routes.subjectsRoute));
              } else {
                context.go(Routes.subjectsRoute);
              }
            },
            child: ZnoIconWrap(
              text: 'Предмети',
              childIcon: CustomPaint(
                isComplex: true,
                painter: const ZnoBookIcon(),
                child: SizedBox(
                  width: 37.r,
                  height: 37.r,
                ),
              ),
              isActive: activeIndex == 0 ? true : false,
            ),
          ),
          GestureDetector(
            onTap: () async {
              if (onSwitch != null) {
                onSwitch!();
              }
              if (onSwitchAsync != null) {
                onSwitchAsync!()
                    .then((_) => context.go(Routes.subjectChoiceRoute));
              } else {
                context.go(Routes.subjectChoiceRoute);
              }
            },
            child: ZnoIconWrap(
              text: 'Вибір',
              childIcon: CustomPaint(
                isComplex: true,
                painter: const ZnoListIcon(),
                child: SizedBox(
                  width: 38.r,
                  height: 38.r,
                ),
              ),
              isActive: activeIndex == 1 ? true : false,
            ),
          ),
          GestureDetector(
            onTap: () async {
              if (onSwitch != null) {
                onSwitch!();
              }
              if (onSwitchAsync != null) {
                onSwitchAsync!().then((_) => context.go(Routes.historyRoute));
              } else {
                context.go(Routes.historyRoute);
              }
            },
            child: ZnoIconWrap(
              text: 'Історія',
              childIcon: CustomPaint(
                isComplex: true,
                painter: const ZnoMapIcon(),
                child: SizedBox(
                  width: 38.r,
                  height: 38.r,
                ),
              ),
              isActive: activeIndex == 2 ? true : false,
            ),
          ),
          GestureDetector(
            onTap: () async {
              if (onSwitch != null) {
                onSwitch!();
              }
              if (onSwitchAsync != null) {
                onSwitchAsync!().then((_) => context.go(Routes.storageRoute));
              } else {
                context.go(Routes.storageRoute);
              }
            },
            child: ZnoIconWrap(
              text: 'Сховище',
              childIcon: CustomPaint(
                isComplex: true,
                painter: const ZnoStorageIcon(),
                child: SizedBox(
                  width: 38.r,
                  height: 38.r,
                ),
              ),
              isActive: activeIndex == 3 ? true : false,
            ),
          ),
        ],
      ),
    );
  }
}
