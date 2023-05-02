import 'package:client/models/testing_route_model.dart';
import 'package:client/routes/testing_route/testing_page/testing_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tuple/tuple.dart';
import '../../dto/question_data.dart';

class TestingPages extends StatelessWidget {
  final List<Question> questions;

  const TestingPages({
    Key? key,
    required this.questions
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Selector<TestingRouteModel, Tuple2<PageController, List<Question>>>(
      selector: (_, model) => Tuple2(model.pageController, model.questions),
      builder: (_, data, __) {
        return PageView.builder(
          physics: const NeverScrollableScrollPhysics(),
          controller: data.item1,
          scrollDirection: Axis.vertical,
          itemCount: data.item2.length,
          itemBuilder: (context, position) {
            return TestingPage(
                index: position,
                question: data.item2[position],
                questionsLength: data.item2.length
            );
          },
        );
      },
    );
  }
}
