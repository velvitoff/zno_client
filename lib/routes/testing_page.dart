import 'package:client/dto/question_data.dart';
import 'package:client/models/testing_route_model.dart';
import 'package:client/routes/testing_route/question_widget.dart';
import 'package:client/routes/testing_route/testing_buttons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class TestingPage extends StatefulWidget {
  final int index;
  final Question question;
  final void Function() onIncrementPage;
  final void Function() onDecrementPage;

  const TestingPage({
    Key? key,
    required this.index,
    required this.question,
    required this.onIncrementPage,
    required this.onDecrementPage
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
            minHeight: 630.h + MediaQuery.of(context).padding.top
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            QuestionWidget(
              index: widget.index,
              question: widget.question,
            ),
            TestingButtons(
              onBack: widget.onDecrementPage,
              onForward: widget.onIncrementPage,
            )
          ],
        ),
      ),
    );
  }
}
