import 'package:auto_size_text/auto_size_text.dart';
import 'package:client/models/storage_route_item_model.dart';
import 'package:client/locator.dart';
import 'package:client/state_models/storage_route_state_model.dart';
import 'package:client/routes/storage_route/storage_list_radio_button.dart';
import 'package:client/services/dialog_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class StorageListItem extends StatelessWidget {
  final StorageRouteItemModel data;
  final bool selected;

  const StorageListItem({Key? key, required this.data, required this.selected})
      : super(key: key);

  void deleteItem(BuildContext context) {
    locator
        .get<DialogService>()
        .showConfirmDialog(context,
            'Видалити файли для "${data.subjectName} ${data.sessionName}"?')
        .then((bool? value) {
      if (value != null && value) {
        try {
          context.read<StorageRouteStateModel>().deleteStorageItem(data.key);
        } catch (e) {
          locator.get<DialogService>().showInfoDialog(context,
              'Сталася помилка під час видалення файлів тестів', 230.h);
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 320.w,
      height: 90.h,
      padding: const EdgeInsets.all(0),
      margin: EdgeInsets.fromLTRB(20.w, 5.h, 20.w, 5.h),
      decoration: BoxDecoration(
          color: const Color(0xFF76AE62).withOpacity(0.04),
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color: const Color(0xFF363636).withOpacity(0.04),
            width: 2,
          )),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Row(
            children: [
              GestureDetector(
                onTap: () => context
                    .read<StorageRouteStateModel>()
                    .setIsMarked(data.key),
                child: StorageListRadioButton(
                  isMarked: selected,
                ),
              ),
              SizedBox(
                width: 165.w,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      data.subjectName,
                      style: TextStyle(
                          fontSize: 20.sp, color: const Color(0xFF444444)),
                      maxLines: 2,
                      overflow: TextOverflow.clip,
                    ),
                    AutoSizeText(
                      data.sessionName,
                      style: const TextStyle(color: Color(0xFF444444)),
                      maxLines: 2,
                      overflow: TextOverflow.clip,
                    )
                  ],
                ),
              )
            ],
          ),
          Row(
            children: [
              Container(
                margin: EdgeInsets.fromLTRB(0, 11.h, 0, 0),
                child: Text(
                  '${(data.size / 1048576).toStringAsFixed(2)}MB', //bytes to megabytes
                  style: TextStyle(
                      fontSize: 16.sp,
                      color: const Color(0xFF444444).withOpacity(0.85)),
                ),
              ),
              GestureDetector(
                onTap: () => deleteItem(context),
                child: Icon(
                  Icons.delete_outline,
                  size: 36.sp,
                  color: const Color(0xFF353535),
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
