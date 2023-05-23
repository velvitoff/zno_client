import 'package:client/dto/storage_route_item_data.dart';
import 'package:flutter/material.dart';

class StorageRouteModel extends ChangeNotifier {
  Map<StorageRouteItemData, bool> fileMap;

  StorageRouteModel({
    required this.fileMap
  });

  bool getIsMarked(UniqueKey inKey) {
    for(var entry in fileMap.entries) {
      if (entry.key.key == inKey){
        return entry.value;
      }
    }
    return false;
  }

  void setIsMarked(UniqueKey inKey) {
    for(var data in fileMap.keys) {
      if (data.key == inKey) {
        fileMap[data] = !fileMap[data]!;
        notifyListeners();
        break;
      }
    }
  }

  bool getIsMarkedAll() {
    for(var value in fileMap.values) {
      if(!value) {
        return false;
      }
    }
    return true;
  }

  void setIsMarkedAll() {
    if (getIsMarkedAll()) {
      for(var key in fileMap.keys) {
        fileMap[key] = false;
      }
      notifyListeners();
      return;
    }

    for(var key in fileMap.keys) {
      fileMap[key] = true;
    }
    notifyListeners();
  }

}