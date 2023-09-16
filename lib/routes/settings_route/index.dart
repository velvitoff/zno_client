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
import '../../dto/previous_session_data.dart';
import '../../locator.dart';
import '../../services/interfaces/storage_service_interface.dart';
import '../../widgets/icons/zno_star_icon.dart';

class SettingsRoute extends StatefulWidget {
  const SettingsRoute({super.key});

  @override
  State<SettingsRoute> createState() => _SettingsRouteState();
}

class _SettingsRouteState extends State<SettingsRoute> {
  late final Future<List<PreviousSessionData>> dataList;

  @override
  void initState() {
    super.initState();
    dataList =
        locator.get<StorageServiceInterface>().getPreviousSessionsListGlobal();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      children: [
        const ZnoTopHeaderSmall(),
        Expanded(
          child: Padding(
            padding: EdgeInsets.only(right: 20.w, left: 20.w),
            child: ListView(
              children: [
                SizedBox(
                  height: 5.h,
                ),
                SettingsItem(
                  text: 'Вибір предметів',
                  onTap: () => context.go(Routes.subjectChoiceRoute),
                  icon: CustomPaint(
                    painter: const ZnoListIcon(color: Color(0xFF3E8F48)),
                    child: SizedBox(
                      width: 40.r,
                      height: 40.r,
                    ),
                  ),
                ),
                SettingsItem(
                  text: 'Сховище',
                  onTap: () => context.go(Routes.storageRoute),
                  icon: CustomPaint(
                    painter: const ZnoStorageIcon(color: Color(0xFF3E8F48)),
                    child: SizedBox(
                      width: 40.r,
                      height: 40.r,
                    ),
                  ),
                ),
                SettingsItem(
                  text: 'Історія',
                  onTap: () => context.go(Routes.historyRoute),
                  icon: CustomPaint(
                    painter: const ZnoMapIcon(color: Color(0xFF3E8F48)),
                    child: SizedBox(
                      width: 40.r,
                      height: 40.r,
                    ),
                  ),
                ),
                SettingsItem(
                  text: 'Преміум',
                  onTap: () => context.go(Routes.premiumRoute),
                  goldenBorder: true,
                  icon: CustomPaint(
                    painter: const ZnoStarIcon(),
                    child: SizedBox(
                      width: 40.r,
                      height: 40.r,
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
        const ZnoBottomNavigationBar(
            activeRoute: ZnoBottomNavigationEnum.settings)
      ],
    ));
  }
}
