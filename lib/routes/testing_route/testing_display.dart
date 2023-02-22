import 'package:client/routes/testing_route/question_widget.dart';
import 'package:client/routes/testing_route/testing_buttons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../dto/question_data.dart';

class TestingDisplay extends StatefulWidget {
  final List<Question> questions;

  const TestingDisplay({
    Key? key,
    required this.questions
  }) : super(key: key);

  @override
  _TestingDisplayState createState() => _TestingDisplayState();
}

class _TestingDisplayState extends State<TestingDisplay> {
  late ScrollController _scrollController;
  late PageController _pageController;

  @override
  void initState(){
    super.initState();
    _scrollController = ScrollController();
    _pageController = PageController();
  }

  @override
  void dispose(){
    _scrollController.dispose();
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    return PageView.builder(
      physics: const NeverScrollableScrollPhysics(),
      controller: _pageController,
      scrollDirection: Axis.vertical,
      itemCount: widget.questions.length,
      itemBuilder: (context, position) {
        return SingleChildScrollView(
          controller: _scrollController,
          child: ConstrainedBox(
            constraints: BoxConstraints(
                minHeight: 630.h + MediaQuery.of(context).padding.top
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                QuestionWidget(
                  index: position,
                  question: widget.questions[position],
                ),
                TestingButtons(
                  onBack: () => _pageController.previousPage(
                      duration: const Duration(milliseconds: 300),
                      curve: Curves.easeInOutSine
                  ),
                  onForward: () => _pageController.nextPage(
                      duration: const Duration(milliseconds: 300),
                      curve: Curves.easeInOutSine
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }

}
