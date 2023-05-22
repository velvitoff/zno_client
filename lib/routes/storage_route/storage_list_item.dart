import 'package:client/dto/storage_route_item_data.dart';
import 'package:flutter/material.dart';

class StorageListItem extends StatelessWidget {
  final StorageRouteItemData data;

  const StorageListItem({
    Key? key,
    required this.data
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(data.sessionName);
  }
}
