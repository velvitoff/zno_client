import 'package:client/models/testing_route_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:listview_utils/listview_utils.dart';

import '../dto/question_data.dart';

class ZnoDivider extends StatefulWidget {
  final int activeIndex;
  final int itemCount;

  const ZnoDivider({
    Key? key,
    required this.activeIndex,
    required this.itemCount
  }) : super(key: key);

  @override
  State<ZnoDivider> createState() => _ZnoDividerState();
}

class _ZnoDividerState extends State<ZnoDivider> {

  final double headerWidth = 130.w;
  late final ScrollController _scrollController;
  late final int selected;
  late final bool _isViewMode;
  late final List<Question>? _questions;
  late final Map<String, dynamic>? _answers;

  @override
  void initState() {
    super.initState();
    final TestingRouteModel model = context.read<TestingRouteModel>();
    selected = model.getPageIndex();
    _scrollController = ScrollController(initialScrollOffset: selected * 80.r);
    _isViewMode = model.prevSessionData?.completed ?? false;
    if(_isViewMode) {
      _questions = model.questions;
      _answers = model.allAnswers;
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  Color getCellColor(int ind) {
    if(!_isViewMode) {
      return const Color(0xFFFAFAFA);
    }

    if (_questions != null && _answers != null) {
      if(_questions![ind+1].single != null) {
        String index = (ind+1).toString();
        if(_answers![index] == null) {
          return const Color(0xFFFAFAFA);
        }
        if(_questions![ind+1].single!.correct == _answers![index]) {
          return const Color(0xFF49BA49);
        }
        else {
          return const Color(0xFFD04352);
        }
      }
      
      if (_questions![ind+1].complex != null) {
        return const Color(0xFFFAFAFA);
      }
      else {
        return const Color(0xFFFAFAFA);
      }
    }
    else {
      return const Color(0xFFFAFAFA);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 40.h,
        margin: EdgeInsets.fromLTRB(0, 10.h, 0, 5.h),
        child: Stack(
          alignment: Alignment.center,
          children: [
            Container(
              height: 2.h,
              color: const Color(0xFFCECECE),
            ),
            CustomListView(
              header: SizedBox(
                width: headerWidth,
              ),
              footer: SizedBox(
                width: headerWidth,
              ),
              controller: _scrollController,
              scrollDirection: Axis.horizontal,
              itemCount: widget.itemCount,
              itemBuilder: (BuildContext context, int index, _) {
                return GestureDetector(
                  onTap: () {
                    context.read<TestingRouteModel>().jumpPage(index);
                  },
                  child: Container(
                    width: 50.r,
                    height: 50.r,
                    margin: EdgeInsets.fromLTRB(15.r, 0, 15.r, 0),
                    color: const Color(0xFFFAFAFA),
                    child: Center(
                      child: Container(
                        width: 40.r,
                        height: 40.r,
                        padding: index != selected ? EdgeInsets.all(6.r) : EdgeInsets.all(3.r),
                        decoration: index != selected
                            ? BoxDecoration(
                              color: getCellColor(index),
                            )
                            : BoxDecoration(
                            color: getCellColor(index),
                            border: Border.all(
                              width: 3.r,
                              color: const Color(0xFF418C4A)
                            ),
                          borderRadius: const BorderRadius.all(Radius.circular(5))
                        ),
                        child: FittedBox(
                          fit: BoxFit.contain,
                          child: Center(
                            child: Text(
                              '${index + 1}',
                              style: TextStyle(
                                  fontSize: 20.sp,
                                  color: const Color(0xFF787878),
                                  fontWeight: FontWeight.w400
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
        )
    );
  }
}

