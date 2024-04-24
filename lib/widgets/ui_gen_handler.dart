import 'package:client/state_models/auth_state_model.dart';
import 'package:client/widgets/horizontal_scroll_wrapper.dart';
import 'package:client/widgets/ui_generator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import '../state_models/testing_route_state_model.dart';

class UiGenHandler extends StatelessWidget {
  final List<String> data;
  final TextStyle? textStyle;
  final bool allowRenderTables;

  const UiGenHandler(
      {Key? key,
      required this.data,
      this.textStyle,
      this.allowRenderTables = true})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (data.isEmpty) {
      return Container();
    }

    if (data[0] == 'p') {
      return UiGenerator.textToWidget(data[1], style: textStyle);
    }
    if (data[0] == 'img') {
      //1
      var model = context.read<TestingRouteStateModel>();
      final isPremium = context.read<AuthStateModel>().isPremium;
      return UiGenerator.imageToWidget(model.sessionData, data[1], isPremium);
    }
    if (data[0] == 'table' && allowRenderTables) {
      return UiGenerator.textToTable(context, data[1], style: textStyle);
    }
    if (data[0] == 'br') {
      return SizedBox(height: 15.h);
    }
    if (data[0] == 'scroll') {
      //provides horizontal scroll
      return HorizontalScrollWrapper(
        child: UiGenHandler(data: [data[1], data[2]]),
      );
    }
    if (data[0] == 'audio') {
      var model = context.read<TestingRouteStateModel>();
      return UiGenerator.audioPlayer(model.sessionData, data[1]);
    }
    return Container();
  }
}
