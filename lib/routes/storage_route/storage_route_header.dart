import 'package:client/dialogs/info_dialog.dart';
import 'package:client/models/storage_route_model.dart';
import 'package:client/routes.dart';
import 'package:client/routes/storage_route/storage_header_radio_button.dart';
import 'package:client/dialogs/confirm_dialog.dart';
import 'package:client/widgets/zno_icon_button.dart';
import 'package:flutter/material.dart';
import 'package:client/widgets/zno_top_header_small.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class StorageRouteHeader extends StatelessWidget {
  const StorageRouteHeader({Key? key}) : super(key: key);

  void deleteSelectedItems(BuildContext context) {
    showDialog<bool>(
        context: context,
        builder: (context) => const ConfirmDialog(
            text: 'Видалити файли усіх обраних тестів?')).then((bool? value) {
      if (value != null && value) {
        try {
          context.read<StorageRouteModel>().deleteSelectedStorageItems();
        } catch (e) {
          showDialog(
              context: context,
              builder: (context) => InfoDialog(
                  height: 230.h,
                  text: 'Сталася помилка під час видалення файлів тестів'));
        }
      }
    });
  }

  void showStorageInfo(BuildContext context) {
    showDialog(
        context: context,
        builder: (context) => InfoDialog(
            height: 300.h,
            isScrollBarAlwaysVisible: true,
            text:
                'Цей додаток зберігає файли тестування, зображення та аудіо-файли на вашому пристрої, що дозволяє вам виконувати тести без зв\'язку з мережею.\n\nФайли автоматично завантажуються на початку спроби проходження тесту.\n\nСторінка "Сховище" дозволяє вам керувати збереженими файлами та видаляти їх.'));
  }

  @override
  Widget build(BuildContext context) {
    return ZnoTopHeaderSmall(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          ZnoIconButton(
              icon: Icons.arrow_back,
              onTap: () => context.go(Routes.settingsRoute)),
          Container(
            margin: EdgeInsets.fromLTRB(0, 0, 12.w, 0),
            child: Row(
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
                    : Container(
                        width: 39.sp,
                      ),
                SizedBox(
                  width: 25.w,
                ),
                GestureDetector(
                  onTap: () =>
                      context.read<StorageRouteModel>().setIsMarkedAll(),
                  child: StorageHeaderRadioButton(
                    isMarked:
                        context.watch<StorageRouteModel>().getIsMarkedAll(),
                  ),
                ),
                SizedBox(
                  width: 25.w,
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
          )
        ],
      ),
    );
  }
}
