import 'package:client/routes.dart';
import 'package:client/routes/storage_route/storage_list.dart';
import 'package:client/routes/storage_route/storage_route_header.dart';
import 'package:client/providers/storage_route_provider.dart';
import 'package:client/services/storage_service/main_storage_service.dart';
import 'package:client/widgets/hexagon_dots/hexagon_dots_loading.dart';
import 'package:client/widgets/zno_error.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import '../../dto/storage_route_item_data.dart';
import '../../locator.dart';
import '../../models/storage_route_model.dart';

class StorageRoute extends StatefulWidget {
  const StorageRoute({Key? key}) : super(key: key);

  @override
  State<StorageRoute> createState() => _StorageRouteState();
}

class _StorageRouteState extends State<StorageRoute> {
  late final Future<List<StorageRouteItemData>> storageList;

  @override
  void initState() {
    storageList = locator.get<MainStorageService>().getStorageData();
    super.initState();
  }

  void _onPopInvoked(void didPop) {
    context.go(Routes.settingsRoute);
  }

  @override
  Widget build(BuildContext context) {
    return StorageRouteProvider(
      child: PopScope(
        canPop: false,
        onPopInvoked: _onPopInvoked,
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
                    if (snapshot.data!.isEmpty) {
                      return ZnoError(
                        text: 'Немає збережених даних',
                        textFontSize: 25.sp,
                      );
                    }
                    context.read<StorageRouteModel>().fileMap = Map.fromEntries(
                        snapshot.data!.map((x) => MapEntry(x, false)));
                    return const StorageList();
                  } else if (snapshot.hasError) {
                    return const ZnoError(text: 'Помилка зчитування даних');
                  } else {
                    return Center(
                      child: HexagonDotsLoading.def(),
                    );
                  }
                },
              ),
            )
          ],
        )),
      ),
    );
  }
}
