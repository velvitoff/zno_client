import 'package:client/widgets/zno_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class InfoDialog extends StatefulWidget {
  final String text;
  const InfoDialog({super.key, required this.text});

  @override
  State<InfoDialog> createState() => _InfoDialogState();
}

class _InfoDialogState extends State<InfoDialog> {
  late final ScrollController scrollController;

  @override
  void initState() {
    super.initState();
    scrollController = ScrollController();
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Container(
        width: 280.w,
        height: 460.h,
        padding: EdgeInsets.fromLTRB(6.w, 14.h, 6.w, 14.h),
        decoration: const BoxDecoration(
            color: Color(0xFFFAFAFA),
            borderRadius: BorderRadius.all(Radius.circular(2))),
        child: SingleChildScrollView(
          controller: scrollController,
          child: Column(
            children: [
              Text(
                widget.text,
                style: TextStyle(fontSize: 24.sp),
                textAlign: TextAlign.center,
              ),
              ZnoButton(
                onTap: () => Navigator.pop(context),
                width: 100.w,
                height: 50.h,
                text: 'Добре',
                fontSize: 20.sp,
              )
            ],
          ),
        ),
      ),
    );
  }
}
