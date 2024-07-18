import 'package:client/locator.dart';
import 'package:client/routes/storage_route/state/storage_route_state_model.dart';
import 'package:client/routes/storage_route/widgets/storage_header_radio_button.dart';
import 'package:client/services/dialog_service.dart';
import 'package:client/widgets/zno_icon_button.dart';
import 'package:flutter/material.dart';
import 'package:client/widgets/zno_top_header_small.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class StorageRouteHeader extends StatelessWidget {
  const StorageRouteHeader({Key? key}) : super(key: key);

  void _onBack(BuildContext context) {
    if (!context.canPop()) return;
    context.pop();
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
                onTap: () => _onBack(context),
              ),
            ),
            Align(
              alignment: Alignment.center,
              child: Text(
                'Сховище',
                style: TextStyle(
                  color: const Color(0xFFEFEFEF),
                  fontSize: 24.sp,
                ),
              ),
            ),
            const Align(
              alignment: Alignment.centerRight,
              child: _RightSideMenu(),
            )
          ],
        ),
      ),
    );
  }
}

class _RightSideMenu extends StatelessWidget {
  const _RightSideMenu();

  Future<void> _deleteSelectedItems(BuildContext context) async {
    bool confirmation = await locator
        .get<DialogService>()
        .showConfirmDialog(context, 'Видалити файли усіх обраних тестів?');

    if (!confirmation) return;
    if (!context.mounted) return;

    try {
      context.read<StorageRouteStateModel>().deleteSelectedStorageItems();
    } catch (e) {
      locator.get<DialogService>().showInfoDialog(
          context, 'Сталася помилка під час видалення файлів тестів', 230.h);
    }
  }

  void _showStorageInfo(BuildContext context) {
    locator.get<DialogService>().showInfoDialog(
        context,
        'Цей додаток зберігає файли тестування, зображення та аудіо-файли на вашому пристрої, що дозволяє вам виконувати тести без зв\'язку з мережею.\n\nФайли автоматично завантажуються на початку спроби проходження тесту.\n\nСторінка "Сховище" дозволяє вам керувати збереженими файлами та видаляти їх.',
        500.h,
        isScrollAlwaysVisible: true);
  }

  void _onTapRadioButton(BuildContext context) {
    context.read<StorageRouteStateModel>().setIsMarkedAll();
  }

  @override
  Widget build(BuildContext context) {
    final StorageRouteStateModel? storageModel =
        context.watch<StorageRouteStateModel?>();
    if (storageModel == null || storageModel.isEmpty()) {
      return Container();
    }

    final isAtLeastOneItemMarked = storageModel.isAtLeastOneItemMarked();
    final isMarkedAll = storageModel.getIsMarkedAll();

    return SizedBox(
      height: double.infinity,
      width: 126.w,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          isAtLeastOneItemMarked
              ? GestureDetector(
                  onTap: () => _deleteSelectedItems(context),
                  child: Icon(
                    Icons.delete_outline,
                    size: 39.sp,
                    color: const Color(0xFFF1F1F1),
                  ),
                )
              : Container(width: 39.sp),
          GestureDetector(
            onTap: () => _onTapRadioButton(context),
            child: StorageHeaderRadioButton(
              isMarked: isMarkedAll,
            ),
          ),
          GestureDetector(
            onTap: () => _showStorageInfo(context),
            child: Icon(
              Icons.help_outline,
              size: 43.sp,
              color: const Color(0xFFF1F1F1),
            ),
          )
        ],
      ),
    );
  }
}
