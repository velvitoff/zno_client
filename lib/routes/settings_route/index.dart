import 'package:client/routes.dart';
import 'package:client/routes/settings_route/settings_item.dart';
import 'package:client/widgets/zno_top_header_small.dart';
import 'package:flutter/material.dart';
import 'package:client/widgets/zno_bottom_navigation_bar.dart';
import 'package:client/widgets/icons/zno_map_icon.dart';
import 'package:client/widgets/icons/zno_storage_icon.dart';
import 'package:client/widgets/icons/zno_list_icon.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
//import '../../widgets/icons/zno_star_icon.dart';

class SettingsRoute extends StatelessWidget {
  const SettingsRoute({super.key});

  static const List<(String, String, CustomPainter)> listValues = [
    (
      'Вибір предметів',
      Routes.subjectChoiceRoute,
      ZnoListIcon(color: Color(0xFF3E8F48))
    ),
    ('Сховище', Routes.storageRoute, ZnoStorageIcon(color: Color(0xFF3E8F48))),
    ('Історія', Routes.historyRoute, ZnoMapIcon(color: Color(0xFF3E8F48))),
    //('Преміум', Routes.premiumRoute, ZnoStarIcon())
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        bottomNavigationBar: const ZnoBottomNavigationBar(
            activeRoute: ZnoBottomNavigationEnum.settings),
        body: Column(
          children: [
            ZnoTopHeaderSmall(
              child: Center(
                  child: Text(
                'Налаштування',
                style:
                    TextStyle(color: const Color(0xFFEFEFEF), fontSize: 24.sp),
              )),
            ),
            Expanded(
              child: Padding(
                padding: EdgeInsets.only(right: 20.w, left: 20.w, top: 5.h),
                child: ListView.builder(
                    itemCount: listValues.length,
                    itemBuilder: (context, index) => Padding(
                          padding: EdgeInsets.only(bottom: 5.h, top: 5.h),
                          child: SettingsItem(
                            text: listValues[index].$1,
                            goldenBorder: listValues[index].$1 == 'Преміум',
                            onTap: () => context.go(listValues[index].$2),
                            icon: CustomPaint(
                              painter: listValues[index].$3,
                              child: SizedBox(
                                width: 40.r,
                                height: 40.r,
                              ),
                            ),
                          ),
                        )),
              ),
            )
          ],
        ));
  }
}
