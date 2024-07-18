import 'package:client/locator.dart';
import 'package:client/models/storage_route_item_model.dart';
import 'package:client/routes/storage_route/storage_page.dart';
import 'package:client/routes/storage_route/widgets/storage_route_header.dart';
import 'package:client/widgets/hexagon_dots/hexagon_dots_loading.dart';
import 'package:client/widgets/zno_error.dart';
import 'package:provider/provider.dart';
import 'state/storage_route_state_model.dart';
import 'package:flutter/material.dart';
import 'package:client/services/storage_service.dart';

class StorageRoute extends StatefulWidget {
  const StorageRoute({Key? key}) : super(key: key);

  @override
  State<StorageRoute> createState() => _StorageRouteState();
}

class _StorageRouteState extends State<StorageRoute> {
  late final Future<Map<StorageRouteItemModel, bool>> fileMap;

  @override
  void initState() {
    super.initState();
    fileMap = locator.get<StorageService>().getStorageData().then((data) {
      return Map.fromEntries(data.map((x) => MapEntry(x, false)));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: fileMap,
        builder: (
          context,
          AsyncSnapshot<Map<StorageRouteItemModel, bool>> snapshot,
        ) {
          if (snapshot.hasData) {
            return ChangeNotifierProvider(
              create: (context) => StorageRouteStateModel(
                fileMap: snapshot.data!,
              ),
              child: const Scaffold(
                body: StoragePage(),
              ),
            );
          } else if (snapshot.hasError) {
            return const Column(
              children: [
                StorageRouteHeader(),
                Expanded(
                  child: ZnoError(text: 'Помилка зчитування даних'),
                )
              ],
            );
          } else {
            return Center(
              child: HexagonDotsLoading.def(),
            );
          }
        },
      ),
    );
  }
}
