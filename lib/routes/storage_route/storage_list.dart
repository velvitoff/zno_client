import 'package:client/routes/storage_route/storage_list_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import '../../models/storage_route_model.dart';

class StorageList extends StatelessWidget {
  const StorageList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: EdgeInsets.only(top: 5.h),
      children: context.watch<StorageRouteModel>().fileMap.entries.map((entry) {
        return StorageListItem(data: entry.key, selected: entry.value);
      }).toList(),
    );
  }
}
