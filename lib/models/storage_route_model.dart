import 'package:client/dto/storage_route_item_data.dart';
import 'package:flutter/material.dart';

class StorageRouteModel extends ChangeNotifier {
  Map<StorageRouteItemData, bool> fileMap;

  StorageRouteModel({
    required this.fileMap
  });
}