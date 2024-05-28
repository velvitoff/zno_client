import 'package:client/widgets/zno_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ComplaintDialog extends StatefulWidget {
  const ComplaintDialog({super.key});

  @override
  State<ComplaintDialog> createState() => _ComplaintDialogState();
}

class _ComplaintDialogState extends State<ComplaintDialog> {
  String userText = "";

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Container(
        width: 280.w,
        height: 300.h,
        padding: EdgeInsets.fromLTRB(6.w, 14.h, 6.w, 14.h),
        decoration: const BoxDecoration(
            color: Color(0xFFF5F5F5),
            borderRadius: BorderRadius.all(Radius.circular(5))),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Повідомити про помилку',
              style: TextStyle(fontSize: 24.sp),
              textAlign: TextAlign.center,
            ),
            Expanded(
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 20.h),
                child: TextField(
                    cursorColor: Colors.black,
                    expands: true,
                    enabled: true,
                    maxLines: null,
                    minLines: null,
                    textAlignVertical: TextAlignVertical.top,
                    onChanged: (String value) {
                      userText = value;
                    },
                    decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Color(0xFF418C4A))))),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ZnoButton(
                  onTap: () => Navigator.pop(context, null),
                  width: 100.w,
                  height: 50.h,
                  text: 'Скасувати',
                  fontSize: 20.sp,
                ),
                SizedBox(
                  width: 30.w,
                ),
                ZnoButton(
                  onTap: () {
                    if (userText.isNotEmpty) {
                      Navigator.pop(context, userText);
                    }
                  },
                  width: 100.w,
                  height: 50.h,
                  text: 'Надіслати',
                  fontSize: 20.sp,
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
