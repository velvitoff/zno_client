import 'package:client/routes.dart';
import 'package:client/routes/settings_route/widgets/settings_list.dart';
import 'package:client/widgets/zno_top_header_small.dart';
import 'package:flutter/material.dart';
import 'package:client/widgets/zno_bottom_navigation_bar.dart';
import 'package:client/widgets/icons/zno_map_icon.dart';
import 'package:client/widgets/icons/zno_storage_icon.dart';
import 'package:client/widgets/icons/zno_list_icon.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:client/widgets/icons/zno_star_icon.dart';

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
    ('Преміум', Routes.premiumRoute, ZnoStarIcon())
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        bottomNavigationBar: const ZnoBottomNavigationBar(
            activeRoute: ZnoBottomNavigationEnum.settings),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            ZnoTopHeaderSmall(
              child: Center(
                  child: Text(
                'Налаштування',
                style:
                    TextStyle(color: const Color(0xFFEFEFEF), fontSize: 24.sp),
              )),
            ),
            const Expanded(
              child: SettingsList(list: listValues),
            )
          ],
        ));
  }
}
