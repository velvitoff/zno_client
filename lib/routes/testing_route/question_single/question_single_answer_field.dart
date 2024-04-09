import 'package:client/dto/answers/answer.dart';
import 'package:client/dto/questions/question.dart';
import 'package:client/models/testing_route_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import '../../../widgets/answer_cell.dart';

class QuestionSingleAnswerField extends StatelessWidget {
  final QuestionSingle question;
  final int index;

  const QuestionSingleAnswerField(
      {Key? key, required this.question, required this.index})
      : super(key: key);

  void handleClickOnCell(BuildContext context, String newAnswer) {
    context
        .read<TestingRouteModel>()
        .addAnswerSingle(question.order, newAnswer);
  }

  @override
  Widget build(BuildContext context) {
    final bool editable = !context.read<TestingRouteModel>().isViewMode;
    final List<String> variants = question.answerList;

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
                    style:
                        TextStyle(fontSize: 32.sp, fontWeight: FontWeight.w500),
                  ),
                  Selector<TestingRouteModel, Answer?>(
                    selector: (_, model) => model.getAnswer(question.order),
                    builder: (_, answer, __) {
                      if (answer is! AnswerSingle) {
                        return AnswerCell(
                            onTap: () => handleClickOnCell(context, variant));
                      }
                      if (editable) {
                        if (answer.data.contains(variant)) {
                          return AnswerCell(
                            answerColor: AnswerCellColor.green,
                            onTap: () => handleClickOnCell(context, variant),
                          );
                        }
                        return AnswerCell(
                            onTap: () => handleClickOnCell(context, variant));
                      }
                      //!editable
                      else {
                        if (question.correct.contains(variant)) {
                          return const AnswerCell(
                              answerColor: AnswerCellColor.green);
                        }
                        if (answer.data.contains(variant)) {
                          return const AnswerCell(
                              answerColor: AnswerCellColor.red);
                        }
                        return const AnswerCell();
                      }
                    },
                  )
                ],
              );
            }).toList()));
  }
}
