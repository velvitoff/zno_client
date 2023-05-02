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
    final realSize = MediaQuery.of(context).size;

    return Container(
        width: 320.w,
        height: 90.h,
        margin: EdgeInsets.fromLTRB(0, 10.h, 0, 10.h),
        child: Row(
            mainAxisAlignment: realSize.height > realSize.width ? MainAxisAlignment.center : MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: variants.map((variant) {
              return Container(
                margin: EdgeInsets.fromLTRB(0, 0, 10.w, 0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      variant,
                      style: TextStyle(fontSize: 32.sp, fontWeight: FontWeight.w500),
                    ),
                    Selector<TestingRouteModel, dynamic>(
                      selector: (_, model) => model.getAnswer((index + 1).toString()),
                      builder: (_, answer, __) {
                        if (answer is String && answer == variant){
                          return AnswerCell(
                            marked: true,
                            onTap: () {},
                          );
                        }
                        else{
                          return AnswerCell(
                            onTap: () => context.read<TestingRouteModel>().addAnswer((index + 1).toString(), variant),
                          );
                        }
                      },
                    )
                  ],
                ),
              );
            }
            ).toList()
        )
    );
  }
}

