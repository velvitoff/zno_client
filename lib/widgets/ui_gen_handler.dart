import 'package:client/widgets/ui_generator.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/testing_route_model.dart';

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
    assert(data.length == 2);

    if (data[0] == 'p') {
      return UiGenerator.textToWidget(data[1], style: textStyle);
    }
    if (data[0] == 'img') {
      var model = context.read<TestingRouteModel>();
      return UiGenerator.imageToWidget(model.sessionData.folderName,
          model.sessionData.fileNameNoExtension, data[1]);
    }
    if (allowRenderTables && data[0] == 'table') {
      return UiGenerator.textToTable(context, data[1], style: textStyle);
    }
    if (data[0] == 'audio') {
      var model = context.read<TestingRouteModel>();
      return UiGenerator.audioPlayer(model.sessionData.folderName,
          model.sessionData.fileNameNoExtension, data[1]);
    }
    return Container();
  }
}
