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

  @override
  void initState(){
    super.initState();
    _scrollController = ScrollController();
  }

  @override
  void dispose(){
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    return Scrollbar(
      controller: _scrollController,
      interactive: true,
      thickness: 15.w,
      radius: const Radius.circular(7.5),
      child: ListView.builder(
        controller: _scrollController,
        scrollDirection: Axis.vertical,
        itemCount: widget.questions.length,
        itemBuilder: (context, position) {
          return ConstrainedBox(
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
                  onBack: () {},
                  onForward: () {},
                )
              ],
            ),
          );
        },
      ),
    );
  }

}
