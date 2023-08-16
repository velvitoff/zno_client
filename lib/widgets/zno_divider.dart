import 'package:client/models/testing_route_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class ZnoDivider extends StatefulWidget {
  final int activeIndex;
  final int itemCount;

  const ZnoDivider(
      {Key? key, required this.activeIndex, required this.itemCount})
      : super(key: key);

  @override
  State<ZnoDivider> createState() => _ZnoDividerState();
}

class _ZnoDividerState extends State<ZnoDivider> {
  late final ScrollController _scrollController;
  late final int selected;

  @override
  void initState() {
    super.initState();
    final TestingRouteModel model = context.read<TestingRouteModel>();
    selected = model.pageIndex + 1;
    _scrollController = ScrollController(initialScrollOffset: selected * 80.r);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
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
            ListView.builder(
              controller: _scrollController,
              scrollDirection: Axis.horizontal,
              itemCount: widget.itemCount + 2,
              itemBuilder: (BuildContext context, int index) {
                if (index == 0 || index == widget.itemCount + 1) {
                  return SizedBox(
                    width: 200.w,
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
                        width: 40.r,
                        height: 40.r,
                        padding: index != selected
                            ? EdgeInsets.all(6.r)
                            : EdgeInsets.all(3.r),
                        decoration: index != selected
                            ? const BoxDecoration(
                                color: Color(0xFFFAFAFA),
                              )
                            : BoxDecoration(
                                color: const Color(0xFFFAFAFA),
                                border: Border.all(
                                    width: 3.r, color: const Color(0xFF418C4A)),
                                borderRadius:
                                    const BorderRadius.all(Radius.circular(5))),
                        child: FittedBox(
                          fit: BoxFit.contain,
                          child: Center(
                            child: Text(
                              '$index',
                              style: TextStyle(
                                  fontSize: 20.sp,
                                  color: const Color(0xFF787878),
                                  fontWeight: FontWeight.w400),
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
