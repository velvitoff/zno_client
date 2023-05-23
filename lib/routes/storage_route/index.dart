import 'package:client/routes/storage_route/storage_list.dart';
import 'package:client/routes/storage_route/storage_route_header.dart';
import 'package:client/routes/storage_route/storage_route_provider.dart';
import 'package:flutter/material.dart';
import 'package:client/widgets/zno_bottom_navigation_bar.dart';

class StorageRoute extends StatelessWidget {
  const StorageRoute({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StorageRouteProvider(
      child: Scaffold(
          body: Column(
            children: const [
              StorageRouteHeader(),
              Expanded(
                child: StorageList(),
              ),
              ZnoBottomNavigationBar(activeIndex: 2)
            ],
          )
      ),
    );
  }
}
