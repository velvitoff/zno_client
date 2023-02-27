import 'package:client/models/testing_route_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

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

  late final ScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    _scrollController = FixedExtentScrollController(initialItem: 0);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    int selected = context.watch<TestingRouteModel>().getPageIndex();

    return SizedBox(
        height: 30.h,
        child: Stack(
          alignment: Alignment.center,
          children: [
            Container(
              height: 2.h,
              color: const Color(0xFFCECECE),
            ),
            ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: widget.itemCount,
              itemBuilder: (BuildContext context, int index) {
                return GestureDetector(
                  onTap: () {
                    context.read<TestingRouteModel>().jumpPage(index);
                  },
                  child: Container(
                    width: 30.w,
                    padding: EdgeInsets.all(3.r),
                    margin: EdgeInsets.fromLTRB(10.r, 0, 10.r, 0),
                    color: index == selected.toInt() ? Colors.blue : const Color(0xFFFAFAFA),
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
                );
              },
            )
          ],
        )
    );
  }
}

