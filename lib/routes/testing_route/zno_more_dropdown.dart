import 'package:client/dialogs/complaint_dialog.dart';
import 'package:client/dialogs/info_dialog.dart';
import 'package:client/dialogs/time_choice_dialog.dart';
import 'package:client/models/auth_state_model.dart';
import 'package:client/models/testing_route_model.dart';
import 'package:client/models/testing_time_model.dart';
import 'package:client/routes.dart';
import 'package:client/services/storage_service/main_storage_service.dart';
import 'package:client/services/supabase_service.dart';
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
                .get<MainStorageService>()
                .saveSessionEnd(context.read<TestingRouteModel>(),
                    context.read<TestingTimeModel>(), false)
                .then((void val) => context.go(Routes.sessionRoute,
                    extra: context.read<TestingRouteModel>().sessionData));
          }
        }
      });
    } else if (value == 'Сховати таймер' || value == 'Показати таймер') {
      context.read<TestingTimeModel>().switchIsActivated();
    } else if (value == 'Змінити час таймера') {
      showDialog<int?>(
          context: context,
          builder: (context) => const TimeChoiceDialog()).then((int? value) {
        if (value != null) {
          context.read<TestingTimeModel>().secondsInTotal = value;
        }
      });
    } else if (value == 'Повідомити про помилку') {
      showDialog<String?>(
          context: context,
          builder: (context) => const ComplaintDialog()).then((String? value) {
        if (value != null) {
          final model = context.read<TestingRouteModel>();
          final authModel = context.read<AuthStateModel>();
          locator
              .get<SupabaseService>()
              .sendComplaint(
                model,
                value,
                authModel.isPremium,
                id: authModel.currentUser?.id,
              )
              .then((bool response) {
            showDialog(
                context: context,
                builder: (context) => InfoDialog(
                    text: response ? 'Дякуємо за відгук!' : 'Сталася помилка ',
                    height: 210.h));
          });
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    List<String> items = [
      'Вийти',
      'Показати таймер',
      'Змінити час таймера',
      'Повідомити про помилку'
    ];
    if (context
        .select<TestingTimeModel, bool>((value) => value.isTimerActivated)) {
      items[1] = 'Сховати таймер';
    }

    return DropdownButtonHideUnderline(
      child: DropdownButton2<String>(
        dropdownStyleData: DropdownStyleData(
          width: 180.w,
          decoration: const BoxDecoration(color: Colors.white),
        ),
        menuItemStyleData: MenuItemStyleData(height: 60.h),
        customButton: Icon(
          Icons.more_vert,
          size: 36.sp,
          color: Colors.white,
        ),
        items: items
            .map((item) => DropdownMenuItem<String>(
                  value: item,
                  child: Text(
                    item,
                    style:
                        TextStyle(fontSize: 20.sp, fontWeight: FontWeight.w400),
                  ),
                ))
            .toList(),
        onChanged: (String? newValue) {
          if (newValue != null) {
            onChoice(context, newValue);
          }
        },
      ),
    );
  }
}
