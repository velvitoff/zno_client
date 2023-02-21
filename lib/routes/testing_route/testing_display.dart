import 'package:client/routes/testing_route/question_widget.dart';
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

  @override
  Widget build(BuildContext context) {
    return Scrollbar(
      interactive: true,
      thickness: 15.w,
      radius: const Radius.circular(7.5),
      child: ListView.builder(
        scrollDirection: Axis.vertical,
        itemCount: widget.questions.length,
        itemBuilder: (context, position) {
          return ConstrainedBox(
            constraints: BoxConstraints(
                minHeight: 620.h + MediaQuery.of(context).padding.top
            ),
            child: QuestionWidget(
              index: position,
              question: widget.questions[position],
            ),
          );
        },
      ),
    );
  }

}
