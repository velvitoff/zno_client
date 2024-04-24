import 'package:flutter/material.dart';

class StorageRouteItemModel {
  final String subjectName;
  final String sessionName;
  final String filePath;
  final String imageFolderPath;
  final int size;
  final UniqueKey key;

  const StorageRouteItemModel(
      {required this.subjectName,
      required this.sessionName,
      required this.filePath,
      required this.imageFolderPath,
      required this.size,
      required this.key});
}
