import 'package:client/widgets/answer_cell.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import '../../../models/testing_route_model.dart';

class QuestionComplexAnswerField extends StatelessWidget {
  final int index;
  final List<List<String>> variants;

  const QuestionComplexAnswerField({
    Key? key,
    required this.index,
    required this.variants
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if(variants.length != 2){
      return Container();
    }

    return Container(
      width: 320.w,
      margin: EdgeInsets.fromLTRB(0, 10.h, 0, 10.h),
      child: Selector<TestingRouteModel, dynamic>(
        selector: (_, model) => model.getAnswer((index + 1).toString()),
        builder: (_, answer, __) {

          Map<String, String> answers;
          if (answer is Map){
            answers = Map.from(answer);
          }
          else{
            answers = {};
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
                  ...variants[1].map((variantHorizontal) =>
                      Container(
                        width: 46.5.r,
                        height: 46.5.r,
                        margin: EdgeInsets.all(3.r),
                        child: Center(
                          child: Text(variantHorizontal, style: TextStyle(fontSize: 32.sp, fontWeight: FontWeight.w500)),
                        ),
                      )
                  ),
                ],
              ),
              ...variants[0].map((variantVertical) =>
                  Row(
                    children: [
                      Container(
                        width: 46.5.r,
                        height: 46.5.r,
                        margin: EdgeInsets.all(3.r),
                        child: Center(
                          child: Text(variantVertical, style: TextStyle(fontSize: 32.sp, fontWeight: FontWeight.w500)),
                        ),
                      ),
                      ...variants[1].map((variantHorizontal) =>
                          Container(
                            margin: EdgeInsets.all(3.r),
                            child:
                            answers[variantVertical] == variantHorizontal
                                ?
                            AnswerCell(
                              marked: true,
                              onTap: () {},
                            )
                                :
                            AnswerCell(
                              onTap: () {
                                answers[variantVertical] = variantHorizontal;
                                context.read<TestingRouteModel>().addAnswer((index + 1).toString(), answers);
                              },
                            ),
                          )
                      )
                    ],
                  )
              )
            ],
          );
        },
      ),
    );
  }
}
