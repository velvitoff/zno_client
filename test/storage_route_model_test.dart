import 'package:client/dto/storage_route_item_data.dart';
import 'package:client/models/storage_route_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  Map<StorageRouteItemData, bool> map = {};
  for (int i = 0; i < 4; ++i) {
    map[StorageRouteItemData(
        subjectName: '',
        sessionName: '',
        filePath: '',
        imageFolderPath: '',
        size: 0,
        key: UniqueKey())] = false;
  }

  final model = StorageRouteModel(fileMap: map);

  test('Test storage_route_model marking items', () async {
    final key = model.fileMap.entries.first.key.key;
    expect(model.getIsMarked(key), false);
    model.setIsMarked(key);
    expect(model.getIsMarked(key), true);
  });

  test('Test storage_route_model marking all items', () async {
    expect(model.getIsMarkedAll(), false);
    model.setIsMarkedAll();
    expect(model.getIsMarkedAll(), true);
  });
}
