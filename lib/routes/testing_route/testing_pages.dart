import 'package:client/routes/testing_route/testing_page.dart';
import 'package:flutter/material.dart';
import '../../dto/question_data.dart';

class TestingPages extends StatefulWidget {
  final List<Question> questions;

  const TestingPages({
    Key? key,
    required this.questions
  }) : super(key: key);

  @override
  _TestingPagesState createState() => _TestingPagesState();
}

class _TestingPagesState extends State<TestingPages> {
  late PageController _pageController;

  @override
  void initState(){
    super.initState();
    _pageController = PageController(initialPage: 0);
  }

  @override
  void dispose(){
    _pageController.dispose();
    super.dispose();
  }

  void incrementPage() {
    if (_pageController.page != null) {
      _pageController.nextPage(
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeInOutSine
      );
    }
  }

  void decrementPage() {
    if (_pageController.page != null) {
      _pageController.previousPage(
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeInOutSine
      );
    }
  }

  @override
  Widget build(BuildContext context) {

    return PageView.builder(
      physics: const NeverScrollableScrollPhysics(),
      controller: _pageController,
      scrollDirection: Axis.vertical,
      itemCount: widget.questions.length,
      itemBuilder: (context, position) {
        return TestingPage(
            index: position,
            question: widget.questions[position],
            onDecrementPage: decrementPage,
            onIncrementPage: incrementPage,
        );
      },
    );
  }

}
