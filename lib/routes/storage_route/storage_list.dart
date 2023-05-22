import 'package:client/locator.dart';
import 'package:client/models/storage_route_model.dart';
import 'package:client/routes/storage_route/storage_list_item.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../dto/storage_route_item_data.dart';
import '../../services/interfaces/storage_service.dart';

class StorageList extends StatefulWidget {
  const StorageList({Key? key}) : super(key: key);

  @override
  State<StorageList> createState() => _StorageListState();
}

class _StorageListState extends State<StorageList> {
  late final Future<List<StorageRouteItemData>> storageList;

  @override
  void initState(){
    storageList = locator.get<StorageService>().getStorageData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: storageList,
      builder: (BuildContext context, AsyncSnapshot<List<StorageRouteItemData>> snapshot) {
        if (snapshot.hasData) {
          context.read<StorageRouteModel>().fileMap = Map.fromEntries(snapshot.data!.map((x) => MapEntry(x, false)));
          return ListView(
            children: snapshot.data!.map((item) {
              return StorageListItem(data: item);
            }).toList(),
          );
        }
        else if (snapshot.hasError) {
          return const Text('Помилка завантаження даних');
        }
        else {
          return const Text('Завантаження');
        }
      },
    );
  }
}
