import 'package:client/models/testing_route_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import '../../../widgets/answer_cell.dart';

class QuestionSingleAnswerField extends StatelessWidget {
  final List<String> variants;
  final int index;

  const QuestionSingleAnswerField({
    Key? key,
    required this.variants,
    required this.index
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        width: 310.w,
        height: 90.h,
        child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: variants.map((variant) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    variant,
                    style: TextStyle(fontSize: 32.sp, fontWeight: FontWeight.w500),
                  ),
                  Selector<TestingRouteModel, dynamic>(
                    selector: (_, model) => model.getAnswer(index),
                    builder: (_, answer, __) {
                      if (answer is String && answer == variant){
                        return AnswerCell(
                          marked: true,
                          onTap: () => {},
                        );
                      }
                      else{
                        return AnswerCell(
                          onTap: () => context.read<TestingRouteModel>().addAnswer(index, variant),
                        );
                      }
                    },
                  )
                ],
              );
            }
            ).toList()
        )
    );
  }
}

