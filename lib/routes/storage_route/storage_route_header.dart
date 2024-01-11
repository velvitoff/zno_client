import 'package:client/locator.dart';
import 'package:client/models/storage_route_model.dart';
import 'package:client/routes.dart';
import 'package:client/routes/storage_route/storage_header_radio_button.dart';
import 'package:client/services/dialog_service.dart';
import 'package:client/widgets/zno_icon_button.dart';
import 'package:flutter/material.dart';
import 'package:client/widgets/zno_top_header_small.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class StorageRouteHeader extends StatelessWidget {
  const StorageRouteHeader({Key? key}) : super(key: key);

  void deleteSelectedItems(BuildContext context) {
    locator
        .get<DialogService>()
        .showConfirmDialog(context, 'Видалити файли усіх обраних тестів?')
        .then((bool? value) {
      if (value != null && value) {
        try {
          context.read<StorageRouteModel>().deleteSelectedStorageItems();
        } catch (e) {
          locator.get<DialogService>().showInfoDialog(context,
              'Сталася помилка під час видалення файлів тестів', 230.h);
        }
      }
    });
  }

  void showStorageInfo(BuildContext context) {
    locator.get<DialogService>().showInfoDialog(
        context,
        'Цей додаток зберігає файли тестування, зображення та аудіо-файли на вашому пристрої, що дозволяє вам виконувати тести без зв\'язку з мережею.\n\nФайли автоматично завантажуються на початку спроби проходження тесту.\n\nСторінка "Сховище" дозволяє вам керувати збереженими файлами та видаляти їх.',
        300.h,
        isScrollAlwaysVisible: true);
  }

  @override
  Widget build(BuildContext context) {
    return ZnoTopHeaderSmall(
      child: Padding(
        padding: EdgeInsets.only(left: 6.w, right: 6.w),
        child: Stack(
          children: [
            Align(
              alignment: Alignment.centerLeft,
              child: ZnoIconButton(
                  icon: Icons.arrow_back,
                  onTap: () => context.go(Routes.settingsRoute)),
            ),
            Align(
              alignment: Alignment.center,
              child: Text('Сховище',
                  style: TextStyle(
                      color: const Color(0xFFEFEFEF), fontSize: 24.sp)),
            ),
            Align(
              alignment: Alignment.centerRight,
              child: SizedBox(
                height: double.infinity,
                width: 126.w,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    context.watch<StorageRouteModel>().isAtLeastOneItemMarked()
                        ? GestureDetector(
                            onTap: () => deleteSelectedItems(context),
                            child: Icon(
                              Icons.delete_outline,
                              size: 39.sp,
                              color: const Color(0xFFF1F1F1),
                            ),
                          )
                        : Container(width: 39.sp),
                    GestureDetector(
                      onTap: () =>
                          context.read<StorageRouteModel>().setIsMarkedAll(),
                      child: StorageHeaderRadioButton(
                        isMarked:
                            context.watch<StorageRouteModel>().getIsMarkedAll(),
                      ),
                    ),
                    GestureDetector(
                      onTap: () => showStorageInfo(context),
                      child: Icon(
                        Icons.help_outline,
                        size: 43.sp,
                        color: const Color(0xFFF1F1F1),
                      ),
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
