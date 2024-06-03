import 'package:flutter/material.dart';
import 'package:client/routes.dart';
import 'package:client/widgets/icons/zno_map_icon.dart';
import 'package:client/widgets/icons/zno_storage_icon.dart';
import 'package:client/widgets/icons/zno_list_icon.dart';
import 'package:client/widgets/icons/zno_star_icon.dart';
import 'package:go_router/go_router.dart';

class SettingsRouteStateModel extends ChangeNotifier {
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

  List<(String, String, CustomPainter)> get getListValues => listValues;

  void onItemTap(BuildContext context, String route) {
    context.push(route);
  }
}
