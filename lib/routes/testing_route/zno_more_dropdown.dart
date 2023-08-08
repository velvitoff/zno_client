import 'package:client/models/testing_route_model.dart';
import 'package:client/routes.dart';
import 'package:client/services/interfaces/storage_service_interface.dart';
import 'package:client/dialogs/confirm_dialog.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../../locator.dart';

class ZnoMoreDropdown extends StatefulWidget {
  const ZnoMoreDropdown({Key? key}) : super(key: key);

  @override
  State<ZnoMoreDropdown> createState() => _ZnoMoreDropdownState();
}

class _ZnoMoreDropdownState extends State<ZnoMoreDropdown> {
  void onChoice(BuildContext context, String value) {
    bool isViewMode = context.read<TestingRouteModel>().isViewMode;
    if (value == 'Вийти') {
      showDialog<bool>(
          context: context,
          builder: (BuildContext context) => ConfirmDialog(
                text: isViewMode
                    ? 'Ви дійсно хочете припинити перегляд?'
                    : 'Ви дійсно хочете покинути спробу?',
              )).then((bool? value) {
        if (value != null) {
          if (value) {
            locator
                .get<StorageServiceInterface>()
                .saveSessionEnd(context.read<TestingRouteModel>(), false)
                .then((_) {
              context.go(Routes.sessionRoute,
                  extra: context.read<TestingRouteModel>().sessionData);
            });
          }
        }
      });
    } else if (value == 'Налаштування') {}
  }

  @override
  Widget build(BuildContext context) {
    return DropdownButtonHideUnderline(
      child: DropdownButton2(
        dropdownWidth: 160.w,
        itemHeight: 50.h,
        dropdownDecoration: const BoxDecoration(color: Colors.white),
        customButton: Icon(
          Icons.more_vert,
          size: 36.sp,
          color: Colors.white,
        ),
        items: ['Налаштування', 'Вийти']
            .map((item) => DropdownMenuItem(
                  value: item,
                  child: Text(
                    item,
                    style:
                        TextStyle(fontSize: 20.sp, fontWeight: FontWeight.w400),
                  ),
                ))
            .toList(),
        onChanged: (String? newValue) => onChoice(context, newValue!),
      ),
    );
  }
}
