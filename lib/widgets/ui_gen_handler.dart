import 'package:client/widgets/ui_generator.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/testing_route_model.dart';

class UiGenHandler extends StatelessWidget {
  final List<String> data;
  final TextStyle? textStyle;

  const UiGenHandler({
    Key? key,
    required this.data,
    this.textStyle
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    assert(data.length == 2);
    switch (data[0]) {
      case 'p':
        return UiGenerator.textToWidget(data[1], style: textStyle);
      case 'img':
        var model = context.read<TestingRouteModel>();
        return UiGenerator.imageToWidget(model.sessionData.folderName, model.sessionData.fileName, data[1]);
      case 'table':
        return UiGenerator.textToTable(context, data[1]);
      default:
        return Container();
    }
  }
}
