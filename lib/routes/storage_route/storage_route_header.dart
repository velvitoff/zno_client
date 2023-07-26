import 'package:client/dialogs/info_dialog.dart';
import 'package:client/models/storage_route_model.dart';
import 'package:client/routes/storage_route/storage_header_radio_button.dart';
import 'package:client/dialogs/confirm_dialog.dart';
import 'package:flutter/material.dart';
import 'package:client/widgets/zno_top_header_small.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
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
              builder: (context) => const InfoDialog(
                  text: 'Сталася помилка під час видалення файлів тестів'));
        }
      }
    });
  }

  void showStorageInfo(BuildContext context) {
    showDialog(
        context: context,
        builder: (context) => const InfoDialog(
            text:
                'Даний додаток зберігає файли тестування, зображення та аудіо файли на вашому пристрої, що дозволяє вам виконувати тести без зв\'язку з мережею.\n\nФайли автоматично завантажуються на початку спроби проходження теста.\n\nСторінка "Сховище" дозволяє вам керувати збереженими файлами та видаляти їх.'));
  }

  @override
  Widget build(BuildContext context) {
    return ZnoTopHeaderSmall(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            margin: EdgeInsets.fromLTRB(28.w + 2, 0, 0, 0),
            child: GestureDetector(
              onTap: () => context.read<StorageRouteModel>().setIsMarkedAll(),
              child: StorageHeaderRadioButton(
                isMarked: context.watch<StorageRouteModel>().getIsMarkedAll(),
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.fromLTRB(0, 0, 17.w, 0),
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
                    : Container(),
                SizedBox(
                  width: 16.w,
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
