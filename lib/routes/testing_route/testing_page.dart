import 'package:client/dto/question_data.dart';
import 'package:client/models/testing_route_model.dart';
import 'package:client/routes/testing_route/answer_widget.dart';
import 'package:client/routes/testing_route/question_widget.dart';
import 'package:client/routes/testing_route/testing_buttons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import '../../widgets/zno_divider.dart';

class TestingPage extends StatefulWidget {
  final int index;
  final Question question;
  final int questionsLength;

  const TestingPage({
    Key? key,
    required this.index,
    required this.question,
    required this. questionsLength
  }) : super(key: key);

  @override
  State<TestingPage> createState() => _TestingPageState();
}

class _TestingPageState extends State<TestingPage> {
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
    return SingleChildScrollView(
      controller: _scrollController,
      child: ConstrainedBox(
        constraints: BoxConstraints(
            minHeight: 700.h - MediaQuery.of(context).padding.top
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Column(
              children: [
                ZnoDivider(activeIndex: widget.index, itemCount: widget.questionsLength),
                QuestionWidget(
                  index: widget.index,
                  question: widget.question,
                )
              ],
            ),
            Container(
              margin: EdgeInsets.fromLTRB(20.w, 0, 20.w, 0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  AnswerWidget(
                    index: widget.index,
                    question: widget.question,
                  ),
                  TestingButtons(
                    onBack: () => context.read<TestingRouteModel>().decrementPage(),
                    onForward: () => context.read<TestingRouteModel>().incrementPage(),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
