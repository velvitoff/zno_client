import 'package:client/routes/storage_route/storage_list.dart';
import 'package:client/routes/storage_route/storage_route_header.dart';
import 'package:client/routes/storage_route/storage_route_provider.dart';
import 'package:flutter/material.dart';
import 'package:client/widgets/zno_bottom_navigation_bar.dart';
import 'package:provider/provider.dart';

import '../../dto/storage_route_item_data.dart';
import '../../locator.dart';
import '../../models/storage_route_model.dart';
import '../../services/interfaces/storage_service_interface.dart';

class StorageRoute extends StatefulWidget {
  const StorageRoute({Key? key}) : super(key: key);

  @override
  State<StorageRoute> createState() => _StorageRouteState();
}

class _StorageRouteState extends State<StorageRoute> {
  late final Future<List<StorageRouteItemData>> storageList;

  @override
  void initState() {
    storageList = locator.get<StorageServiceInterface>().getStorageData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return StorageRouteProvider(
      child: Scaffold(
          body: Column(
        children: [
          const StorageRouteHeader(),
          Expanded(
            child: FutureBuilder(
              future: storageList,
              builder: (BuildContext context,
                  AsyncSnapshot<List<StorageRouteItemData>> snapshot) {
                if (snapshot.hasData) {
                  context.read<StorageRouteModel>().fileMap = Map.fromEntries(
                      snapshot.data!.map((x) => MapEntry(x, false)));
                  return const StorageList();
                } else if (snapshot.hasError) {
                  return const Text('Помилка завантаження даних');
                } else {
                  return const Text('Завантаження');
                }
              },
            ),
          ),
          const ZnoBottomNavigationBar(activeIndex: 2)
        ],
      )),
    );
  }
}
