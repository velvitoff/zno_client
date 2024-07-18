import 'package:client/routes/storage_route/state/storage_route_state_model.dart';
import 'package:client/routes/storage_route/widgets/storage_route_header.dart';
import 'package:flutter/material.dart';
import 'package:client/routes/storage_route/widgets/storage_list.dart';
import 'package:client/widgets/zno_error.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class StoragePage extends StatelessWidget {
  const StoragePage({super.key});

  @override
  Widget build(BuildContext context) {
    final data = context.watch<StorageRouteStateModel>().fileMap;

    return Column(
      children: [
        const StorageRouteHeader(),
        Expanded(
          child: data.isNotEmpty
              ? StorageList(
                  data: data,
                )
              : ZnoError(
                  text: 'Немає збережених даних',
                  textFontSize: 25.sp,
                ),
        ),
      ],
    );
  }
}
