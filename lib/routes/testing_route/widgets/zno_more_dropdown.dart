import 'package:client/locator.dart';
import 'package:client/state_models/auth_state_model.dart';
import 'package:client/routes/testing_route/state/testing_route_state_model.dart';
import 'package:client/routes/testing_route/state/testing_time_state_model.dart';
import 'package:client/routes.dart';
import 'package:client/services/dialog_service.dart';
import 'package:client/services/storage_service.dart';
import 'package:client/services/supabase_service.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class ZnoMoreDropdown extends StatefulWidget {
  const ZnoMoreDropdown({Key? key}) : super(key: key);

  @override
  State<ZnoMoreDropdown> createState() => _ZnoMoreDropdownState();
}

class _ZnoMoreDropdownState extends State<ZnoMoreDropdown> {
  @override
  Widget build(BuildContext context) {
    final isTimerActivated = context
        .select<TestingTimeStateModel, bool>((value) => value.isTimerActivated);

    List<String> items = [
      'Вийти',
      isTimerActivated ? 'Сховати таймер' : 'Показати таймер',
      'Знайшли помилку?'
    ];

    return DropdownButtonHideUnderline(
      child: DropdownButton2<String>(
        dropdownStyleData: DropdownStyleData(
          width: 200.w,
          decoration: BoxDecoration(
              color: Colors.white, borderRadius: BorderRadius.circular(2)),
        ),
        menuItemStyleData: MenuItemStyleData(
          padding: const EdgeInsets.symmetric(horizontal: 4.0),
          customHeights: _getCustomItemsHeights(items),
        ),
        customButton: Icon(
          Icons.more_vert,
          size: 36.sp,
          color: Colors.white,
        ),
        items: _getWidgetItems(items),
        onChanged: (String? newValue) {
          if (newValue != null) {
            _onChoice(context, newValue);
          }
        },
      ),
    );
  }

  List<DropdownMenuItem<String>> _getWidgetItems(List<String> items) {
    List<DropdownMenuItem<String>> result = [];
    for (String item in items) {
      result.addAll([
        DropdownMenuItem<String>(
          value: item,
          child: Text(
            item,
            style: TextStyle(fontSize: 20.sp, fontWeight: FontWeight.w400),
          ),
        ),
        if (item != items.last)
          const DropdownMenuItem<String>(
            enabled: false,
            child: Divider(
              color: Color(0xFFE8E8E8),
            ),
          )
      ]);
    }

    return result;
  }

  List<double> _getCustomItemsHeights(List<String> items) {
    final List<double> itemsHeights = [];
    for (int i = 0; i < (items.length * 2) - 1; i++) {
      if (i.isEven) {
        itemsHeights.add(60.h);
      } else {
        itemsHeights.add(2.h);
      }
    }

    return itemsHeights;
  }

  void _onChoice(BuildContext context, String value) {
    bool isViewMode = context.read<TestingRouteStateModel>().isViewMode;
    if (value == 'Вийти') {
      _handleExitChoice(context, isViewMode);
    } else if (value == 'Сховати таймер' || value == 'Показати таймер') {
      _handleSwitchTimer(context);
    } else if (value == 'Знайшли помилку?') {
      _handleComplaint(context);
    }
  }

  Future<void> _handleExitChoice(BuildContext context, bool isViewMode) async {
    bool confirmation = await locator.get<DialogService>().showConfirmDialog(
        context,
        isViewMode
            ? 'Ви дійсно хочете припинити перегляд?'
            : 'Ви дійсно хочете покинути спробу?');

    if (!confirmation) return;
    if (!context.mounted) return;

    if (!isViewMode) {
      locator
          .get<StorageService>()
          .saveSessionEnd(context.read<TestingRouteStateModel>(),
              context.read<TestingTimeStateModel>(), false)
          .then((void val) => context.go(Routes.sessionRoute,
              extra: context.read<TestingRouteStateModel>().sessionData));
    } else {
      context.go(Routes.sessionRoute,
          extra: context.read<TestingRouteStateModel>().sessionData);
    }
  }

  void _handleSwitchTimer(BuildContext context) {
    context.read<TestingTimeStateModel>().switchIsActivated();
  }

  Future<void> _handleComplaint(BuildContext context) async {
    String? text =
        await locator.get<DialogService>().showComplaintDialog(context);

    if (text == null || text == "") return;
    if (!context.mounted) return;

    final model = context.read<TestingRouteStateModel>();
    final authModel = context.read<AuthStateModel>();

    final complaintResponse =
        await locator.get<SupabaseService>().sendComplaint(
              model,
              text,
              authModel.isPremium,
              userId: authModel.currentUser?.id,
            );

    if (!context.mounted) return;
    locator.get<DialogService>().showInfoDialog(context,
        complaintResponse ? 'Дякуємо за відгук!' : 'Сталася помилка', 230.h);
  }
}
