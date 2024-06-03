import 'package:client/models/storage_route_item_model.dart';
import 'package:client/routes/storage_route/widgets/storage_list_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class StorageList extends StatelessWidget {
  final Map<StorageRouteItemModel, bool> data;
  const StorageList({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: EdgeInsets.only(top: 5.h),
      children: data.entries.map((entry) {
        return StorageListItem(data: entry.key, selected: entry.value);
      }).toList(),
    );
  }
}
