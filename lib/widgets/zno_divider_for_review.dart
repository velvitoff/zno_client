import 'package:client/models/testing_route_model.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import '../dto/questions/question_data.dart';

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
  late final Map<String, dynamic>? _answers;

  static Color greenColor = const Color(0xAA34af34);
  static Color whiteColor = const Color(0xFFFAFAFA);
  static Color redColor = const Color(0x99D32335);
  static Color orangeColor = const Color(0xAAf29924);

  @override
  void initState() {
    super.initState();
    final TestingRouteModel model = context.read<TestingRouteModel>();
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

    if (_answers![index] == null) {
      return whiteColor;
    }

    switch (_questions![ind]) {
      case QuestionSingle():
        if (_answers![index] == null) return whiteColor;
        if ((_questions![ind] as QuestionSingle).correct == _answers![index]) {
          return greenColor;
        }
        return redColor;
      case QuestionComplex():
        final answers = Map<String, String>.from(_answers![index]);
        if (_answers!.isEmpty) {
          return whiteColor;
        }

        if (mapEquals(
            (_questions![ind] as QuestionComplex).correctMap, answers)) {
          return greenColor;
        }

        bool isPartiallyCorrect = false;
        for (var entry in answers.entries) {
          if ((_questions![ind] as QuestionComplex).correctMap[entry.key] ==
              entry.value) {
            isPartiallyCorrect = true;
            break;
          }
        }

        if (isPartiallyCorrect) {
          return orangeColor;
        }
        return redColor;
      case QuestionTextFields():
        List<String> answers;
        try {
          answers = List<String>.from(_answers![index]);
        } catch (_) {
          return whiteColor;
        }

        if (listEquals((_questions![ind] as QuestionTextFields).correctList,
                answers) ||
            listEquals(
                (_questions![ind] as QuestionTextFields)
                    .correctList
                    .map((x) => x.replaceAll('.', ','))
                    .toList(),
                answers)) {
          return greenColor;
        }

        bool isPartiallyCorrect = false;
        for (int i = 0; i < answers.length; ++i) {
          if (answers[i] ==
              (_questions![ind] as QuestionTextFields).correctList[i]) {
            isPartiallyCorrect = true;
            break;
          }
        }

        if (isPartiallyCorrect) {
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
                    context.read<TestingRouteModel>().jumpPage(index - 1);
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
