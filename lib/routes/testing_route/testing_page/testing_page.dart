import 'package:client/dto/question_data.dart';
import 'package:client/models/testing_route_model.dart';
import 'package:client/routes.dart';
import 'package:client/routes/testing_route/testing_page/answer_widget.dart';
import 'package:client/routes/testing_route/testing_page/question_widget.dart';
import 'package:client/routes/testing_route/testing_page/testing_buttons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import '../../../widgets/confirm_dialog.dart';
import '../../../widgets/zno_divider.dart';

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

  void onEndSession(BuildContext context) {
    showDialog<bool>(
        context: context,
        builder: (BuildContext context) => const ConfirmDialog(
          text: 'Завершити спробу?',
        )
    )
    .then((bool? value) {
      if (value != null) {
        if (value) {
          //TODO: call storage service to save history file
          context.go(Routes.subjectsRoute);
        }
      }
    });
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
                    onForward: 
                      widget.index == widget.questionsLength - 1
                      ?
                      () => onEndSession(context)    
                      :
                      () => context.read<TestingRouteModel>().incrementPage(),
                    isFirstPage: widget.index == 0,
                    isLastPage: widget.index == widget.questionsLength - 1,
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