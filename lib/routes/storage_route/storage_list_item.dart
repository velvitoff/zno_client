import 'package:client/dialogs/confirm_dialog.dart';
import 'package:client/dto/storage_route_item_data.dart';
import 'package:client/models/storage_route_model.dart';
import 'package:client/routes/storage_route/storage_list_radio_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import '../../dialogs/info_dialog.dart';

class StorageListItem extends StatelessWidget {
  final StorageRouteItemData data;
  final bool selected;

  const StorageListItem({
    Key? key,
    required this.data,
    required this.selected
  }) : super(key: key);

  void deleteItem(BuildContext context) {
    showDialog<bool>(
      context: context,
      builder: (context) => ConfirmDialog(text: 'Видалити файли для "${data.subjectName} ${data.sessionName}"?')
    )
    .then((bool? value) {
      if(value != null && value) {
        try {
          context.read<StorageRouteModel>().deleteStorageItem(data.key);
        }
        catch (e) {
          showDialog(
              context: context,
              builder: (context) => const InfoDialog(text: 'Сталася помилка під час видалення файлів тестів')
          );
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
        )
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Row(
            children: [
              GestureDetector(
                onTap: () => context.read<StorageRouteModel>().setIsMarked(data.key),
                child: StorageListRadioButton(
                  isMarked: selected,
                ),
              ),
              SizedBox(
                width: 180.w,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      data.subjectName,
                      style: TextStyle(fontSize: 20.sp, color: const Color(0xFF444444)),
                      maxLines: 2,
                      overflow: TextOverflow.clip,
                    ),
                    Text(
                      data.sessionName,
                      style: TextStyle(fontSize: 16.sp, color: const Color(0xFF444444)),
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
                  '${(data.size / 1048576).toStringAsFixed(2)}MB',//bytes to megabytes
                  style: TextStyle(fontSize: 16.sp, color: const Color(0xFF444444).withOpacity(0.85)),
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
