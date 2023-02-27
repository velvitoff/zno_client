import 'package:client/models/testing_route_model.dart';
import 'package:client/routes/testing_route/testing_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../dto/question_data.dart';

class TestingPages extends StatelessWidget {
  final List<Question> questions;

  const TestingPages({
    Key? key,
    required this.questions
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Selector<TestingRouteModel, PageController>(
      selector: (_, model) => model.pageController,
      builder: (_, pageController, __) {
        return PageView.builder(
          physics: const NeverScrollableScrollPhysics(),
          controller: pageController,
          scrollDirection: Axis.vertical,
          itemCount: questions.length,
          itemBuilder: (context, position) {
            return TestingPage(
                index: position,
                question: questions[position],
                questionsLength: questions.length
            );
          },
        );
      },
    );
  }
}
