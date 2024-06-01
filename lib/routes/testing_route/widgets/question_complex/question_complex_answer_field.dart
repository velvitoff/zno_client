import 'package:client/models/answers/answer.dart';
import 'package:client/models/questions/question.dart';
import 'package:client/routes/testing_route/state/testing_route_state_model.dart';
import 'package:client/widgets/answer_cell.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class QuestionComplexAnswerField extends StatelessWidget {
  final int index;
  final QuestionComplex question;

  const QuestionComplexAnswerField({
    Key? key,
    required this.index,
    required this.question,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (question.answerMappingList.length != 2) {
      return Container();
    }

    final bool editable = !context.read<TestingRouteStateModel>().isViewMode;
    final List<List<String>> variants = question.answerMappingList;
    final Answer? answer = context.select<TestingRouteStateModel, Answer?>(
        (model) => model.getAnswer(question.order));
    if (answer is! AnswerComplex?) {
      return const Text("AnswerComplex handling error");
    }

    return Container(
      margin: EdgeInsets.fromLTRB(0, 10.h, 0, 10.h),
      child: Column(
        children: [
          _HeaderRow(listOfLetters: variants[1]),
          ...variants[0].map(
            (variantVertical) => _AnswersRow(
              title: variantVertical,
              question: question,
              answer: answer,
              horizontalList: variants[1],
              editable: editable,
            ),
          ),
        ],
      ),
    );
  }
}

class _HeaderRow extends StatelessWidget {
  final List<String> listOfLetters;
  const _HeaderRow({required this.listOfLetters});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 46.5.r,
          height: 46.5.r,
          margin: EdgeInsets.all(3.r),
        ),
        ...listOfLetters.map((variantHorizontal) => Container(
              width: 46.5.r,
              height: 46.5.r,
              margin: EdgeInsets.all(3.r),
              child: Center(
                child: Text(
                  variantHorizontal,
                  style: TextStyle(
                    fontSize: 32.sp,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            )),
      ],
    );
  }
}

class _AnswersRow extends StatelessWidget {
  final String title;
  final QuestionComplex question;
  final AnswerComplex? answer;
  final List<String> horizontalList;
  final bool editable;
  const _AnswersRow({
    required this.title,
    required this.question,
    required this.answer,
    required this.horizontalList,
    required this.editable,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 46.5.r,
          height: 46.5.r,
          margin: EdgeInsets.all(3.r),
          child: Center(
            child: Text(
              title,
              style: TextStyle(
                fontSize: 32.sp,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ),
        ...horizontalList.map(
          (variantHorizontal) => Container(
            margin: EdgeInsets.all(3.r),
            child: editable
                ? _EditableCell(
                    question: question,
                    answer: answer,
                    title: title,
                    variantHorizontal: variantHorizontal,
                  )
                : _NotEditableCell(
                    question: question,
                    answer: answer,
                    title: title,
                    variantHorizontal: variantHorizontal,
                  ),
          ),
        ),
      ],
    );
  }
}

class _EditableCell extends StatelessWidget {
  final QuestionComplex question;
  final AnswerComplex? answer;
  final String title;
  final String variantHorizontal;

  const _EditableCell({
    required this.question,
    required this.answer,
    required this.title,
    required this.variantHorizontal,
  });

  void _handleClickOnCell(
    BuildContext context,
    String newAnswerKey,
    String newAnswerValue,
  ) {
    context.read<TestingRouteStateModel>().addAnswerComplex(
          question.order,
          newAnswerKey,
          newAnswerValue,
        );
  }

  @override
  Widget build(BuildContext context) {
    if (answer?.data[title] == variantHorizontal) {
      return AnswerCell(
        answerColor: AnswerCellColor.green,
        onTap: () => _handleClickOnCell(context, title, variantHorizontal),
      );
    }

    return AnswerCell(
      onTap: () => _handleClickOnCell(context, title, variantHorizontal),
    );
  }
}

class _NotEditableCell extends StatelessWidget {
  final QuestionComplex question;
  final AnswerComplex? answer;
  final String title;
  final String variantHorizontal;

  const _NotEditableCell({
    required this.question,
    required this.answer,
    required this.title,
    required this.variantHorizontal,
  });

  @override
  Widget build(BuildContext context) {
    if (question.correctMap[title] == variantHorizontal) {
      return const AnswerCell(answerColor: AnswerCellColor.green);
    }

    if (answer?.data[title] == variantHorizontal) {
      return const AnswerCell(answerColor: AnswerCellColor.red);
    }

    return const AnswerCell();
  }
}
