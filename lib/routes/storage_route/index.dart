import 'package:client/routes/storage_route/storage_list.dart';
import 'package:client/routes/storage_route/storage_route_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:client/widgets/zno_bottom_navigation_bar.dart';

class StorageRoute extends StatelessWidget {
  const StorageRoute({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StorageRouteProvider(
      child: Scaffold(
          body: Column(
            children: [
              Container(
                width: 360.w,
                height: 70.h,
                decoration: const BoxDecoration(
                    gradient: LinearGradient(
                        begin: Alignment.bottomRight,
                        end: Alignment.topLeft,
                        colors: [
                          Color(0xFF38543B),
                          Color(0xFF418C4A)
                        ]
                    ),
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(10),
                      bottomRight: Radius.circular(10),
                    )
                ),
              ),
              const Expanded(
                child: StorageList(),
              ),
              const ZnoBottomNavigationBar(activeIndex: 2)
            ],
          )
      ),
    );
  }
}
