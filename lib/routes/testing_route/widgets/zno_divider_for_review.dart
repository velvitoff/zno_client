import 'package:client/models/answers/answer.dart';
import 'package:client/routes/testing_route/state/testing_route_state_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import '../../../models/questions/question.dart';

//TODO: improve performance
class ZnoDividerForReview extends StatefulWidget {
  final int activeIndex;
  final int itemCount;

  const ZnoDividerForReview(
      {Key? key, required this.activeIndex, required this.itemCount})
      : super(key: key);

  @override
  State<ZnoDividerForReview> createState() => _ZnoDividerState();
}

class _ZnoDividerState extends State<ZnoDividerForReview> {
  late final ScrollController _scrollController;
  late final int selected;
  late final List<Question>? _questions;
  late final Map<String, Answer?>? _answers;

  static Color greenColor = const Color(0xAA34af34);
  static Color whiteColor = const Color(0xFFFAFAFA);
  static Color redColor = const Color(0x99D32335);
  static Color orangeColor = const Color(0xAAf29924);

  @override
  void initState() {
    super.initState();
    final TestingRouteStateModel model = context.read<TestingRouteStateModel>();
    selected = model.pageIndex + 1;
    _scrollController = ScrollController(initialScrollOffset: selected * 80.r);
    _questions = model.questions;
    _answers = model.allAnswers;
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  Color getCellColor(int ind) {
    if (_questions == null || _answers == null) {
      return whiteColor;
    }

    String index = (ind + 1).toString();

    if (_questions![ind] is QuestionNoAnswer) {
      return whiteColor;
    }
    if (_answers![index] == null) {
      return redColor;
    }

    switch (_questions![ind]) {
      case QuestionSingle():
        if (_answers![index] is! AnswerSingle) {
          return whiteColor;
        }
        final score = (_questions![ind] as QuestionSingle)
            .getScore((_answers![index] as AnswerSingle));
        if (score.scoringEnum == ScoringEnum.correct) {
          return greenColor;
        }
        return redColor;
      case QuestionComplex():
        if (_answers![index] is! AnswerComplex) {
          return whiteColor;
        }
        final answer = (_answers![index] as AnswerComplex);
        if (answer.data.isEmpty) {
          return whiteColor;
        }
        final score = (_questions![ind] as QuestionComplex).getScore(answer);

        if (score.isCorrect) {
          return greenColor;
        }

        if (score.isPartial) {
          return orangeColor;
        }
        return redColor;
      case QuestionTextFields():
        if (_answers![index] is! AnswerTextFields) {
          return whiteColor;
        }
        final answer = (_answers![index] as AnswerTextFields);
        final score = (_questions![ind] as QuestionTextFields).getScore(answer);

        if (score.isCorrect) {
          return greenColor;
        }

        if (score.isPartial) {
          return orangeColor;
        }
        return redColor;
      case QuestionNoAnswer():
        return whiteColor;
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final listHeaderWidth = screenWidth / 2 + 80.r / 2;

    return Container(
        height: 43.h,
        margin: EdgeInsets.fromLTRB(0, 10.h, 0, 5.h),
        child: Stack(
          alignment: Alignment.center,
          children: [
            Container(
              height: 2.h,
              color: const Color(0xFFCECECE),
            ),
            ListView.builder(
              controller: _scrollController,
              scrollDirection: Axis.horizontal,
              itemCount: widget.itemCount + 2,
              itemBuilder: (BuildContext context, int index) {
                if (index == 0 || index == widget.itemCount + 1) {
                  return SizedBox(
                    width: listHeaderWidth,
                  );
                }
                return GestureDetector(
                  onTap: () {
                    context.read<TestingRouteStateModel>().jumpPage(index - 1);
                  },
                  child: Container(
                    width: 50.r,
                    height: 50.r,
                    margin: EdgeInsets.fromLTRB(15.r, 0, 15.r, 0),
                    color: const Color(0xFFFAFAFA),
                    child: Center(
                      child: Container(
                        width: 43.r,
                        height: 43.r,
                        padding: index == selected ? null : EdgeInsets.all(3.r),
                        decoration: index == selected
                            ? BoxDecoration(
                                border: Border.all(
                                    width: 3.r, color: const Color(0xFF418C4A)),
                                borderRadius:
                                    const BorderRadius.all(Radius.circular(5)))
                            : null,
                        child: Container(
                          padding: EdgeInsets.all(4.r),
                          decoration: BoxDecoration(
                              color: getCellColor(index - 1),
                              borderRadius: index == selected
                                  ? null
                                  : const BorderRadius.all(Radius.circular(5))),
                          child: FittedBox(
                            fit: BoxFit.contain,
                            child: Center(
                              child: Text(
                                '$index',
                                style: TextStyle(
                                    fontSize: 20.sp,
                                    color: const Color(0xFF242424),
                                    fontWeight: FontWeight.w400),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                );
              },
            )
          ],
        ));
  }
}
