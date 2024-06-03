import 'package:client/models/storage_route_item_model.dart';
import 'package:flutter/material.dart';
import 'dart:io';

class StorageRouteStateModel extends ChangeNotifier {
  final Map<StorageRouteItemModel, bool> fileMap;

  StorageRouteStateModel({required this.fileMap});

  bool getIsMarked(UniqueKey inKey) {
    for (var entry in fileMap.entries) {
      if (entry.key.key == inKey) {
        return entry.value;
      }
    }
    return false;
  }

  void setIsMarked(UniqueKey inKey) {
    for (var data in fileMap.keys) {
      if (data.key == inKey) {
        fileMap[data] = !fileMap[data]!;
        notifyListeners();
        break;
      }
    }
  }

  bool getIsMarkedAll() {
    if (fileMap.isEmpty) {
      return false;
    }
    for (var value in fileMap.values) {
      if (value == false) {
        return false;
      }
    }
    return true;
  }

  void setIsMarkedAll() {
    if (getIsMarkedAll()) {
      for (var key in fileMap.keys) {
        fileMap[key] = false;
      }
      notifyListeners();
      return;
    }

    for (var key in fileMap.keys) {
      fileMap[key] = true;
    }
    notifyListeners();
  }

  bool isAtLeastOneItemMarked() {
    for (var value in fileMap.values) {
      if (value) {
        return true;
      }
    }
    return false;
  }

  //THROWS
  Future<void> deleteSelectedStorageItems() async {
    final List<StorageRouteItemModel> selectedItems = fileMap.entries
        .where((entry) => entry.value == true)
        .map((entry) => entry.key)
        .toList();

    for (var item in selectedItems) {
      File file = File(item.filePath);
      Directory imageDir = Directory(item.imageFolderPath);

      if (await imageDir.exists()) {
        await imageDir.delete(recursive: true);
      }
      if (await file.exists()) {
        await file.delete();
      }

      fileMap.remove(item);
    }

    notifyListeners();
  }

  //TO DO: move functionality to localStorage
  Future<void> deleteStorageItem(UniqueKey key) async {
    StorageRouteItemModel? item;
    for (var entry in fileMap.entries) {
      if (entry.key.key == key) {
        item = entry.key;
        break;
      }
    }

    if (item == null) {
      return;
    }

    File file = File(item.filePath);
    Directory imageDir = Directory(item.imageFolderPath);
    if (await imageDir.exists()) {
      await imageDir.delete(recursive: true);
    }
    if (await file.exists()) {
      await file.delete();
    }

    fileMap.remove(item);
    notifyListeners();
  }
}
