import 'package:client/dto/storage_route_item_data.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class StorageListItem extends StatelessWidget {
  final StorageRouteItemData data;

  const StorageListItem({
    Key? key,
    required this.data
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 320.w,
      height: 70.h,
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
        children: [
          Container(
            width: 30.r,
            height: 30.r,
            margin: EdgeInsets.fromLTRB(10.w, 0, 10.w, 0),
            decoration: BoxDecoration(
              color: const Color(0xFF76AE62).withOpacity(0.04),
              borderRadius: BorderRadius.circular(10),
              border: Border.all(
                color: const Color(0xFF363636).withOpacity(0.1),
                width: 2,
              )
            ),
          ),
          SizedBox(
            width: 200.w,
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
                  overflow: TextOverflow.clip,
                )
              ],
            ),
          ),
          Text(
            '${(data.size / 1048576).toStringAsFixed(2)}MB',
            style: TextStyle(fontSize: 16.sp, color: const Color(0xFF444444).withOpacity(0.85)),
          )
        ],
      ),
    );
  }
}
