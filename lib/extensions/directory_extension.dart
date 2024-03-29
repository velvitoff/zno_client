import 'dart:io';

extension Length on Directory {
  Future<int> length({bool recursive = false}) async {
    if (!(await exists())) {
      return 0;
    }
    int size = 0;
    var lst = await list().toList();

    for (var entity in lst) {
      if (entity is File) {
        var file = entity;
        size += await file.length();
      }
      else if (entity is Directory && recursive) {
        var dir = entity;
        size += await dir.length(recursive: true);
      }
    }

    return size;
  }
}