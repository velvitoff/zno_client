import 'package:client/routes/testing_route/ui_creator/creators/audio_player_creator.dart';
import 'package:client/routes/testing_route/ui_creator/creators/image_creator.dart';
import 'package:client/routes/testing_route/ui_creator/creators/table_creator.dart';
import 'package:client/routes/testing_route/ui_creator/creators/text_creator.dart';
import 'package:client/routes/testing_route/ui_creator/widgets/horizontal_scroll_wrapper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class UiCreator extends StatelessWidget {
  final List<String> data;
  final TextStyle? textStyle;
  final bool allowRenderTables;

  const UiCreator({
    Key? key,
    required this.data,
    this.textStyle,
    this.allowRenderTables = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (data.isEmpty) {
      return Container();
    }

    if (data[0] == 'p') {
      return TextCreator(text: data[1], style: textStyle).create();
    }
    if (data[0] == 'img') {
      return ImageCreator(context: context, fileName: data[1]).create();
    }
    if (data[0] == 'table' && allowRenderTables) {
      return TableCreator(context: context, data: data[1], style: textStyle)
          .create();
    }
    if (data[0] == 'br') {
      return SizedBox(height: 15.h);
    }
    if (data[0] == 'scroll') {
      //provides horizontal scroll
      return HorizontalScrollWrapper(
        child: UiCreator(data: [data[1], data[2]]),
      );
    }
    if (data[0] == 'audio') {
      return AudioPlayerCreator(context: context, fileName: data[1]).create();
    }
    return Container();
  }
}
