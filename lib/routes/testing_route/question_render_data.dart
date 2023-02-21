import 'package:client/routes/testing_route/ui_generator.dart';
import 'package:flutter/material.dart';


class QuestionRenderData extends StatelessWidget {
  final List<List<String>> data;

  const QuestionRenderData({
    Key? key,
    required this.data
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return Column(
      children: data.map((list) {
        if (list[0] == 'p') {
          return UiGenerator.textToWidget(list[1]);
        }
        else {
          return Container();
        }
      }).toList(),
    );
  }
}
