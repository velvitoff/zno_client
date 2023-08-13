import 'package:client/dto/question_data.dart';
import 'package:client/models/testing_route_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import '../../../widgets/answer_cell.dart';

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
    final bool editable = !context.read<TestingRouteModel>().isViewMode;
    final List<String> variants = question.answerList;

    return Container(
        width: 320.w,
        margin: EdgeInsets.fromLTRB(0, 10.h, 0, 10.h),
        child: Wrap(
            alignment: WrapAlignment.center,
            children: variants.map((variant) {
              return Container(
                margin: EdgeInsets.fromLTRB(0, 0, 10.w, 0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      variant,
                      style: TextStyle(
                          fontSize: 32.sp, fontWeight: FontWeight.w500),
                    ),
                    Selector<TestingRouteModel, dynamic>(
                      selector: (_, model) =>
                          model.getAnswer((index + 1).toString()),
                      builder: (_, answer, __) {
                        if (editable) {
                          if (answer is String && answer == variant) {
                            return AnswerCell(
                                answerColor: AnswerCellColor.green,
                                onTap: () {});
                          } else {
                            return AnswerCell(
                                onTap: () => context
                                    .read<TestingRouteModel>()
                                    .addAnswer(
                                        (index + 1).toString(), variant));
                          }
                        }
                        //!editable
                        else {
                          if (question.correct == variant) {
                            return AnswerCell(
                                answerColor: AnswerCellColor.green,
                                onTap: () {});
                          } else {
                            if (answer is String && answer == variant) {
                              return AnswerCell(
                                  answerColor: AnswerCellColor.red,
                                  onTap: () {});
                            }
                            return AnswerCell(onTap: () {});
                          }
                        }
                      },
                    )
                  ],
                ),
              );
            }).toList()));
  }
}
