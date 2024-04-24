import 'package:client/models/answers/answer.dart';
import 'package:client/models/questions/question.dart';
import 'package:client/widgets/answer_cell.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import '../../../state_models/testing_route_state_model.dart';

class QuestionComplexAnswerField extends StatelessWidget {
  final int index;
  final QuestionComplex question;

  const QuestionComplexAnswerField(
      {Key? key, required this.index, required this.question})
      : super(key: key);

  void handleClickOnCell(
      BuildContext context, String newAnswerKey, String newAnswerValue) {
    context
        .read<TestingRouteStateModel>()
        .addAnswerComplex(question.order, newAnswerKey, newAnswerValue);
  }

  @override
  Widget build(BuildContext context) {
    if (question.answerMappingList.length != 2) {
      return Container();
    }

    final bool editable =
        context.read<TestingRouteStateModel>().prevSessionData?.isEditable ??
            true;
    final List<List<String>> variants = question.answerMappingList;

    return Container(
      margin: EdgeInsets.fromLTRB(0, 10.h, 0, 10.h),
      child: Selector<TestingRouteStateModel, dynamic>(
        selector: (_, model) => model.getAnswer(question.order),
        builder: (_, answer, __) {
          if (answer is! AnswerComplex?) {
            return const Text("AnswerComplex handling error");
          }

          return Column(
            children: [
              Row(
                children: [
                  Container(
                    width: 46.5.r,
                    height: 46.5.r,
                    margin: EdgeInsets.all(3.r),
                  ),
                  ...variants[1].map((variantHorizontal) => Container(
                        width: 46.5.r,
                        height: 46.5.r,
                        margin: EdgeInsets.all(3.r),
                        child: Center(
                          child: Text(variantHorizontal,
                              style: TextStyle(
                                  fontSize: 32.sp,
                                  fontWeight: FontWeight.w500)),
                        ),
                      )),
                ],
              ),
              ...variants[0].map((variantVertical) => Row(
                    children: [
                      Container(
                        width: 46.5.r,
                        height: 46.5.r,
                        margin: EdgeInsets.all(3.r),
                        child: Center(
                          child: Text(variantVertical,
                              style: TextStyle(
                                  fontSize: 32.sp,
                                  fontWeight: FontWeight.w500)),
                        ),
                      ),
                      ...variants[1].map((variantHorizontal) => Container(
                          margin: EdgeInsets.all(3.r),
                          child: Builder(builder: (BuildContext context) {
                            if (editable) {
                              if (answer?.data[variantVertical] ==
                                  variantHorizontal) {
                                return AnswerCell(
                                    answerColor: AnswerCellColor.green,
                                    onTap: () {
                                      handleClickOnCell(context,
                                          variantVertical, variantHorizontal);
                                    });
                              } else {
                                return AnswerCell(onTap: () {
                                  handleClickOnCell(context, variantVertical,
                                      variantHorizontal);
                                });
                              }
                            }
                            //if !editable
                            else {
                              if (question.correctMap[variantVertical] ==
                                  variantHorizontal) {
                                return AnswerCell(
                                    answerColor: AnswerCellColor.green,
                                    onTap: () {});
                              } else {
                                if (answer?.data[variantVertical] ==
                                    variantHorizontal) {
                                  return AnswerCell(
                                      answerColor: AnswerCellColor.red,
                                      onTap: () {});
                                }
                                return AnswerCell(onTap: () {});
                              }
                            }
                          })))
                    ],
                  ))
            ],
          );
        },
      ),
    );
  }
}
