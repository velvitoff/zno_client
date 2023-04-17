import 'package:client/routes.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

class ZnoMoreDropdown extends StatefulWidget {
  const ZnoMoreDropdown({Key? key}) : super(key: key);

  @override
  State<ZnoMoreDropdown> createState() => _ZnoMoreDropdownState();
}

class _ZnoMoreDropdownState extends State<ZnoMoreDropdown> {

  void onChoice(String value) {
    if (value == 'Вийти') {
      //TODO: call a modal window to confirm
      //TODO: call storage service to save history file
      context.go(Routes.subjectsRoute);
    }
    else if (value == 'Налаштування') {

    }
  }

  @override
  Widget build(BuildContext context) {
    return DropdownButtonHideUnderline(
      child: DropdownButton2(
          dropdownWidth: 160.w,
          itemHeight: 50.h,
          dropdownDecoration: const BoxDecoration(
            color: Colors.white
          ),
          customButton: Icon(
            Icons.more_vert,
            size: 36.sp,
            color: Colors.white,
          ),
          items: ['Налаштування', 'Вийти'].map((item) =>
              DropdownMenuItem(
                value: item,
                child: Text(
                  item,
                  style: TextStyle(
                    fontSize: 20.sp,
                    fontWeight: FontWeight.w400
                  ),
                ),
              )
          ).toList(),
          onChanged: (String? newValue) => onChoice(newValue!),
      ),
    );
  }
}
