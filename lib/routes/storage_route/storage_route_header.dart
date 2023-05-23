import 'package:client/models/storage_route_model.dart';
import 'package:client/routes/storage_route/storage_header_radio_button.dart';
import 'package:flutter/material.dart';
import 'package:client/widgets/zno_top_header_small.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class StorageRouteHeader extends StatelessWidget {
  const StorageRouteHeader({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ZnoTopHeaderSmall(
      child: Row(
        children: [
          Container(
            margin: EdgeInsets.fromLTRB(28.w + 2, 0, 0, 0),
            child: GestureDetector(
              onTap: () => context.read<StorageRouteModel>().setIsMarkedAll(),
              child: StorageHeaderRadioButton(
                isMarked: context.watch<StorageRouteModel>().getIsMarkedAll(),
              ),
            ),
          )
        ],
      ),
    );
  }
}
