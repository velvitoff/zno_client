import 'package:client/models/answers/answer.dart';
import 'package:client/models/questions/question.dart';
import 'package:client/routes/testing_route/state/testing_route_state_model.dart';
import 'package:client/widgets/answer_cell.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class QuestionSingleAnswerField extends StatelessWidget {
  final QuestionSingle question;
  final int index;

  const QuestionSingleAnswerField({
    Key? key,
    required this.question,
    required this.index,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final bool editable = !context.read<TestingRouteStateModel>().isViewMode;
    final List<String> variants = question.answerList;
    final Answer? answer = context.select<TestingRouteStateModel, Answer?>(
        (model) => model.getAnswer(question.order));

    return Container(
      margin: EdgeInsets.fromLTRB(0, 10.h, 0, 10.h),
      child: Wrap(
        alignment: WrapAlignment.center,
        spacing: 10.w,
        children: variants.map((variant) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                variant,
                style: TextStyle(
                  fontSize: 32.sp,
                  fontWeight: FontWeight.w500,
                ),
              ),
              editable
                  ? _EditableCell(
                      question: question,
                      answer: answer,
                      title: variant,
                    )
                  : _NotEditableCell(
                      question: question,
                      answer: answer,
                      title: variant,
                    )
            ],
          );
        }).toList(),
      ),
    );
  }
}

class _NotEditableCell extends StatelessWidget {
  final QuestionSingle question;
  final Answer? answer;
  final String title;
  const _NotEditableCell({
    required this.question,
    required this.answer,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    final Answer? answer = context.select<TestingRouteStateModel, Answer?>(
        (model) => model.getAnswer(question.order));

    if (question.correct.contains(title)) {
      return const AnswerCell(answerColor: AnswerCellColor.green);
    }
    if (answer is! AnswerSingle) {
      return const AnswerCell();
    }
    if (answer.data.contains(title)) {
      return const AnswerCell(answerColor: AnswerCellColor.red);
    }
    return const AnswerCell();
  }
}

class _EditableCell extends StatelessWidget {
  final QuestionSingle question;
  final Answer? answer;
  final String title;
  const _EditableCell({
    required this.question,
    required this.answer,
    required this.title,
  });

  void _handleClickOnCell(BuildContext context, String newAnswer) {
    context
        .read<TestingRouteStateModel>()
        .addAnswerSingle(question.order, newAnswer);
  }

  @override
  Widget build(BuildContext context) {
    if (answer is! AnswerSingle) {
      return AnswerCell(
        onTap: () => _handleClickOnCell(context, title),
      );
    }
    if ((answer as AnswerSingle).data.contains(title)) {
      return AnswerCell(
        answerColor: AnswerCellColor.green,
        onTap: () => _handleClickOnCell(context, title),
      );
    } else {
      return AnswerCell(
        onTap: () => _handleClickOnCell(context, title),
      );
    }
  }
}
