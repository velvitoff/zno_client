import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

import 'package:client/routes.dart';
import 'package:client/widgets/icons/zno_icon_wrap.dart';
import 'package:client/widgets/icons/zno_book_icon.dart';
import 'package:client/widgets/icons/zno_map_icon.dart';
import 'package:client/widgets/icons/zno_storage_icon.dart';


class ZnoBottomNavigationBar extends StatelessWidget {
  final int? activeIndex;

  const ZnoBottomNavigationBar({
    Key? key,
    this.activeIndex
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 70.h,
      decoration: const BoxDecoration(
          color: Color(0xFF3C7142),
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(5),
              topRight: Radius.circular(5)
          )
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          GestureDetector(
            onTap: () => context.go(Routes.subjectsRoute),
            child: ZnoIconWrap(
              text: 'Предмети',
              painter: const ZnoBookIcon(),
              isActive: activeIndex == 0 ? true: false,
            ),
          ),
          GestureDetector(
            onTap: () => context.go(Routes.historyRoute),
            child: ZnoIconWrap(
              text: 'Історія',
              painter: const ZnoMapIcon(),
              isActive: activeIndex == 1 ? true: false,
            ),
          ),
          GestureDetector(
            onTap: () => context.go(Routes.storageRoute),
            child: ZnoIconWrap(
              text: 'Сховище',
              painter: const ZnoStorageIcon(),
              isActive: activeIndex == 2 ? true: false,
            ),
          ),
        ],
      ),
    );
  }
}
